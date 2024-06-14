using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AllMaterialColorChange : MonoBehaviour
{
    // ������ ����
    public Color NewColor;

    // ��� ���׸����� �����ɴϴ�.
    public Material[] Materials;

    void Start()
    {
        // �� ������Ʈ�� �Ҵ�� Renderer�� �����ɴϴ�.
        Renderer renderer = GetComponent<Renderer>();

        // �� ���׸����� ������ �����մϴ�.
        foreach (Material material in Materials)
        {
            material.color = NewColor;
        }
    }
}