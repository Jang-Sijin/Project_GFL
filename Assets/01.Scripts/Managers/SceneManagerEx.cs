using System;
using System.Collections;
using System.Threading.Tasks;
using UnityEditor.Timeline.Actions;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneManagerEx
{
    private Define.SceneType _currentSceneType = Define.SceneType.Unknown;

    public Define.SceneType CurentSceneType
    {
        get
        {
            if(_currentSceneType != Define.SceneType.Unknown)
                return _currentSceneType;
            return CurrentScene.SceneType;
        }
        set => _currentSceneType = value;
    }
    public BaseScene CurrentScene { get { return GameObject.FindObjectOfType<BaseScene>(); } }

    //public void ChangeScene(Define.SceneType type)
    //{
    //    //Debug.Log(CurrentScene);
    //    //CurrentScene.Clear();

    //    //_currentSceneType = type;
    //    // SceneManager.LoadScene(GetSceneName(type));
    //    // StartCoroutine(Co_LoadSceneAsync(type));
    //}

    // 
    // ������ Scene Type�� Parameter�� ����

    public void Co_ChangeSceneAsync(Define.SceneType type)
    {
        Managers.LoadProgress.ChangeSceneCanvas.SetActive(true);
        
        Debug.Log(CurrentScene);
        
        CurrentScene.Clear();        
        _currentSceneType = type;

        // ���� �񵿱������� �ε�
        AsyncOperation asyncLoad = SceneManager.LoadSceneAsync(GetSceneName(type));        

        // ���� �ε�� ������ ���
        //while (true)
        //{
        //    // �ε� ������� ��� (0.0f to 1.0f)
        //    Debug.Log("Loading progress: " + (asyncLoad.progress * 100) + "%");
        //    yield return null;
        //
        //    if (asyncLoad.isDone)
        //        break;
        //}
        Debug.Log("Loading progress: " + (asyncLoad.progress * 100) + "%");

        asyncLoad.completed += async (AsyncOperation op) =>
        {
            // 3�� ���� ���
            await Task.Delay(TimeSpan.FromSeconds(3));

            // 3�� �Ŀ� ������ �ڵ� �ۼ�
            WaitChangeScene();
        };
        Debug.Log("Scene Loaded: " + GetSceneName(type));
    }

    private void WaitChangeScene()
    {
        Managers.LoadProgress.ChangeSceneCanvas.SetActive(false);
    }

    // SceneType�� string���� ��ȯ
    private string GetSceneName(Define.SceneType type)
    {
        string name = System.Enum.GetName(typeof(Define.SceneType), type);
        char[] letters = name.ToLower().ToCharArray();
        letters[0] = char.ToUpper(letters[0]);
        return new string(letters);
    }
}