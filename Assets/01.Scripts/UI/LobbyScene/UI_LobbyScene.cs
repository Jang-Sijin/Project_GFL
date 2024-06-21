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

    enum Buttons
    {
        Move_DollRestoration_Button,
        Move_Lodging_Button,
        Move_Research_Button,
        Move_DollCraftShop_Button,
        Move_SelectBattleMap_Button,
        Move_DollFormation_Button,
    }

    bool _isLoaded = false;

    public override bool Init()
    {
        if (base.Init() == false)
            return false;

        BindButton(typeof(Buttons));

        GetButton((int)Buttons.Move_DollRestoration_Button).gameObject.BindEvent(OnClickButtonMoveSceneDollRestoration);
        GetButton((int)Buttons.Move_Lodging_Button).gameObject.BindEvent(OnClickButtonMoveSceneLodging);

        // GetObject((int)GameObjects.BG).BindEvent(OnClickBG);

        if (!Managers.Sound.HasAudioClip(Define.SoundType.Bgm) ||
            !Managers.Sound.IsSoundPlaying(Define.SoundType.Bgm, "Sound_Lobby_Loop"))
            Managers.Sound.Play(Define.SoundType.Bgm, "Sound_Lobby_Loop");

        Debug.Log("∑Œ∫Ò æ¿ »£√‚µ ");

        return true;
    }

    #region EventHandler
    private void OnClickButtonMoveSceneDollRestoration()
    {
        Managers.Sound.Play(Define.SoundType.Effect, "Sound_UI_Click");
        Managers.Scene.Co_ChangeSceneAsync(Define.SceneType._2DollRestorationScene);
    }

    private void OnClickButtonMoveSceneLodging()
    {
        Managers.Sound.Play(Define.SoundType.Effect, "Sound_UI_Click");        
        Managers.Scene.Co_ChangeSceneAsync(Define.SceneType._3LodgingScene);
    }
    #endregion
}