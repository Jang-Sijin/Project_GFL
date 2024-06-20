using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    #region Singleton
    public static GameManager Instance { get; private set; }

    private void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
            // DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }
    #endregion

    /// <summary>
    /// 디스플레이 - 게임 fps 관련된 프로퍼티 및 변수
    /// </summary>
    private float _fpsDeltaTime;

    /// <summary>
    /// 전투 타이머와 관련된 프로퍼티 및 변수
    /// </summary>
    public float BattleStartTime { get; private set; }
    public float BattleElapsedTime { get; private set; }
    
    void Start()
    {
        Init();
    }
    
    void Update()
    {
        UpdateElapsedTime();
        UpdateDisplayFps();
    }

    private void Init()
    {
        ResetBattleTimer();
    }


    /// <summary>
    /// 전투 - 타이머와 관련된 메서드
    /// </summary>
    public void ResetBattleTimer()
    {
        BattleStartTime = 0;
        BattleElapsedTime = 0;
    }

    private void UpdateElapsedTime()
    {
        BattleElapsedTime += Time.deltaTime;
    }

    public string DisplayElapsedTime()
    {
        float seconds = Mathf.FloorToInt(BattleElapsedTime % 60);
        float milliseconds = (BattleElapsedTime - seconds) * 1000 / 10;

        return string.Format($"{seconds:00}''{milliseconds:00}");
    }

    /// <summary>
    /// 전투 - 게임 상태 관련 메서드
    /// </summary>
    public void PauseGame()
    {
        Time.timeScale = 0f;
    }

    public void ReStartGame()
    {
        Time.timeScale = 1f;
    }

    public void TimeSpeedXOneGame()
    {
        Time.timeScale = 2f;
    }

    public void TimeSpeedXTwoGame()
    {
        Time.timeScale = 2f;
    }

    /// <summary>
    /// 디스플레이 - 게임 fps 관련 메서드
    /// </summary>
    private void UpdateDisplayFps()
    {
        _fpsDeltaTime += (Time.unscaledDeltaTime - _fpsDeltaTime) * 0.1f;                  
    }

    public string DisplayFpsText()
    {
        float fps = 1.0f / _fpsDeltaTime;

        return "FPS:" + Mathf.Ceil(fps).ToString();
    }
}
