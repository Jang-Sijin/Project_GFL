using UnityEngine;

public class UI_DormitoryScene : UI_Scene
{
    enum GameObejcts
    {

    }

    enum Images
    {

    }

    enum Buttons
    {
        PrevScene_Button
    }

    public override bool Init()
    {
        if (base.Init() == false)
            return false;

        #region Bind Component
        BindButton(typeof(Buttons));
        #endregion

        #region Bind Event
        GetButton((int)Buttons.PrevScene_Button).gameObject.BindEvent(OnClickButtonPrevScene);
        #endregion

        Managers.Sound.Play(Define.SoundType.Bgm, "Sound_Dormitory_Loop");

        Debug.Log("ÀÎÇü ¼÷¼Ò ¾À È£ÃâµÊ");

        return true;
    }

    #region EventCallback
    private void OnClickButtonPrevScene()
    {
        Managers.Sound.Play(Define.SoundType.Effect, "Sound_UI_ButtonDown");        
        Managers.Scene.ChangeSceneAsync(Define.SceneType._1LobbyScene);
    }
    #endregion
}