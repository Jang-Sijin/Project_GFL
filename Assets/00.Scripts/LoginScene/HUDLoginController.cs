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
        // 스타트 이미지 알파 값 핑퐁 애니메이션 적용
        //Managers.Tween.ImageAlphaPingPong(startImage, startAlpha: 1, endAlpha: 0.01f, duration: 1.5f);
    }
}
