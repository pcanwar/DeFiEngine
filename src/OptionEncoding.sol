
// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;

import "./Constant.sol";

import { StakingOption } from "./Struct.sol";
library OptionEncoding {

function encode(StakingOption memory option) internal pure returns (bytes32[2] memory) {
    bytes32[2] memory data;
    
    data[0] = (bytes32(uint256(option.duration)) << STAKING_OPTION_DURATION_SHIFT) |
              (bytes32(uint256(option.periodFinish)) << STAKING_OPTION_PERIOD_FINISH_SHIFT) |
              (bytes32(uint256(option.lastUpdateTime)) << STAKING_OPTION_LAST_UPDATE_TIME_SHIFT) |
              (bytes32(uint256(option.isActive ? 1 : 0)) << STAKING_OPTION_IS_ACTIVE_SHIFT) |
              (bytes32(uint256(option.rewardRate)) << STAKING_OPTION_REWARD_RATE_SHIFT);
              
    data[1] = (bytes32(uint256(option.minStake)) << STAKING_OPTION_MIN_STAKE_SHIFT) |
              (bytes32(uint256(option.maxStake)) << STAKING_OPTION_MAX_STAKE_SHIFT) |
              (bytes32(uint256(option.totalQuota)) << STAKING_OPTION_TOTAL_QUOTA_SHIFT) |
              (bytes32(uint256(option.remainingQuota)) << STAKING_OPTION_REMAINING_QUOTA_SHIFT);

    return data;
}

function decode(bytes32[2] memory data) internal pure returns (StakingOption memory option) {
    option.duration = uint64(uint256(data[0] >> STAKING_OPTION_DURATION_SHIFT));
    option.periodFinish = uint64(uint256(data[0] >> STAKING_OPTION_PERIOD_FINISH_SHIFT));
    option.lastUpdateTime = uint64(uint256(data[0] >> STAKING_OPTION_LAST_UPDATE_TIME_SHIFT));
    option.isActive = (uint256(data[0] >> STAKING_OPTION_IS_ACTIVE_SHIFT) & 1) == 1;
    option.rewardRate = uint256(data[0] >> STAKING_OPTION_REWARD_RATE_SHIFT);

    option.minStake = uint256(data[1] >> STAKING_OPTION_MIN_STAKE_SHIFT);
    option.maxStake = uint256(data[1] >> STAKING_OPTION_MAX_STAKE_SHIFT);
    option.totalQuota = uint256(data[1] >> STAKING_OPTION_TOTAL_QUOTA_SHIFT);
    option.remainingQuota = uint256(data[1] >> STAKING_OPTION_REMAINING_QUOTA_SHIFT);

    return option;
}

}
    
