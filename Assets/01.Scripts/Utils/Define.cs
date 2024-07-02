using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting.Antlr3.Runtime.Misc;
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

    // 인형 정보 데이터 타입
    public enum DollWeaponType
    {
        All = 0,
        HG = 1,
        SMG = 2,
        RF = 3,
        AR = 4,
        MG = 5,
        SG = 6
    }

    public enum DollStats
    {
        armor,
        dodge,
        hit,
        hp,
        pow,
        range,
        rate,
        shield,
        speed,
        crit,
        critDmg,
        armorPiercing,
        nightView,
        coolDown,
        bullet
    }

    /// <summary>
    /// 인형 진형버프 클래스
    /// </summary>
    [System.Serializable]
    public class Effect
    {
        public struct GridEffect
        {
            public Stats type;
            public int value;

            public GridEffect(string type, int value)
            {
                this.type = (Stats)Enum.Parse(typeof(Stats), type);

                this.value = value;
            }
            public GridEffect(Stats type, int value)
            {
                this.type = type;

                this.value = value;
            }
        }
        /// <summary>
        /// 버프를 줄 인형 타입
        /// </summary>
        public DollWeaponType effectType;
        /// <summary>
        /// 버프를 주는 인형의 센터 정보
        /// </summary>
        public int effectCenter;
        /// <summary>
        /// 센터를 기준으로 버프를 줄 인형들의 위치
        /// </summary>
        public int[] effectPos;
        /// <summary>
        /// 버프를 줄 인형들에게 주는 버프들의 수치값 배열
        /// </summary>
        public GridEffect[] gridEffects;
    }

    /// <summary>
    /// 인형 데이터 클래스 Json 데이터 참고.
    /// </summary>
    [System.Serializable]
    public class DollData
    {
        public int id;
        public string name;
        public string krName;
        public int rank;
        public DollWeaponType type;
        public Effect effect;
    }

    /// <summary>
    /// Objects Name - Loading Canvas Prefabs
    /// </summary>
    public static string loadingbarValueTextMesh = "LoadingValue_Text (TMP)";
    public static string loadingbarSlider = "Loading_Slider";

    public static string ChangeSceneLoadingCanvas = "UI_Canvas_MoveScene";
}
