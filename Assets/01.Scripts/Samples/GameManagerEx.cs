using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Text;
using LitJson;

public class GameManageEx : MonoBehaviour
{
    public TextAsset DollJson;

    public GameObject DollPrefab;


    // Start is called before the first frame update
    void Start()
    {
        Init();
    }

    private void Init()
    {
        //StartCoroutine(MakeDollData(JsonMapper.ToObject(DollJson.text)));
    }

}