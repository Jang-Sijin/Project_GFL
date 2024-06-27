using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class UIManager
{
    private int _order = 20;

    public UI_Scene SceneUI { get; set; }

    private Stack<UI_Popup> _popupStack = new Stack<UI_Popup>();
    

    // 최상위 UI GameObject
    public GameObject RootUI
    {
        get
        {
            // UI는 Scene 단위로 관리하는 로직이 다르기 때문에 DontDestroy를 해줄 필요가 없음.
            GameObject root = GameObject.Find("@UI_Root");

            if (root == null)
                root = new GameObject { name = "@UI_Root" };

            return root;
        }
    }

    // Main UI 오브젝트에 캔버스 추가 및 초기 설정 값 세팅
    public void SetCanvas(GameObject go, bool sort = true)
    {
        Canvas canvas = go.GetOrAddComponent<Canvas>();
        // canvas.renderMode = RenderMode.ScreenSpaceCamera;
        canvas.overrideSorting = true;
        
        if(sort)
        {
            canvas.sortingOrder = _order;
            _order++;
        }
        else
        {
            canvas.sortingOrder = 0;
        }
    }

    // 특정 타입의 씬 Root(메인) UI를 생성하고 초기화하는 데 사용
    public void ShowSceneRootUI<T>(string key = null, Action<T> callback = null) where T : UI_Scene
    {
        if (string.IsNullOrEmpty(key))
            key = typeof(T).Name;

        Managers.Resource.Instantiate(key, RootUI.transform, (go) =>
        {
            T sceneUI = go.GetOrAddComponent<T>();
            SceneUI = sceneUI;
            callback?.Invoke(sceneUI);
        });
    }

    // 
    public void ShowPopupUI<T>(string key = null, Transform parent = null, Action<T> callback = null) where T : UI_Popup
    {
        if(string.IsNullOrEmpty(key))
        {
            key = typeof(T).Name;
        }

        Managers.Resource.Instantiate(key, null, (go) =>
        {
            T popup = go.GetOrAddComponent<T>();
            _popupStack.Push(popup);

            if (parent != null)
                go.transform.SetParent(parent);
            else
                go.transform.SetParent(RootUI.transform);

            callback?.Invoke(popup);
        });
    }

    public T FindPopup<T>() where
}