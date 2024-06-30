using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;

// 지금 해당 클래스는 캐릭터 하나의 상태를 관리하는 스크립트이다.
// 전체 인형을 컨트롤하는 게임 매니저가 필요할 것으로 생각된다.

// 리스트 당 

/// <summary>
/// 인형의 정보 기본 클래스
/// </summary>

public class DollBattleData : MonoBehaviour
{    
    // 인형은 기본, 이동, 공격, 승리   
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

    // 인형 Spine 스켈레톤 애니메이션    
    [ReadOnly] private SkeletonAnimation _skeletonAnime;

    // 인형 프로필 스프라이트
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