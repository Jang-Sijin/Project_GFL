
// ������ Ŭ������ ����ü�� �������� �ʰ� ��ġ �ش� Ŭ������ ��� �޼���ó�� ȣ���� �� �ִ� Ȯ�� �޼���(extension methods)
using System;
using UnityEngine;

public static class Extension
{ 
    public static void BindEvent(this GameObject go, Action action, Define.UIEvent type = Define.UIEvent.Click)
    {
        UI_Base.BindEvent(go, action, type);
    }
}