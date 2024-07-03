using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;
using static Define;

// ���� �ش� Ŭ������ ĳ���� �ϳ��� ���¸� �����ϴ� ��ũ��Ʈ�̴�.
// ��ü ������ ��Ʈ���ϴ� ���� �Ŵ����� �ʿ��� ������ �����ȴ�.

// ����Ʈ �� 

/// <summary>
/// ������ ���� �⺻ Ŭ����
/// </summary>

public class Doll : MonoBehaviour
{
    // ������ ID
    public int id;

    // ������ �⺻, �̵�, ����, �¸�   
    public enum DollState
    {
        Idle,
        Move,
        Attack,
        Die,
        Victory
    }
    [SerializeField] private DollState _state;
    public DollState State { get { return _state; } private set { } }

    // ���� ���� ����
    public DollData dollData;

    // ���� Spine ���̷��� �ִϸ��̼�    
    public SkeletonAnimation _skeletonAnime;

    // ���� ������ ��������Ʈ
    [SerializeField] private Sprite _profileSprite;

    public void SetStateDollData(DollState state)
    {
        _state = state;

        switch(state)
        {
            case DollState.Idle:
                _skeletonAnime.AnimationName = "wait";
                break;
            case DollState.Move:
                _skeletonAnime.AnimationName = "move";
                break;
            case DollState.Attack:
                _skeletonAnime.AnimationName = "attack";
                break;
            case DollState.Die:
                _skeletonAnime.AnimationName = "die";
                break;
            case DollState.Victory:
                _skeletonAnime.AnimationName = "victory";
                break;
        }
    }
}