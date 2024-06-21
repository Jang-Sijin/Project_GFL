using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LodgingScene : BaseScene
{
    private UI_LodgingScene _lodgingSceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // 현재 (수복)Scene으로 설정
        SceneType = Define.SceneType._3LodgingScene;

        Managers.UI.ShowSceneRootUI<UI_LodgingScene>(callback: (lodgingSceneUI) =>
        {
            _lodgingSceneUI = lodgingSceneUI;
        });

        return true;
    }
}