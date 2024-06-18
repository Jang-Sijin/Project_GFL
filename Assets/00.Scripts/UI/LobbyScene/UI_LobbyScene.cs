using Unity.VisualScripting;
using UnityEngine;

public class UI_LobbyScene : UI_Scene
{
    enum GameObjects
    {
        
    }

    enum Images
    {
        
    }

    bool _isLoaded = false;

    public override bool Init()
    {
        if (base.Init() == false)
            return false;

        BindObject(typeof(GameObjects));
        BindImage(typeof(Images));

        // GetObject((int)GameObjects.BG).BindEvent(OnClickBG);

        Debug.Log("∑Œ∫Ò æ¿ »£√‚µ ");        
        Managers.Sound.Play(Define.SoundType.Bgm, "Sound_Lobby_Loop");

        return true;
    }

    #region EventHandler
    private void OnClickBG()
    {
        if (_isLoaded)
            //Managers.Scene.Co_ChangeSceneAsync(Define.SceneType.LobbyScene);

        Managers.Sound.Play(Define.SoundType.Effect, "Sound_UI_Click");
    }
    #endregion
}