using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DollManager
{
    public void Init()
    {
        return;
    }

    // Spine Skeleton ���ҽ� �ҷ����� - ��巹����
    private void LoadSpineSkeletonData(string key, Action<AudioClip> callback)
    {
        //AudioClip audioClip = null;
        //if (_audioClips.TryGetValue(key, out audioClip))
        //{
        //    callback?.Invoke(audioClip);
        //    return;
        //}
        //
        //Managers.Resource.LoadAsync<AudioClip>(key, (audioClip) =>
        //{
        //    if (!_audioClips.ContainsKey(key))
        //        _audioClips.Add(key, audioClip);
        //    callback?.Invoke(audioClip);
        //});
    }
}
