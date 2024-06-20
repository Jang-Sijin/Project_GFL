using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;

public class ResourceManager
{
    // 실제 로드한 리소스.
    private Dictionary<string, UnityEngine.Object> _resources = new Dictionary<string, UnityEngine.Object>();

    // 비동기 리소스 진행 상황.
    private Dictionary<string, AsyncOperationHandle> _handles = new Dictionary<string, AsyncOperationHandle>();
    public int HandlesCount = 0;

    public void Init()
    {
    }

    #region Load Addressable Resources
    public void LoadAsync<T>(string key, Action<T> callback = null) where T : UnityEngine.Object
    {
        // 캐시 확인.
        if (_resources.TryGetValue(key, out UnityEngine.Object resource))
        {
            callback?.Invoke(resource as T);
            return;
        }

        // 로딩은 시작했지만 완료되지 않았다면, 콜백만 추가.
        if (_handles.ContainsKey(key))
        {
            _handles[key].Completed += (op) => { callback?.Invoke(op.Result as T); };
            return;
        }

        // 리소스 비동기 로딩 시작.
        _handles.Add(key, Addressables.LoadAssetAsync<T>(key));
        HandlesCount++;
        _handles[key].Completed += (op) =>
        {
            _resources.Add(key, op.Result as UnityEngine.Object);
            callback?.Invoke(op.Result as T);
            HandlesCount--;
        };
    }

    public void Release(string key)
    {
        if (_resources.TryGetValue(key, out UnityEngine.Object resource) == false)
            return;

        _resources.Remove(key);

        if (_handles.TryGetValue(key, out AsyncOperationHandle handle))
            Addressables.Release(handle);

        _handles.Remove(key);
    }

    public void Clear()
    {
        _resources.Clear();

        foreach (var handle in _handles.Values)
            Addressables.Release(handle);

        _handles.Clear();
    }
    #endregion

    #region Load Addressable Prefabs    
    public void Instantiate(string key, Transform parent = null, Action<GameObject> callback = null)
    {
        LoadAsync<GameObject>(key, (prefab) =>
        {
            GameObject go = GameObject.Instantiate(prefab, parent);
            go.name = prefab.name;
            go.transform.localPosition = prefab.transform.position;
            callback?.Invoke(go);
        });

        //Addressables.InstantiateAsync(key, parent).Completed += (go) => 
        //{ 
        //	onInstantiate?.Invoke(go.Result); 
        //};
    }

    public void Destroy(GameObject go, float seconds = 0.0f)
    {
        UnityEngine.Object.Destroy(go, seconds);

        //if (seconds == 0.0f)
        //	Addressables.ReleaseInstance(go);
        //else
        //	Managers.Instance.StartCoroutine(CoDestroyAfter(go, seconds));
    }

    IEnumerator CoDestroyAfter(GameObject go, float seconds)
    {
        yield return new WaitForSeconds(seconds);
        Addressables.ReleaseInstance(go);
    }   
    #endregion

    #region 리소스 폴더 내 프리팹
    public T Load<T>(string path) where T : UnityEngine.Object
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

        return UnityEngine.Object.Instantiate(prefab, perent);
    }
    #endregion

    public void Destroy(GameObject go)
    {
        if (go == null)
            return;

        UnityEngine.Object.Destroy(go);
    }

    // 재귀적으로 하위 항목을 검색하여 오브젝트를 반환한다.
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