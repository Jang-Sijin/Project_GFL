using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Define
{
    public enum SceneName
    {
        None = 0,
        LoginScene,
        TitleScene,
        LobbyScene,
        BattleScene,        
    }

    public enum Sound
    {
        Bgm,
        SubBgm,
        Effect,
        Max
    }

    public static string loadingbarValueTextMesh = "LoadingValue_Text (TMP)";
    public static string loadingbarSlider = "Loading_Slider";
}
