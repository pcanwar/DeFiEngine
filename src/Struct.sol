// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;

struct StakerInfo { // 0x60
    uint256 amount; // 0x00
    uint256 rewards; // 0x20
    uint256 stakingOptionId;
    uint64 startTime;
    uint256 rewardEarned;    
    uint256 personalQuota;   // Personal remaining quota for staking in this 
    bool isActive;
    bool autoRenew;
    uint256 userRewardPerTokenPaid; // track user reward per token paid

}

struct StakingOption {
    uint256 duration;
    uint256 rewardRate;
    uint256 minStake; 
    uint256 maxStake;
    uint256 totalQuota;   // total token available for staking
    uint256 remainingQuota; // be remaining quota of tokens available
    bool isActive;          // switch 
    uint256 periodFinish;        // end time of the current reward period
    uint256 lastUpdateTime;      // Last time reward rate was updated
    uint256 rewardPerTokenStored; // Reward per token stored
}