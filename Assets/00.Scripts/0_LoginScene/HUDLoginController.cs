using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HUDLoginController : MonoBehaviour
{
    [SerializeField] private Image startImage;
    
    void Start()
    {
        Init();
    }

    private void Init()
    {
        // ��ŸƮ �̹��� ���� �� ���� �ִϸ��̼� ����
        //Managers.Tween.ImageAlphaPingPong(startImage, startAlpha: 1, endAlpha: 0.01f, duration: 1.5f);
    }
}
