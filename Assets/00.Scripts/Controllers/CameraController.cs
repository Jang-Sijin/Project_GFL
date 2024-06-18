using UnityEngine;

public class CameraController : BaseController
{
    protected override bool Init()
    {
        if (base.Init() == false)
            return false;

        SetCameraInit();

        return true;
    }

    private void SetCameraInit()
    {
        float width = Screen.width;
        float height = Screen.height;

        float baseRatio = 1600f / 900f;
        float currentRatio = width / height;

        if (currentRatio >= baseRatio)
            Camera.main.orthographicSize = 11.4f;
        else
            Camera.main.orthographicSize = 11.4f * baseRatio / currentRatio;
    }
}