public class LobbyScene : BaseScene
{
    // LoginScene�� ���� UI
    private UI_LobbyScene _lobbySceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        // ����(�κ�) Scene���� ����
        SceneType = Define.SceneType.LobbyScene;

        Managers.UI.ShowSceneRootUI<UI_LobbyScene>(callback: (lobbySceneUI) =>
        {
            _lobbySceneUI = lobbySceneUI;
        });        

        return true;
    }
}
