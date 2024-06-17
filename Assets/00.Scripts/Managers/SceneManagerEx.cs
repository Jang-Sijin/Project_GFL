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

    // 변경할 Scene Type을 Parameter로 전달
    public void ChangeScene(Define.SceneType type)
    {
        Debug.Log(CurrentScene);
        CurrentScene.Clear();

        _currentSceneType = type;
        SceneManager.LoadScene(GetSceneName(type));
    }

    // SceneType을 string으로 반환
    string GetSceneName(Define.SceneType type)
    {
        string name = System.Enum.GetName(typeof(Define.SceneType), type);
        char[] letters = name.ToLower().ToCharArray();
        letters[0] = char.ToUpper(letters[0]);
        return new string(letters);
    }
}