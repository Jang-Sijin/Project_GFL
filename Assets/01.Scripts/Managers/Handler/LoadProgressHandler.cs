using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

// #���� �˾� UI�� ��ü�� �ʿ��մϴ�. �Ϸ� �� �ش� �ּ� ���� ��Ź�帳�ϴ�.
public class LoadProgressHandler : MonoBehaviour
{
    // �Ŵ��� �� ������ �ε� ���� ��Ȳ�� üũ�Ѵ�.
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

        // 0. �ε� ȭ�� ĵ���� �ҷ�����
        string loadingCanvasText = "Loading_Canvas";
        _loadingCanvas = GameObject.Find(loadingCanvasText);        
        if (_loadingCanvas == null)
        {
            Debug.Log($"{loadingCanvasText}�� Scene�� �������� �ʾ�, ���Ӱ� �����մϴ�.");

            GameObject canvasPrefab = Resources.Load<GameObject>($"Prefabs/{loadingCanvasText}");

            if (canvasPrefab == null)
            {
                Debug.LogError($"{loadingCanvasText} �������� ã�� �� �����ϴ�. ��θ� Ȯ���ϼ���.");

                return;
            }

            _loadingCanvas = Object.Instantiate(canvasPrefab);
            _loadingCanvas.name = loadingCanvasText;
        }

        // RootUI ���� - sorting Order
        //_loadingCanvas.GetOrAddComponent<Canvas>().sortingOrder = 100;      

        // ������Ʈ ����
        GameObject FindTextSlider = Managers.Resource.FindChildByName(_loadingCanvas.transform, Define.loadingbarSlider);
        GameObject FindTextMesh = Managers.Resource.FindChildByName(_loadingCanvas.transform, Define.loadingbarValueTextMesh);
        _loadingbarSlider = FindTextSlider.GetComponent<Slider>();
        _loadingbarValueTextMsth = FindTextMesh.GetComponent<TextMeshProUGUI>();

        // ������Ʈ �� ����
        _loadingbarSlider.value = 0;
    }

    public void UpdateProgress(int addProgress = 1)
    {
        // ���� ���� �ۼ�Ʈ ���
        float beforeProgressPercent = (float)CurrentProgressCounter / MaxProgressCounter;

        // ���� ���� �ۼ�Ʈ ���
        CurrentProgressCounter += addProgress;
        float nextProgressPercent = (float)CurrentProgressCounter / MaxProgressCounter;

        // DOTween Tweener ���� �� ������Ʈ
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

        // ��� ���ҽ� �ҷ����� �Ϸ�
        if (CurrentProgressCounter >= MaxProgressCounter)
        {            
            // �ε� ĵ���� ����
            Managers.Instance.StartCoroutine(DestroyLoadingCanvasAfterDelay(_completedDelay));            
        }        
    }

    private IEnumerator DestroyLoadingCanvasAfterDelay(float delay)
    {
        yield return new WaitForSeconds(delay);

        // ��� ���ҽ� �ҷ����� �Ϸ� ó��
        _isLoaded = true;

        // �ε� ĵ���� ���� �Ǵ� �Ϸ� ó��
        Object.Destroy(_loadingCanvas);        
    }
}
