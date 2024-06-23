public class DollFormationScene : BaseScene
{
    // 제대 편성 씬 메인 UI
    private UI_DollFormationScene _dollFormationSceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // 제대 편성 Scene으로 설정
        SceneType = Define.SceneType._7DollFormationScene;

        Managers.UI.ShowSceneRootUI<UI_DollFormationScene>(callback: (dollFormationSceneUI) =>
        {
            _dollFormationSceneUI = dollFormationSceneUI;
        });

        return true;
    }
}