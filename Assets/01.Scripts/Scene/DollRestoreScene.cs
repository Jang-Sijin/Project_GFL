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

        // ���� (����)Scene���� ����
        SceneType = Define.SceneType._2DollRestoreScene;

        Managers.UI.ShowSceneRootUI<UI_DollRestoreScene>(callback: (dollRestoreSceneUI) =>
        {
            _dollRestoreSceneUI = dollRestoreSceneUI;
        });        

        return true;
    }
}
