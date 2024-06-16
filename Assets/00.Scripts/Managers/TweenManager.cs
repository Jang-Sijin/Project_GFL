using DG.Tweening;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TweenManager
{
    public TweenManager()
    {
        Init();
    }

    public void Init()
    {
        
    }

    // 트랜스폼(오브젝트) 위치 핑퐁 애니메이션 적용 (적용 범위: 현재 위치 + distance)
    public void Transform_PingPongPositionY(Transform transform, float distance, float duration)
    {
        transform.DOMoveY(transform.position.y + distance, duration)
    .SetLoops(-1, LoopType.Yoyo)
    .SetEase(Ease.InOutSine);
    }

    // 텍스트 크기 핑퐁 애니메이션 적용
    public Tween TextSizePingPong(TextMeshProUGUI textMesh, int startFontSize = 160, int endFontSize = 200, float duration = 1f)
    {
        textMesh.fontSize = startFontSize;
        return DOTween.To(() => textMesh.fontSize, x => textMesh.fontSize = x, endFontSize, duration)
            .SetLoops(-1, LoopType.Yoyo);
    }

    // 텍스트 알파 값 핑퐁 애니메이션 적용
    public Tween TextAlphaPingPong(TextMeshProUGUI textMesh, float startAlpha = 1.0f, float endAlpha = 0.0f, float duration = 1.0f)
    {
        Color color = textMesh.color;
        color.a = startAlpha;
        textMesh.color = color;

        return textMesh.DOFade(endAlpha, duration).SetLoops(-1, LoopType.Yoyo);
    }

    // 이미지 알파 값 핑퐁 애니메이션 적용
    public Tween ImageAlphaPingPong(Image image, float startAlpha = 1.0f, float endAlpha = 0.0f, float duration = 1.0f)
    {
        Color color = image.color;
        color.a = startAlpha;
        image.color = color;

        return image.DOFade(endAlpha, duration).SetLoops(-1, LoopType.Yoyo);
    }
}