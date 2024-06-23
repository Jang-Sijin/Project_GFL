using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Define
{
    public enum UIEvent
    {
        Click, // ���� ������Ʈ���� �����͸� ������ �� ����
        Press, // �����Ͱ� ������Ʈ ������ ���� ����
        Drag,   // ��ư�� ���� ä a -> b �̵� ��, ��ư�� �� ����
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
