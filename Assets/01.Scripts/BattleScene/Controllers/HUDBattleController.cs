using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class HUDBattleController : MonoBehaviour
{
    [SerializeField]
    private Button _pauseButton;
    private bool _isPause = true;

    [SerializeField]
    private TextMeshProUGUI _elapsedTime_TextMesh;

    private void Start()
    {
        _pauseButton.onClick.AddListener(EventPuaseButton);
    }

    private void Update()
    {
        UpdateElapedTime();
    }

    private void UpdateElapedTime()
    {
        _elapsedTime_TextMesh.text = GameManager.Instance.DisplayElapsedTime();
    }    

    public void EventPuaseButton()
    {
        Debug.Log("´­¸²");

        if(_isPause == false)
        {
            _pauseButton.onClick.RemoveListener(GameManager.Instance.PauseGame);
            _pauseButton.onClick.AddListener(GameManager.Instance.ReStartGame);
            _isPause = true;
        }
        else
        {
            _pauseButton.onClick.RemoveListener(GameManager.Instance.ReStartGame);
            _pauseButton.onClick.AddListener(GameManager.Instance.PauseGame
                );
            _isPause = false;
        }
    }
}
