using DG.Tweening;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class SoundManager : MonoBehaviour
{
    private AudioSource[] _audioSources = new AudioSource[(int)Define.SoundType.Max];
    // 어드레서블로 불러온 오디오 클립들을 딕셔너리에 관리
    private Dictionary<string, AudioClip> _audioClips = new Dictionary<string, AudioClip>();

    private GameObject _soundRootObj = null;
    private float audioSoundValue = 0.1f; // 임시용 // 추후 싱글톤 게임매니저-게임옵션에서 값을 가져올 예정
    private float audioFadeDuration = 5f; // 임시용 // 로딩 완료 후 잠시 대기

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
            // Root Sound Object에 필요한 AudioSource 종류들을 추가
            string[] soundTypeNames = System.Enum.GetNames(typeof(Define.SoundType));
            for (int count = 0; count < soundTypeNames.Length - 1; count++)
            {
                GameObject go = new GameObject { name = soundTypeNames[count] };
                _audioSources[count] = go.AddComponent<AudioSource>();
                go.transform.parent = _soundRootObj.transform;
            }

            // BGM은 반복 재생하도록 설정
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

    // 실행 시킬 Sound Type을 Paramater로 전달
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
                // 실행 중인 bgm이 있는 경우 중지
                if (audioSource.isPlaying)
                {
                    audioSource.Stop();
                }
                audioSource.clip = audioclip;

                // [추후 구현 필요] 게임 옵션 - BGM on/off 처리 필요
                //if(Managers.Game.OnBGM)
                audioSource.volume = 0f; // 시작 볼륨을 0으로 설정
                audioSource.Play();
                audioSource.DOFade(audioSoundValue, audioFadeDuration); // DOTween을 사용하여 페이드 인
            });
        }
        else if (type == Define.SoundType.SubBgm)
        {
            LoadAudioClip(key, (audioClip) =>
            {
                if (audioSource.isPlaying)
                    audioSource.Stop();

                audioSource.clip = audioClip;
                // [추후 구현 필요] 게임 옵션 - Effect on/off 처리 필요
                // if (Managers.Game.EffectSoundOn)
                audioSource.volume = 0f; // 시작 볼륨을 0으로 설정
                audioSource.Play();
                audioSource.DOFade(audioSoundValue, audioFadeDuration); // DOTween을 사용하여 페이드 인
            });
        }
        else
        {
            LoadAudioClip(key, (audioClip) =>
            {
                audioSource.pitch = pitch;
                // [추후 구현 필요] 게임 옵션 - Effect on/off 처리 필요
                // if (Managers.Game.EffectSoundOn)
                audioSource.volume = 1f; // 시작 볼륨 크기 설정
                audioSource.PlayOneShot(audioClip);

                if (onComplete != null)
                {
                    // 사운드 길이만큼 지연 후에 콜백 실행
                    Invoke(nameof(onComplete), audioClip.length);                    
                }
            });
        }
    }    

    // 오디오 리소스 불러오기 - 어드레서블
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

        // 노래가 존재하지 않거나
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
