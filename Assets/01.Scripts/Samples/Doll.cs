using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;

// ���� �ش� Ŭ������ ĳ���� �ϳ��� ���¸� �����ϴ� ��ũ��Ʈ�̴�.
// ��ü ������ ��Ʈ���ϴ� ���� �Ŵ����� �ʿ��� ������ �����ȴ�.

// ����Ʈ �� 

/// <summary>
/// ������ ���� �⺻ Ŭ����
/// </summary>

public class DollBattleData : MonoBehaviour
{    
    // ������ �⺻, �̵�, ����, �¸�   
    public enum DollBattleState
    {
        Idle,
        Move,
        Attack,
        Die,
        Victory
    }
    private DollBattleState _state;
    public DollBattleState State { get { return _state; } private set { } }

    // ���� Spine ���̷��� �ִϸ��̼�    
    [ReadOnly] private SkeletonAnimation _skeletonAnime;

    // ���� ������ ��������Ʈ
    [ReadOnly] private Sprite _profileSprite;

    public void SetStateDollData(DollBattleState state)
    {
        _state = state;

        switch(state)
        {
            case DollBattleState.Idle:
                _skeletonAnime.AnimationName = "wait";
                break;
            case DollBattleState.Move:
                _skeletonAnime.AnimationName = "move";
                break;
            case DollBattleState.Attack:
                _skeletonAnime.AnimationName = "attack";
                break;
            case DollBattleState.Die:
                _skeletonAnime.AnimationName = "die";
                break;
            case DollBattleState.Victory:
                _skeletonAnime.AnimationName = "victory";
                break;
        }
    }
}