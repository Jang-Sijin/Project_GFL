using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResearchScene : BaseScene
{
    // ResearchScene의 메인 UI
    private UI_ResearchScene _researchSceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // 연구 Scene으로 설정
        SceneType = Define.SceneType._4ResearchScene;

        Managers.UI.ShowSceneRootUI<UI_ResearchScene>(callback: (researchSceneUI) =>
        {
            _researchSceneUI = researchSceneUI;
        });

        return true;
    }
}
