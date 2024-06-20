using UnityEngine;

public class BaseScene : MonoBehaviour
{
    public Define.SceneType SceneType = Define.SceneType.Unknown;
    protected bool _init = false;

    public void Awake()
    {
        Init();
    }

    protected virtual bool Init()
    {
        if (_init)
            return false;

        _init = true;
        Managers.Init();

        GameObject eventSystemObj = GameObject.Find("EventSystem");
        if(eventSystemObj == null)
        {
            Managers.Resource.Instantiate("EventSystem", null, (eventSystemObj) =>
            {
                eventSystemObj.name = "EventSystem";
            });
        }

        return true;
    }

    public virtual void Clear()
    {        
    }
}