using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DollRestoreScene : BaseScene
{
    private UI_DollRestoreScene _dollRestoreSceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // 현재 (수복)Scene으로 설정
        SceneType = Define.SceneType._2DollRestoreScene;

        Managers.UI.ShowSceneRootUI<UI_DollRestoreScene>(callback: (dollRestoreSceneUI) =>
        {
            _dollRestoreSceneUI = dollRestoreSceneUI;
        });        

        return true;
    }
}
