using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Define
{
    public enum SceneType
    {
        Unknown = 0,
        LoginScene,        
        LobbyScene,
        SelectStageScene,
        BattleScene,            
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
}
