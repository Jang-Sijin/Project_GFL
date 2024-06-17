using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class LoadProgressHandler
{
    // 매니저 총 개수로 로딩 진행 상황을 체크한다.
    public int CurrentProgressCounter { get; set; }
    public int MaxProgressCounter { get; private set; }

    private Tweener _checkProgressTweener;    
    private Slider _loadingbarSlider;
    private TextMeshProUGUI _loadingbarValueTextMsth;
    private GameObject _loadingCanvas;
    private float _completedDelay = 3f;

    public void InitLoadUI()
    {
        CurrentProgressCounter = 0;
        MaxProgressCounter = 4;

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
        }        

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

        // 로딩 캔버스 삭제 또는 완료 처리
        Object.Destroy(_loadingCanvas);

        Managers.Sound.Play(Define.SoundType.Bgm, "Sound_Login_Loop");
    }
}
