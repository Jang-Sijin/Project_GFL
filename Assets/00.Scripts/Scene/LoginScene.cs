using System.Collections;
using Unity.VisualScripting.Antlr3.Runtime;

public class LoginScene : BaseScene
{
    // LoginScene의 메인 UI
    // private UI_LoginScene _loginSceneUI;

    protected override bool Init()
    {
        if(base.Init() == false)
            return false;

        // 현재(로그인) Scene으로 설정
        SceneType = Define.SceneType.LoginScene;

        //Managers.UI.ShowSceneRootUI<UI_LoginScene>(callback: (loginSceneUI) =>
        //{
        //    _loginSceneUI = loginSceneUI;
        //});

        StartCoroutine(CoWaitLoad());

        return true;
    }

    IEnumerator CoWaitInitManagertLoad()
    {
        //while (Managers.Data.Loaded() == false)
        //    yield return null;

        //while (Managers.UI.SceneUI == null)
        //    yield return null;

        //while (Managers.Game.IsLoaded == false)
        //    yield return null;

        // _loginSceneUI.ReadyToStart();
        yield return null;
    }
}