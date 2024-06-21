using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class UIManager
{
    public UI_Scene SceneUI { get; set; }

    private Stack<UI_Popup> _popupStack = new Stack<UI_Popup>();
    private int _order = 20;

    // �ֻ��� UI GameObject
    public GameObject RootUI
    {
        get
        {
            // UI�� Scene ������ �����ϴ� ������ �ٸ��� ������ DontDestroy�� ���� �ʿ䰡 ����.
            GameObject root = GameObject.Find("@UI_Root");

            if (root == null)
                root = new GameObject { name = "@UI_Root" };

            return root;
        }
    }

    // 
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
}