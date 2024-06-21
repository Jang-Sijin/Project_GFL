using DG.Tweening;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class UI_LoginScene : UI_Scene
{
    enum GameObjects
    {
        BG,
    }

    enum Images
    {
        Start_Image,
    }

    public Canvas MainCanvas { get { return _mainCanvas; } }

    private bool _isLoaded = false;
    private Canvas _mainCanvas;

    private List<Tween> _TweenList = new List<Tween>();

    public override bool Init()
    {
        if (base.Init() == false)
            return false;

        BindObject(typeof(GameObjects));
        BindImage(typeof(Images));

        GetObject((int)GameObjects.BG).BindEvent(OnClickBG);        

        Managers.Sound.Clear();
        // # 로그인 씬의 배경 사운드는 ReadyToStart()에서 처리합니다.

        InitMainCanvas();

        return true;
    }

    public void ReadyToStart()
    {
        _isLoaded = true;
        GetImage((int)Images.Start_Image).enabled = true;

        // 스타트 이미지 알파 값 핑퐁 애니메이션 적용
        _TweenList.Add(Managers.Tween.ImageAlphaPingPong(GetImage((int)Images.Start_Image),
            startAlpha: 1, endAlpha: 0.01f, duration: 1.5f));

        Managers.Sound.Play(Define.SoundType.Bgm, "Sound_Login_Loop");
    }

    private void InitMainCanvas()
    {
        // 메인 캔버스 설정
        _mainCanvas = gameObject.GetOrAddComponent<Canvas>();
        _mainCanvas.worldCamera = GameObject.Find("Main Camera").GetComponent<Camera>();
        _mainCanvas.sortingOrder = 0;
    }


    #region EventHandler
    private void OnClickBG()
    {
        Managers.Sound.Play(Define.SoundType.Effect, "Sound_UI_ButtonDown");

        if (_isLoaded) // # 씬 변경 BG 애니메이션 처리 필요 -> 완료 후 주석 제거 필요
        {            
            Managers.Scene.Co_ChangeSceneAsync(Define.SceneType._1LobbyScene);
            _TweenList.ForEach((Tween tween) => tween.Kill());
        }
    }
    #endregion
}