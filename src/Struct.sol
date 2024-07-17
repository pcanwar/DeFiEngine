// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;

struct StakerInfo { // 0x60
    uint256 amount; // 0x00
    uint256 reward; // 0x20
    uint256 stakingOptionId;
    uint256 rewardEarned;
    uint256 personalQuota;   // Personal remaining quota for staking in this 
    uint256 userRewardPerTokenPaid; // track user reward per token paid
    uint64 startTime;
    uint64 lastUpdateTime;
    bool isActive;
    bool autoRenew;

}

struct StakingOption {
    uint256 rewardRate;
    uint256 minStake; 
    uint256 maxStake;
    uint256 totalQuota;   // total token available for staking
    uint256 remainingQuota; // be remaining quota of tokens available
    uint256 rewardPerTokenStored; // Reward per token stored
    uint64 duration;
    uint64 periodFinish;        // end time of the current reward period
    uint64 lastUpdateTime;      // Last time reward rate was updated
    bool isActive;          // switch 
   
}

struct User {
    bytes32 re1;
    bytes32 re2;
}