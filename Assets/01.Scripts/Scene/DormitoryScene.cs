using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DormitoryScene : BaseScene
{
    private UI_DormitoryScene _dormitorySceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // ���� (����)Scene���� ����
        SceneType = Define.SceneType._3DormitoryScene;

        Managers.UI.ShowSceneRootUI<UI_DormitoryScene>(callback: (dormitorySceneUI) =>
        {
            _dormitorySceneUI = dormitorySceneUI;
        });

        return true;
    }
}