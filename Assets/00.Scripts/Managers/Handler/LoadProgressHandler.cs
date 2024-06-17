using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class LoadProgressHandler
{
    // �Ŵ��� �� ������ �ε� ���� ��Ȳ�� üũ�Ѵ�.
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
        }        

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

        // �ε� ĵ���� ���� �Ǵ� �Ϸ� ó��
        Object.Destroy(_loadingCanvas);

        Managers.Sound.Play(Define.SoundType.Bgm, "Sound_Login_Loop");
    }
}
