using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class LoadProgressHandler : MonoBehaviour
{
    public static int ProgressCounter { get; set; }

    private Slider _loadingbarSlider;
    private TextMeshProUGUI _loadingbarValueTextMsth;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void InitLoadUI(GameObject goLoadingCanvas)
    {
        // Find�� �� ��ü ã�� �� ������Ʈ �ҷ����� ������� ���� �ʿ�
        // _loadingbarSlider = goLoadingCanvas.GetComponent<Slider>();
        // _loadingbarValueTextMsth = goLoadingCanvas.GetComponent<TextMeshProUGUI>();
    }
}
