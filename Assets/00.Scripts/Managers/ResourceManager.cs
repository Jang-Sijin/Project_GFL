using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResourceManager
{
    public void Init()
    {
        // 0. 로딩 화면 캔버스 불러오기
        string loadingCanvas = "Loading_Canvas";        
        GameObject go = GameObject.Find(loadingCanvas);
        if(go == null)
        {
            Debug.Log($"{loadingCanvas}가 Scene에 존재하지 않아, 새롭게 생성합니다.");

            GameObject canvasPrefab = Resources.Load<GameObject>($"Prefabs/{loadingCanvas}");

            if(canvasPrefab == null)
            {
                Debug.LogError($"{loadingCanvas} 프리팹을 찾을 수 없습니다. 경로를 확인하세요.");
            }

            // loadingCanvas 프리팹을 인스턴스화하여 씬에 추가
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
