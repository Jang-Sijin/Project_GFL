using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class UI_EventHandler : MonoBehaviour, IPointerClickHandler, IPointerDownHandler, IDragHandler
{
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