using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;

public class UI_EventHandler : MonoBehaviour, IPointerClickHandler, IPointerDownHandler, IDragHandler
{
    // [특징(캡슐화)]
    // 이벤트 실행은 UI_EventHandler에서만 가능하다.
    // 이벤트를 등록/해제는 외부에서 가능하다.

    public event Action OnClickHandler = null;
    public event Action OnPressHandler = null;
    public event Action OnDragHandler = null;   

    // 동일 오브젝트에서 포인터를 누르고 뗄 때 호출됩니다.
    public void OnPointerClick(PointerEventData eventData)
    {
        OnClickHandler?.Invoke();
    }

    // 포인터가 오브젝트 위에서 눌렸을 때 호출됩니다.
    public void OnPointerDown(PointerEventData eventData)
    {
        OnPressHandler?.Invoke();
    }

    public void OnDrag(PointerEventData eventData)
    {
        OnDragHandler?.Invoke();
    }
}