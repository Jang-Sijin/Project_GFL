using DG.Tweening;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class SoundManager : MonoBehaviour
{
    private AudioSource[] _audioSources = new AudioSource[(int)Define.SoundType.Max];
    // ��巹����� �ҷ��� ����� Ŭ������ ��ųʸ��� ����
    private Dictionary<string, AudioClip> _audioClips = new Dictionary<string, AudioClip>();

    private GameObject _soundRootObj = null;
    private float audioSoundValue = 0.1f; // �ӽÿ� // ���� �̱��� ���ӸŴ���-���ӿɼǿ��� ���� ������ ����
    private float audioFadeDuration = 5f; // �ӽÿ� // �ε� �Ϸ� �� ��� ���

    public void Init()
    {
        if (_soundRootObj == null)
        {
            _soundRootObj = GameObject.Find("@SoundRootObj");
            if (_soundRootObj == null)
            {
                _soundRootObj = new GameObject { name = "@SoundRootObj" };
            }

            UnityEngine.Object.DontDestroyOnLoad(_soundRootObj);
            // Root Sound Object�� �ʿ��� AudioSource �������� �߰�
            string[] soundTypeNames = System.Enum.GetNames(typeof(Define.SoundType));
            for (int count = 0; count < soundTypeNames.Length - 1; count++)
            {
                GameObject go = new GameObject { name = soundTypeNames[count] };
                _audioSources[count] = go.AddComponent<AudioSource>();
                go.transform.parent = _soundRootObj.transform;
            }

            // BGM�� �ݺ� ����ϵ��� ����
            _audioSources[(int)Define.SoundType.Bgm].loop = true;
            _audioSources[(int)Define.SoundType.SubBgm].loop = true;

            _audioSources[(int)Define.SoundType.Bgm].volume = audioSoundValue;
            _audioSources[(int)Define.SoundType.SubBgm].volume = audioSoundValue;
            _audioSources[(int)Define.SoundType.Effect].volume = audioSoundValue;
        }
    }

    public void Clear()
    {
        foreach (AudioSource audioSource in _audioSources)
        {
            audioSource.Stop();
        }
        _audioClips.Clear();
    }

    // ���� ��ų Sound Type�� Paramater�� ����
    public void Play(Define.SoundType type)
    {
        AudioSource audioSource = _audioSources[(int)type];
        audioSource.Play();
    }

    public void Play(Define.SoundType type, string key, Action onComplete = null, float pitch = 1.0f)
    {
        AudioSource audioSource = _audioSources[(int)type];

        if (type == Define.SoundType.Bgm)
        {
            LoadAudioClip(key, (audioclip) =>
            {
                // ���� ���� bgm�� �ִ� ��� ����
                if (audioSource.isPlaying)
                {
                    audioSource.Stop();
                }
                audioSource.clip = audioclip;

                // [���� ���� �ʿ�] ���� �ɼ� - BGM on/off ó�� �ʿ�
                //if(Managers.Game.OnBGM)
                audioSource.volume = 0f; // ���� ������ 0���� ����
                audioSource.Play();
                audioSource.DOFade(audioSoundValue, audioFadeDuration); // DOTween�� ����Ͽ� ���̵� ��
            });
        }
        else if (type == Define.SoundType.SubBgm)
        {
            LoadAudioClip(key, (audioClip) =>
            {
                if (audioSource.isPlaying)
                    audioSource.Stop();

                audioSource.clip = audioClip;
                // [���� ���� �ʿ�] ���� �ɼ� - Effect on/off ó�� �ʿ�
                // if (Managers.Game.EffectSoundOn)
                audioSource.volume = 0f; // ���� ������ 0���� ����
                audioSource.Play();
                audioSource.DOFade(audioSoundValue, audioFadeDuration); // DOTween�� ����Ͽ� ���̵� ��
            });
        }
        else
        {
            LoadAudioClip(key, (audioClip) =>
            {
                audioSource.pitch = pitch;
                // [���� ���� �ʿ�] ���� �ɼ� - Effect on/off ó�� �ʿ�
                // if (Managers.Game.EffectSoundOn)
                audioSource.volume = 1f; // ���� ���� ũ�� ����
                audioSource.PlayOneShot(audioClip);

                if (onComplete != null)
                {
                    // ���� ���̸�ŭ ���� �Ŀ� �ݹ� ����
                    Invoke(nameof(onComplete), audioClip.length);                    
                }
            });
        }
    }    

    // ����� ���ҽ� �ҷ����� - ��巹����
    private void LoadAudioClip(string key, Action<AudioClip> callback)
    {
        AudioClip audioClip = null;
        if (_audioClips.TryGetValue(key, out audioClip))
        {
            callback?.Invoke(audioClip);
            return;
        }

        Managers.Resource.LoadAsync<AudioClip>(key, (audioClip) =>
        {
            if (!_audioClips.ContainsKey(key))
                _audioClips.Add(key, audioClip);
            callback?.Invoke(audioClip);
        });
    }

    public void Stop(Define.SoundType type)
    {
        AudioSource audioSource = _audioSources[(int)type];
        audioSource.Stop();
    }

    public bool IsSoundPlaying(Define.SoundType type, string key)
    {
        AudioSource audioSource = _audioSources[(int)type];
        bool isPlaying = false;

        // �뷡�� �������� �ʰų�
        if(audioSource.clip)

        switch (type)
        {
            case Define.SoundType.Bgm:
            case Define.SoundType.SubBgm:
            case Define.SoundType.Effect:                
                if (audioSource.clip.name == key && audioSource.isPlaying)
                    isPlaying = true;
                else
                    isPlaying = false;
                break;                            
        }

        return isPlaying;
    }

    public bool HasAudioClip(Define.SoundType type)
    {
        AudioSource audioSource = _audioSources[(int)type];

        if (audioSource == null)
            return false;
        else
            return true;
    }
}
