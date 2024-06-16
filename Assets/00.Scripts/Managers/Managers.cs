using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.Rendering.VirtualTexturing;
using static UnityEditor.ShaderGraph.Internal.KeywordDependentCollection;

public class Managers : MonoBehaviour
{
    private static Managers _instance = null;
    public static Managers Instance => _instance;
    
    private ResourceManager _resource = new ResourceManager();
    //private SceneManagerEx _scene = new SceneManagerEx();    
    //private SoundManager _sound = new SoundManager();    
    private TweenManager _tween = new TweenManager();
    private LoadProgressHandler _loadProgress = new LoadProgressHandler();

    public static ResourceManager Resource => Instance?._resource;
    //public static SceneManagerEx Scene => Instance?._scene;
    //public static SoundManager Sound => Instance?._sound;    
    public static TweenManager Tween => Instance?._tween;
    public static LoadProgressHandler LoadProgress => Instance?._loadProgress;

    /// <summary>
    /// [Debug Mode: Show Fps On Display]    
    /// </summary>  
    private float _fpsDeltaTime;

    #region Unity Event Fuction
    private void Awake()
    {
        Init();
    }

    void Update()
    {
        UpdateDisplayFps();
    }

    private void OnGUI()
    {
        DrawFps();
    }
    #endregion

    public static void Init()
    {
        if (_instance == null)
        {
            GameObject go = GameObject.Find("@Managers");

            if (go == null)
            {
                go = new GameObject { name = "@Managers" };
            }
            _instance = go.GetOrAddComponent<Managers>();
            DontDestroyOnLoad(go);

            // 로딩 상태 설정 및 초기화
            _instance._loadProgress.InitLoadUI();            

            // 각 매니저 초기화            
            _instance._resource.Init();
            _instance._loadProgress.UpdateProgress();
            //_instance._scene.Init();
            _instance._loadProgress.UpdateProgress();
            //_instance._sound.Init();            
            _instance._loadProgress.UpdateProgress();
            _instance._tween.Init();
            _instance._loadProgress.UpdateProgress();          
        }
    }

    public static void Clear()
    {

    }  

    /// <summary>
    /// 디스플레이 - 게임 fps 관련 메서드
    /// </summary>
    private void UpdateDisplayFps()
    {
        _fpsDeltaTime += (Time.unscaledDeltaTime - _fpsDeltaTime) * 0.1f;
    }

    private void DrawFps()
    {
        GUIStyle style = new GUIStyle();

        Rect rect = new Rect(0, 0, Screen.width, Screen.height);
        style.alignment = TextAnchor.UpperLeft;
        style.fontSize = 25;
        style.normal.textColor = UnityEngine.Color.white;

        float ms = _fpsDeltaTime * 1000f;
        float fps = 1.0f / _fpsDeltaTime;
        string text = string.Format("{0:0.} FPS ({1:0.0} ms)", fps, ms);

        GUI.Label(rect, text, style);
    }
}