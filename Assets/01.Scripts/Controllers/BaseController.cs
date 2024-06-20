using UnityEngine;

public class BaseController : MonoBehaviour
{
    protected bool _init = false;

    private void Start()
    {
        Init();
    }

    protected virtual bool Init()
    {
        if (_init)
            return false;

        _init = true;

        return true;
    }
}