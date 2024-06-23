using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Define
{
    public enum UIEvent
    {
        Click, // 동일 오브젝트에서 포인터를 누르고 뗀 상태
        Press, // 포인터가 오브젝트 위에서 눌린 상태
        Drag,   // 버튼을 누른 채 a -> b 이동 후, 버튼을 뗀 상태
    } 

    public enum SceneType
    {
        Unknown = 0,
        _0LoginScene,        
        _1LobbyScene,
        _2DollRestoreScene,
        _3DormitoryScene,
        _4ResearchScene,
        _5DollFactoryScene,
        _6SelectBattleStageScene,
        _7DollFormationScene,
        _8BattleInGameScene,
    }

    public enum SceneChangeType
    {
        In,
        Out,
    }

    public enum SoundType
    {
        Bgm,
        SubBgm,
        Effect,
        Max
    }

    /// <summary>
    /// Objects Name - Loading Canvas Prefabs
    /// </summary>
    public static string loadingbarValueTextMesh = "LoadingValue_Text (TMP)";
    public static string loadingbarSlider = "Loading_Slider";

    public static string ChangeSceneLoadingCanvas = "UI_Canvas_MoveScene";
}
