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

    // Ʈ������(������Ʈ) ��ġ ���� �ִϸ��̼� ���� (���� ����: ���� ��ġ + distance)
    public void Transform_PingPongPositionY(Transform transform, float distance, float duration)
    {
        transform.DOMoveY(transform.position.y + distance, duration)
    .SetLoops(-1, LoopType.Yoyo)
    .SetEase(Ease.InOutSine);
    }

    // �ؽ�Ʈ ũ�� ���� �ִϸ��̼� ����
    public Tween TextSizePingPong(TextMeshProUGUI textMesh, int startFontSize = 160, int endFontSize = 200, float duration = 1f)
    {
        textMesh.fontSize = startFontSize;
        return DOTween.To(() => textMesh.fontSize, x => textMesh.fontSize = x, endFontSize, duration)
            .SetLoops(-1, LoopType.Yoyo);
    }

    // �ؽ�Ʈ ���� �� ���� �ִϸ��̼� ����
    public Tween TextAlphaPingPong(TextMeshProUGUI textMesh, float startAlpha = 1.0f, float endAlpha = 0.0f, float duration = 1.0f)
    {
        Color color = textMesh.color;
        color.a = startAlpha;
        textMesh.color = color;

        return textMesh.DOFade(endAlpha, duration).SetLoops(-1, LoopType.Yoyo);
    }

    // �̹��� ���� �� ���� �ִϸ��̼� ����
    public Tween ImageAlphaPingPong(Image image, float startAlpha = 1.0f, float endAlpha = 0.0f, float duration = 1.0f)
    {
        Color color = image.color;
        color.a = startAlpha;
        image.color = color;

        return image.DOFade(endAlpha, duration).SetLoops(-1, LoopType.Yoyo);
    }
}