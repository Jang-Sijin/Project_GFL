
public class SelectBattleStageScene : BaseScene
{
    // 배틀 스테이지 선택 메인 UI
    private UI_SelectBattleStageScene _selectBattleStageSceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // 배틀 스테이지 선택 Scene으로 설정
        SceneType = Define.SceneType._6SelectBattleStageScene;

        Managers.UI.ShowSceneRootUI<UI_SelectBattleStageScene>(callback: (selectBattleStageSceneUI) =>
        {
            _selectBattleStageSceneUI = selectBattleStageSceneUI;
        });

        return true;
    }
}