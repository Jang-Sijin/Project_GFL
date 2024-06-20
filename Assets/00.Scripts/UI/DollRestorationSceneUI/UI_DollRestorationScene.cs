public class UI_DollRestorationScene : UI_Scene
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

        // BindObject(typeof(GameObejcts));
        BindButton(typeof(Buttons));

        GetButton((int)Buttons.PrevScene_Button).gameObject.BindEvent(OnClickButtonPrevScene);

        return true;
    }

    #region EventHandler
    private void OnClickButtonPrevScene()
    {
        Managers.Sound.Play(Define.SoundType.Effect, "Sound_UI_Click");
        StartCoroutine(Managers.Scene.Co_ChangeSceneAsync(Define.SceneType._1LobbyScene));
    }
    #endregion
}