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
        // # �α��� ���� ��� ����� ReadyToStart()���� ó���մϴ�.

        InitMainCanvas();

        return true;
    }

    public void ReadyToStart()
    {
        _isLoaded = true;
        GetImage((int)Images.Start_Image).enabled = true;

        // ��ŸƮ �̹��� ���� �� ���� �ִϸ��̼� ����
        _TweenList.Add(Managers.Tween.ImageAlphaPingPong(GetImage((int)Images.Start_Image),
            startAlpha: 1, endAlpha: 0.01f, duration: 1.5f));

        Managers.Sound.Play(Define.SoundType.Bgm, "Sound_Login_Loop");
    }

    private void InitMainCanvas()
    {
        // ���� ĵ���� ����
        _mainCanvas = gameObject.GetOrAddComponent<Canvas>();
        _mainCanvas.worldCamera = GameObject.Find("Main Camera").GetComponent<Camera>();
        _mainCanvas.sortingOrder = 0;
    }


    #region EventHandler
    private void OnClickBG()
    {
        Managers.Sound.Play(Define.SoundType.Effect, "Sound_UI_ButtonDown");

        if (_isLoaded) // # �� ���� BG �ִϸ��̼� ó�� �ʿ� -> �Ϸ� �� �ּ� ���� �ʿ�
        {            
            Managers.Scene.Co_ChangeSceneAsync(Define.SceneType._1LobbyScene);
            _TweenList.ForEach((Tween tween) => tween.Kill());
        }
    }
    #endregion
}