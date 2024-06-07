// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;

struct StakeInfo { // 0x60
    uint256 amount; // 0x00
    uint256 reward; // 0x20
    uint64 startTime; // 0x40
}

struct RewardTier {
    uint256 threshold;
    uint256 multiplier;
}

struct TimeMultiplier {
    uint256 duration;
    uint256 multiplier;
}