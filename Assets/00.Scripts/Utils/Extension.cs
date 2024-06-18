
// 기존의 클래스나 구조체를 변경하지 않고도 마치 해당 클래스의 멤버 메서드처럼 호출할 수 있는 확장 메서드(extension methods)
using System;
using UnityEngine;

public static class Extension
{ 
    public static void BindEvent(this GameObject go, Action action, Define.UIEvent type = Define.UIEvent.Click)
    {
        UI_Base.BindEvent(go, action, type);
    }
}