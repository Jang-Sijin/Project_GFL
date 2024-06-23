public class LobbyScene : BaseScene
{    
    private UI_LobbyScene _lobbySceneUI;

    protected override bool Init()
    {
        if (base.Init() == false)
            return false;
        
        SceneType = Define.SceneType._1LobbyScene;

        Managers.UI.ShowSceneRootUI<UI_LobbyScene>(callback: (lobbySceneUI) =>
        {
            _lobbySceneUI = lobbySceneUI;
        });        

        return true;
    }
}