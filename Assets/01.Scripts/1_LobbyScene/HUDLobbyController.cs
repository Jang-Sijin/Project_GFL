using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class HUDLobbyController : MonoBehaviour
{
    [SerializeField]
    private TextMeshProUGUI _displayFpsTextMesh;

    private void Update()
    {
        UpdateDisplayFpsText();
    }

    private void UpdateDisplayFpsText()
    {
        _displayFpsTextMesh.text = GameManager.Instance.DisplayFpsText();
    }
}
