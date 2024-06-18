using UnityEngine;

public class ObjectManager
{
    private CameraController _camera;
    public CameraController Camera
    {
        get
        {
            if (_camera == null)
                _camera = GameObject.Find("Main Camera").GetComponent<CameraController>();

            return _camera;
        }
    }
}