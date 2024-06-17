using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AllMaterialColorChange : MonoBehaviour
{
    // 변경할 색상 데이터
    public Color NewColor;

    // 모든 머테리얼을 가져온다.
    public Material[] Materials;

    void Start()
    {
        // 이 오브젝트에 할당된 Renderer를 가져온다.
        Renderer renderer = GetComponent<Renderer>();

        // 각 머테리얼의 색상을 변경한다.
        foreach (Material material in Materials)
        {
            material.color = NewColor;
        }
    }
}