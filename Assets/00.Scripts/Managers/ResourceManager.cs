using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResourceManager
{
    public void Init()
    {
        // 0. �ε� ȭ�� ĵ���� �ҷ�����
        string loadingCanvas = "Loading_Canvas";        
        GameObject go = GameObject.Find(loadingCanvas);
        if(go == null)
        {
            Debug.Log($"{loadingCanvas}�� Scene�� �������� �ʾ�, ���Ӱ� �����մϴ�.");

            GameObject canvasPrefab = Resources.Load<GameObject>($"Prefabs/{loadingCanvas}");

            if(canvasPrefab == null)
            {
                Debug.LogError($"{loadingCanvas} �������� ã�� �� �����ϴ�. ��θ� Ȯ���ϼ���.");
            }

            // loadingCanvas �������� �ν��Ͻ�ȭ�Ͽ� ���� �߰�
            Object.Instantiate(canvasPrefab);
        }
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
}
