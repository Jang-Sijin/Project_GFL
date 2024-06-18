using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

// #추후 팝업 UI로 대체가 필요합니다. 완료 시 해당 주석 삭제 부탁드립니다.
public class LoadProgressHandler : MonoBehaviour
{
    // 매니저 총 개수로 로딩 진행 상황을 체크한다.
    public int CurrentProgressCounter { get; set; }
    public int MaxProgressCounter { get; private set; }
    public bool IsLoaded { get { return _isLoaded; } }

    private Tweener _checkProgressTweener;    
    private Slider _loadingbarSlider;
    private TextMeshProUGUI _loadingbarValueTextMsth;
    private GameObject _loadingCanvas;
    private float _completedDelay = 3f;
    private bool _isLoaded = false;

    public void InitLoadUI()
    {
        _isLoaded = false;
        CurrentProgressCounter = 0;
        MaxProgressCounter = 3;

        // 0. 로딩 화면 캔버스 불러오기
        string loadingCanvasText = "Loading_Canvas";
        _loadingCanvas = GameObject.Find(loadingCanvasText);        
        if (_loadingCanvas == null)
        {
            Debug.Log($"{loadingCanvasText}가 Scene에 존재하지 않아, 새롭게 생성합니다.");

            GameObject canvasPrefab = Resources.Load<GameObject>($"Prefabs/{loadingCanvasText}");

            if (canvasPrefab == null)
            {
                Debug.LogError($"{loadingCanvasText} 프리팹을 찾을 수 없습니다. 경로를 확인하세요.");

                return;
            }

            _loadingCanvas = Object.Instantiate(canvasPrefab);
            _loadingCanvas.name = loadingCanvasText;
        }

        // RootUI 세팅 - sorting Order
        //_loadingCanvas.GetOrAddComponent<Canvas>().sortingOrder = 100;      

        // 컴포넌트 세팅
        GameObject FindTextSlider = Managers.Resource.FindChildByName(_loadingCanvas.transform, Define.loadingbarSlider);
        GameObject FindTextMesh = Managers.Resource.FindChildByName(_loadingCanvas.transform, Define.loadingbarValueTextMesh);
        _loadingbarSlider = FindTextSlider.GetComponent<Slider>();
        _loadingbarValueTextMsth = FindTextMesh.GetComponent<TextMeshProUGUI>();

        // 컴포넌트 값 세팅
        _loadingbarSlider.value = 0;
    }

    public void UpdateProgress(int addProgress = 1)
    {
        // 현재 진행 퍼센트 계산
        float beforeProgressPercent = (float)CurrentProgressCounter / MaxProgressCounter;

        // 다음 진행 퍼센트 계산
        CurrentProgressCounter += addProgress;
        float nextProgressPercent = (float)CurrentProgressCounter / MaxProgressCounter;

        // DOTween Tweener 생성 및 업데이트
        if (_checkProgressTweener != null && _checkProgressTweener.IsActive())
        {
            _checkProgressTweener.ChangeEndValue(nextProgressPercent, 1f);
        }
        else
        {
            _checkProgressTweener = DOTween.To(() => _loadingbarSlider.value, x => _loadingbarSlider.value = x, nextProgressPercent, 1f)
                .OnUpdate(() =>
                {
                    _loadingbarValueTextMsth.text = (_loadingbarSlider.value * 100).ToString("F2") + "%";
                });
        }        

        // 모든 리소스 불러오기 완료
        if (CurrentProgressCounter >= MaxProgressCounter)
        {            
            // 로딩 캔버스 삭제
            Managers.Instance.StartCoroutine(DestroyLoadingCanvasAfterDelay(_completedDelay));            
        }        
    }

    private IEnumerator DestroyLoadingCanvasAfterDelay(float delay)
    {
        yield return new WaitForSeconds(delay);

        // 모든 리소스 불러오기 완료 처리
        _isLoaded = true;

        // 로딩 캔버스 삭제 또는 완료 처리
        Object.Destroy(_loadingCanvas);        
    }
}
