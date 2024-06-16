using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResourceManager
{
    public void Init()
    {
    }

    public T Load<T>(string path) where T : Object
    {
        return Resources.Load<T>(path);
    }

    public GameObject Instantiate(string path, Transform perent = null)
    {
        GameObject prefab = Load<GameObject>($"Prefabs/{path}");

        if (prefab == null)
        {
            Debug.Log($"Failed to load Prefab: {path}");
            return null;
        }

        return Object.Instantiate(prefab, perent);
    }

    public void Destroy(GameObject go)
    {
        if (go == null)
            return;

        Object.Destroy(go);
    }

    // ��������� ���� �׸��� �˻��Ͽ� ������Ʈ�� ��ȯ�Ѵ�.
    public GameObject FindChildByName(Transform parent, string name)
    {
        foreach (Transform child in parent)
        {
            if (child.name == name)
            {
                return child.gameObject;
            }
            
            GameObject result = FindChildByName(child, name);
            if (result != null)
            {
                return result;
            }
        }

        return null;
    }
}
