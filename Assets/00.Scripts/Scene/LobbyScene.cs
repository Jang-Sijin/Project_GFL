public class LobbyScene : BaseScene
{
    // LoginScene의 메인 UI
    private UI_LobbyScene _lobbySceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // 현재(로비) Scene으로 설정
        SceneType = Define.SceneType.LobbyScene;

        Managers.UI.ShowSceneRootUI<UI_LobbyScene>(callback: (lobbySceneUI) =>
        {
            _lobbySceneUI = lobbySceneUI;
        });        

        return true;
    }
}
