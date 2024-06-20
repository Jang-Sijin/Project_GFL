using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Utils
{
    public static T FindChild<T>(GameObject go, string name = null, bool recursive = false) where T : UnityEngine.Object
    {
        if (go == null)
            return null;
        
        if(recursive == false) // 자식 오브젝트 재귀로 검색 X
        {
            Transform transform = go.transform.Find(name);
            
            if(transform != null)            
                return transform.GetComponent<T>();            
        }
        else // 자식 오브젝트 재귀로 검색하여 컴포넌트 반환 O
        {
            foreach(T component in go.GetComponentsInChildren<T>())
            {
                if (string.IsNullOrEmpty(name) || component.name == name)
                    return component;
            }
        }

        return null;
    }

    public static GameObject FindChild(GameObject go, string name = null, bool recursive = false)
    {
        if (go == null) 
            return null;

        Transform transform = FindChild<Transform>(go, name, recursive);
        if(transform != null)        
            return transform.gameObject;

        return null;
    }
}
