using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AllMaterialColorChange : MonoBehaviour
{
    // ������ ���� ������
    public Color NewColor;

    // ��� ���׸����� �����´�.
    public Material[] Materials;

    void Start()
    {
        // �� ������Ʈ�� �Ҵ�� Renderer�� �����´�.
        Renderer renderer = GetComponent<Renderer>();

        // �� ���׸����� ������ �����Ѵ�.
        foreach (Material material in Materials)
        {
            material.color = NewColor;
        }
    }
}