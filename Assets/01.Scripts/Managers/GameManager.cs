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
    /// ���÷��� - ���� fps ���õ� ������Ƽ �� ����
    /// </summary>
    private float _fpsDeltaTime;

    /// <summary>
    /// ���� Ÿ�̸ӿ� ���õ� ������Ƽ �� ����
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
    /// ���� - Ÿ�̸ӿ� ���õ� �޼���
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
    /// ���� - ���� ���� ���� �޼���
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
    /// ���÷��� - ���� fps ���� �޼���
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
