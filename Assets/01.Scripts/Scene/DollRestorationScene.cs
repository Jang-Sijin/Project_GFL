using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DollRestorationScene : BaseScene
{
    private UI_DollRestorationScene _dollRestorationSceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // 현재 (수복)Scene으로 설정
        SceneType = Define.SceneType._2DollRestorationScene;

        Managers.UI.ShowSceneRootUI<UI_DollRestorationScene>(callback: (dollRestorationSceneUI) =>
        {
            _dollRestorationSceneUI = dollRestorationSceneUI;
        });        

        return true;
    }
}
