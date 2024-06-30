using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Text;
using LitJson;

public class GameManageEx : MonoBehaviour
{
    public TextAsset DollJson;


    // Start is called before the first frame update
    void Start()
    {
        Init();
    }

    private void Init()
    {
        StartCoroutine(MakeDollData(JsonMapper.ToObject(DollJson.text)));
    }

    /// <summary>
    /// 해당 코루틴에서 모든 데이터 로드 및 로딩진행 표기 합니다.
    /// 비동기씬로드로 로드진행상황 표시 안됩니다. (슬라이더 90%에서 진행이됨)
    /// </summary>
    /// <param name="data"></param>
    /// <returns></returns>
    private IEnumerator MakeDollData(JsonData data)
    {
        var count = data.Count;
        var list = new List<Define.DollData>();

        var keys = new List<string>();

        for (int i = 0; i < count; i++)
        {
            var dolldata = new Define.DollData();
            try
            {
                dolldata.id = (int)data[i]["id"];
                dolldata.name = data[i]["name"].ToString();
                dolldata.krName = data[i]["krName"].ToString();
                dolldata.rank = (int)data[i]["rank"];
                dolldata.type = (Define.DollWeaponType)(int)data[i]["type"];


                var effect = new Define.Effect();

                effect.effectType = (Define.DollWeaponType)(int)data[i]["effect"]["effectType"];
                effect.effectCenter = (int)data[i]["effect"]["effectCenter"];

                var arrayCount = data[i]["effect"]["effectPos"].Count;
                effect.effectPos = new int[arrayCount];

                for (int j = 0; j < arrayCount; j++)
                {
                    effect.effectPos[j] = (int)data[i]["effect"]["effectPos"][j];
                }

                arrayCount = data[i]["effect"]["gridEffect"].Count;
                effect.gridEffects = new Define.Effect.GridEffect[arrayCount];

                keys.Clear();
                keys.AddRange(data[i]["effect"]["gridEffect"].Key);

                for (int j = 0; j < arrayCount; j++)
                {
                    effect.gridEffects[j] = new Define.Effect.GridEffect(keys[j],(int)data[i]["effect"]["gridEffect"][keys[j]]);
                }

                //for (int j = 0; j < arrayCount; j++)
                //{
                //    effect.gridEffects[j] = new Effect.GridEffect(
                //        data[i]["effect"]["gridEffect"][j]["type"].ToString()
                //        , (int)data[i]["effect"]["gridEffect"][j]["value"]);
                //}

                dolldata.effect = effect;
            }
            catch
            {
                Debug.Log("Wrong json data " + i);
                continue;
            }

            list.Add(dolldata);
        }

        var sb = new StringBuilder();

        int myCutCount = 0;
        int totalCount = list.Count * 2;
        int currCount = 0;

        for (int i = 0; i < list.Count; i++)
        {
            sb.Length = 0;
            sb.Append("character/");
            sb.Append(list[i].name);
            sb.Append("/");
            sb.Append(list[i].name);
            sb.Append("_SkeletonData");

            var skel = Resources.Load<SkeletonDataAsset>(sb.ToString());
            if (skel == null)
            {
                Debug.Log("Null " + list[i].name);
                continue;
            }

            var go = Instantiate(dollPrefab, dollPool.position, Quaternion.identity);
            var doll = go.GetComponent<Doll>();
            doll.tr.SetParent(dollPool, false);

            doll.id = list[i].id;
            doll.dollData = list[i];
            doll.skelAnim.skeletonDataAsset = skel;
            doll.skelAnim.Reset();

            go.SetActive(false);

            dollDict.Add(list[i].id, doll);

            //LoadingBar
            myCutCount++;
            currCount++;
            if (myCutCount > cutCount)
            {
                myCutCount = 0;
                loadingSlider.value = (float)currCount / totalCount;
                yield return null;
            }
            //LoadingBar
        }

        //LoadFromAtlas
        for (int i = 0; i < AtlasPath.Length; i++)
        {
            var pics = Resources.LoadAll<Sprite>(AtlasPath[i]);

            for (int j = 0; j < pics.Length; j++)
            {
                int key;
                Doll doll;
                //tryparse : false일때 key는 0반환
                if (Int32.TryParse(pics[j].name, out key))
                {
                    if (dollDict.TryGetValue(key, out doll))
                    {
                        doll.profilePic = pics[j];
                        SingleTon.instance.dollList.AddContent(doll);
                    }
                    else
                    {
                        Debug.Log("There is no Key " + key);
                    }
                }
                else
                {
                    Debug.Log("Convert Failed " + pics[j].name);
                }

                //LoadingBar
                myCutCount++;
                currCount++;
                if (myCutCount > cutCount)
                {
                    myCutCount = 0;
                    loadingSlider.value = (float)currCount / totalCount;
                    yield return null;
                }
                //LoadingBar
            }
        }

        //로드데이터처리 및 프리셋 초기화
        SingleTon.instance.dollPresetList.InitAllPresets();

        beforeLoadingObject.SetActive(false); 
        for (int i = 0; i < afterLoadingObjects.Length; i++)
        {
            afterLoadingObjects[i].SetActive(true);
        }
        //Debug.Log(Time.time);

    }
}