public class DollFactoryScene : BaseScene
{
    private UI_FactoryScene _factoryScene;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // 공방 Scene으로 설정
        SceneType = Define.SceneType._5DollFactoryScene;

        Managers.UI.ShowSceneRootUI<UI_FactoryScene>(callback: (factoryScene) =>
        {
            _factoryScene = factoryScene;
        });

        return true;
    }
}