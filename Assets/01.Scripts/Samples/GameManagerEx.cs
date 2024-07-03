using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Text;
using LitJson;
using Spine;
using static Define;
using System;
using Unity.VisualScripting;

public class GameManageEx : MonoBehaviour
{
    public TextAsset DollJson;

    public GameObject DollPrefab;

    // 어드레서블로 불러온 오디오 클립들을 딕셔너리에 관리
    private Dictionary<string, SkeletonDataAsset> _skeletonDataAssets = new Dictionary<string, SkeletonDataAsset>();

    // 인형 딕셔너리 저장
    public Dictionary<int, Doll> dollDictionary = new Dictionary<int, Doll>();

    /// <summary>
    /// 인형 프로필 액자사진 아틀라스 경로
    /// </summary>
    public string[] AtlasPath;


    // Start is called before the first frame update
    void Start()
    {
        Init();
    }

    private void Init()
    {
        StartCoroutine(MakeDollData(JsonMapper.ToObject(DollJson.text)));
    }

    private IEnumerator MakeDollData(JsonData data)
    {
        var count = data.Count;
        var list = new List<DollData>();

        var keys = new List<string>();

        for (int i = 0; i < count; i++)
        {
            // Json Data Load
            var dolldata = new DollData();
            try
            {
                dolldata.id = (int)data[i]["id"];
                dolldata.name = data[i]["name"].ToString().ToUpper();
                dolldata.krName = data[i]["krName"].ToString();
                dolldata.rank = (int)data[i]["rank"];
                dolldata.type = (Define.DollWeaponType)(int)data[i]["type"];

                var effect = new Effect();

                effect.effectType = (Define.DollWeaponType)(int)data[i]["effect"]["effectType"];
                effect.effectCenter = (int)data[i]["effect"]["effectCenter"];

                var arrayCount = data[i]["effect"]["effectPos"].Count;
                effect.effectPos = new int[arrayCount];

                for (int j = 0; j < arrayCount; j++)
                {
                    effect.effectPos[j] = (int)data[i]["effect"]["effectPos"][j];
                }

                arrayCount = data[i]["effect"]["gridEffect"].Count;
                effect.gridEffects = new Effect.GridEffect[arrayCount];

                keys.Clear();
                keys.AddRange(data[i]["effect"]["gridEffect"].Keys);

                for (int j = 0; j < arrayCount; j++)
                {
                    effect.gridEffects[j] = new Effect.GridEffect(keys[j]
                        , (int)data[i]["effect"]["gridEffect"][keys[j]]);
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

        // 스켈레톤 애니메이션 스트링 데이터
        var skeletonDataAssetKey = new StringBuilder();

        int myCutCount = 0;
        int totalCount = list.Count * 2;
        int currCount = 0;

        for (int i = 0; i < list.Count; i++)
        {
            skeletonDataAssetKey.Length = 0;
            skeletonDataAssetKey.Append(list[i].name.ToString().ToUpper());

            // 리소스 로드 -> 어드레서블로 변경 필요         
            Managers.Resource.LoadAsync<SkeletonDataAsset>(skeletonDataAssetKey.ToString(), (skeletonDataAsset) =>
            {
                if (!_skeletonDataAssets.ContainsKey(skeletonDataAssetKey.ToString()))
                    _skeletonDataAssets.Add(skeletonDataAssetKey.ToString(), skeletonDataAsset);                
            });
            //if (skel == null)
            //{
            //    Debug.Log("Null " + list[i].name);
            //    continue;
            //}
            
            var go = Managers.Resource.Instantiate("DollUnit", null);


            var doll = go.GetOrAddComponent<Doll>();
            //doll.tr.SetParent(dollPool, false);

            doll.id = list[i].id;
            doll.dollData = list[i];
            doll._skeletonAnime.skeletonDataAsset = _skeletonDataAssets[doll.dollData.name];
            doll._skeletonAnime.Reset(); // 초기화

            // go.SetActive(false);

            dollDictionary.Add(list[i].id, doll);

            ////LoadingBar
            //myCutCount++;
            //currCount++;
            //if (myCutCount > cutCount)
            //{
            //    myCutCount = 0;
            //    loadingSlider.value = (float)currCount / totalCount;
            //    yield return null;
            //}
            ////LoadingBar
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
                    if (dollDictionary.TryGetValue(key, out doll))
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

                ////LoadingBar
                //myCutCount++;
                //currCount++;
                //if (myCutCount > cutCount)
                //{
                //    myCutCount = 0;
                //    loadingSlider.value = (float)currCount / totalCount;
                //    yield return null;
                //}
                ////LoadingBar
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