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
        Move_Restore_Button,
        Move_Dormitory_Button,
        Move_Research_Button,
        Move_Factory_Button,
        Move_Combat_Button,
        Move_Formation_Button,
    }

    bool _isLoaded = false;

    public override bool Init()
    {
        if (base.Init() == false)
            return false;

        BindButton(typeof(Buttons));

        GetButton((int)Buttons.Move_Restore_Button).gameObject.BindEvent(() => OnClickButtonMoveScene(Define.SceneType._2DollRestoreScene));
        GetButton((int)Buttons.Move_Dormitory_Button).gameObject.BindEvent(() => OnClickButtonMoveScene(Define.SceneType._3DormitoryScene));
        GetButton((int)Buttons.Move_Research_Button).gameObject.BindEvent(() => OnClickButtonMoveScene(Define.SceneType._4ResearchScene));
        GetButton((int)Buttons.Move_Factory_Button).gameObject.BindEvent(() => OnClickButtonMoveScene(Define.SceneType._5DollFactoryScene));
        GetButton((int)Buttons.Move_Combat_Button).gameObject.BindEvent(() => OnClickButtonMoveScene(Define.SceneType._6SelectBattleStageScene));
        GetButton((int)Buttons.Move_Formation_Button).gameObject.BindEvent(() => OnClickButtonMoveScene(Define.SceneType._7DollFormationScene));

        if (!Managers.Sound.HasAudioClip(Define.SoundType.Bgm) ||
            !Managers.Sound.IsSoundPlaying(Define.SoundType.Bgm, "Sound_Lobby_Loop"))
            Managers.Sound.Play(Define.SoundType.Bgm, "Sound_Lobby_Loop");        

        return true;
    }

    #region EventHandler
    private void OnClickButtonMoveScene(Define.SceneType sceneType)
    {
        Managers.Sound.Play(Define.SoundType.Effect, "Sound_UI_Click");
        Managers.Scene.ChangeSceneAsync(sceneType);
    }
    #endregion
}