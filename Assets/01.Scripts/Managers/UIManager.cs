using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEngine;

public class UIManager
{
    private int _order = 20;

    public UI_Scene SceneUI { get; set; }

    private Stack<UI_Popup> _popupStack = new Stack<UI_Popup>();
    

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

    // Main UI ������Ʈ�� ĵ���� �߰� �� �ʱ� ���� �� ����
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

    // Ư�� Ÿ���� �� Root(����) UI�� �����ϰ� �ʱ�ȭ�ϴ� �� ���
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

    // ���� ���(���ÿ� �����ϴ�)�� �˾� �� ���׸�(T) UI_Popup ��ӹ��� ��ũ��Ʈ�� ��ȯ�Ѵ�.
    public T FindPopup<T>() where T : UI_Popup
    {
        return _popupStack.Where(x=> x.GetType() == typeof(T)).FirstOrDefault() as T;
    }

    // ���� �������� ȣ���� UI ���׸�(T) Ÿ���� �������� �ʰ� ��ȯ)
    public T PeekPopupUI<T>() where T : UI_Popup
    {
        return _popupStack.Peek() as T;
    }

    public void ClosePopupUI(UI_Popup popup)
    {
        if (_popupStack.Count == 0)
            return;

        if(_popupStack.Peek() != popup)
        {
            Debug.Log("Close Popup Failed");
            return;
        }

        ClosePopupUI();
    }

    // ���� �ֻ��� �˾� UI�� �����Ѵ�.
    public void ClosePopupUI()
    {
        if (_popupStack.Count == 0)
            return;

        UI_Popup popup = _popupStack.Pop();
        Managers.Resource.Destroy(popup.gameObject);
        popup = null;
        _order--;
    }

    // ��� �˾� UI�� �����Ѵ�.
    public void CloseAllPopupUI()
    {
        while (_popupStack.Count > 0)
            ClosePopupUI();
    }

    // ��� �˾� UI ����
    public void Clear()
    {
        CloseAllPopupUI();
        SceneUI = null;
    }
}