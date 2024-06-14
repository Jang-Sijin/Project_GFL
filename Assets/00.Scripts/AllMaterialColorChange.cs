using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AllMaterialColorChange : MonoBehaviour
{
    // 변경할 색상
    public Color NewColor;

    // 모든 머테리얼을 가져옵니다.
    public Material[] Materials;

    void Start()
    {
        // 이 오브젝트에 할당된 Renderer를 가져옵니다.
        Renderer renderer = GetComponent<Renderer>();

        // 각 머테리얼의 색상을 변경합니다.
        foreach (Material material in Materials)
        {
            material.color = NewColor;
        }
    }
}