using DG.Tweening;
using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEditor.SearchService;
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


    // �� ���� ����� ĵ����    
    private GameObject _changeSceneCanvas;
    public GameObject ChangeSceneCanvas 
    {
        get { return _changeSceneCanvas; }
        set { _changeSceneCanvas = value; }
    }

    public void InitLoadUI()
    {
        _isLoaded = false;
        CurrentProgressCounter = 0;
        MaxProgressCounter = 3;

        // 0. �ε� ȭ�� ĵ���� �ҷ�����        
        if (_loadingCanvas == null)
        {
            string loadingCanvasText = "Loading_Canvas";
            _loadingCanvas = GameObject.Find(loadingCanvasText);

            if(_loadingCanvas == null)
            {
                Debug.Log($"{loadingCanvasText}�� Scene�� �������� �ʾ�, ���Ӱ� �����մϴ�.");

            GameObject canvasPrefab = Resources.Load<GameObject>($"Prefabs/{loadingCanvasText}");

                if (canvasPrefab == null)
                {
                    Debug.LogError($"{loadingCanvasText} �������� ã�� �� �����ϴ�. ��θ� Ȯ���ϼ���.");

                    return;
                }

                    _loadingCanvas = UnityEngine.Object.Instantiate(canvasPrefab);
            }
            _loadingCanvas.name = loadingCanvasText;
        }

        // 1. �� ��ȯ �ε� ȭ�� ĵ���� �ҷ����� // Managers ������Ʈ ������ ��ġ
        if (_changeSceneCanvas == null)
        {
            _changeSceneCanvas = Utils.FindChild(Managers.Instance.gameObject, Define.ChangeSceneLoadingCanvas);

            if (_changeSceneCanvas == null)
            {
                Debug.Log($"{Define.ChangeSceneLoadingCanvas}�� Scene�� �������� �ʾ�, ���Ӱ� �����մϴ�.");

                GameObject canvasPrefab = Resources.Load<GameObject>($"Prefabs/{Define.ChangeSceneLoadingCanvas}");
                Debug.Log(canvasPrefab);

                // �θ� ����
                Transform parentTransform = Managers.Instance.transform;

                // �������� �θ��� �ڽ����� ����
                _changeSceneCanvas = Instantiate(canvasPrefab, parentTransform);
                _changeSceneCanvas.name = Define.ChangeSceneLoadingCanvas;
                _changeSceneCanvas.SetActive(false);
            }            
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
        UnityEngine.Object.Destroy(_loadingCanvas);
    }

    //public void ShowChageSceneUI(Action callback = null)
    //{
    //    ChangeSceneCanvas.SetActive(true);
    //    callback?.Invoke();      

    //    DisableChangeSceneCanvas();        
    //}

    //private IEnumerator DisableChangeSceneCanvas()
    //{
    //    yield return new WaitForSeconds(_completedDelay);

    //    ChangeSceneCanvas.SetActive(false);
    //}
}
