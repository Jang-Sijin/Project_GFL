using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MaterialTransparentColorController : MonoBehaviour
{
    public SpriteRenderer image;
    public Material transparentMaterial;
    public Color colorKey;

    [Range(0, 1)]
    public float tolerance = 0.0f;

    void Start()
    {
        transparentMaterial = image.material;

        if (transparentMaterial != null)
        {
            transparentMaterial.SetColor("_ColorKey", colorKey);
            transparentMaterial.SetFloat("_Tolerance", tolerance);
        }
    }
}
