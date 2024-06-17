using UnityEngine;

public class UI_LoginScene : UI_Scene
{
    public override bool Init()
    {
        if(base.Init() == false)
        {
            return false;
        }

        _init = true;

        return true;
    }

}