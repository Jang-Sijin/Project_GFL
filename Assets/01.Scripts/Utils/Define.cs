using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting.Antlr3.Runtime.Misc;
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

    // ���� ���� ������ Ÿ��
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
    /// ���� �������� Ŭ����
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
        /// ������ �� ���� Ÿ��
        /// </summary>
        public DollWeaponType effectType;
        /// <summary>
        /// ������ �ִ� ������ ���� ����
        /// </summary>
        public int effectCenter;
        /// <summary>
        /// ���͸� �������� ������ �� �������� ��ġ
        /// </summary>
        public int[] effectPos;
        /// <summary>
        /// ������ �� �����鿡�� �ִ� �������� ��ġ�� �迭
        /// </summary>
        public GridEffect[] gridEffects;
    }

    /// <summary>
    /// ���� ������ Ŭ���� Json ������ ����.
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
