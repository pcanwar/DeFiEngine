// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;

import "./Constant.sol";
import { StakerInfo } from "./Struct.sol";

library StakerEncoding {
    function encode(StakerInfo memory info) internal pure returns (bytes32[2] memory) {
        bytes32[2] memory result;
        result[0] = bytes32(
            (uint256(info.startTime) << STAKER_INFO_START_TIME_SHIFT) |
            (uint256(info.lastUpdateTime) << STAKER_INFO_LAST_UPDATE_TIME_SHIFT) |
            (uint256(info.isActive ? 1 : 0) << STAKER_INFO_IS_ACTIVE_SHIFT) |
            (uint256(info.autoRenew ? 1 : 0) << STAKER_INFO_AUTO_RENEW_SHIFT) |
            (uint256(info.amount) << STAKER_INFO_AMOUNT_SHIFT)
        );
        result[1] = bytes32(
            (uint256(info.reward) << STAKER_INFO_REWARD_SHIFT) |
            (uint256(info.stakingOptionId) << STAKER_INFO_STAKING_OPTION_ID_SHIFT) |
            (uint256(info.rewardEarned) << STAKER_INFO_REWARD_EARNED_SHIFT) |
            (uint256(info.personalQuota) << STAKER_INFO_PERSONAL_QUOTA_SHIFT) |
            (uint256(info.userRewardPerTokenPaid) << STAKER_INFO_USER_REWARD_PER_TOKEN_PAID_SHIFT)
        );
        return result;
    }

    function decode(bytes32[2] memory data) internal pure returns (StakerInfo memory info) {
        info.startTime = uint64(uint256(data[0] >> STAKER_INFO_START_TIME_SHIFT));
        info.lastUpdateTime = uint64(uint256(data[0] >> STAKER_INFO_LAST_UPDATE_TIME_SHIFT));
        info.isActive = (uint256(data[0] >> STAKER_INFO_IS_ACTIVE_SHIFT) & 1) == 1;
        info.autoRenew = (uint256(data[0] >> STAKER_INFO_AUTO_RENEW_SHIFT) & 1) == 1;
        info.amount = uint256(data[0] >> STAKER_INFO_AMOUNT_SHIFT);
        
        info.reward = uint256(data[1] >> STAKER_INFO_REWARD_SHIFT);
        info.stakingOptionId = uint256(data[1] >> STAKER_INFO_STAKING_OPTION_ID_SHIFT);
        info.rewardEarned = uint256(data[1] >> STAKER_INFO_REWARD_EARNED_SHIFT);
        info.personalQuota = uint256(data[1] >> STAKER_INFO_PERSONAL_QUOTA_SHIFT);
        info.userRewardPerTokenPaid = uint256(data[1] >> STAKER_INFO_USER_REWARD_PER_TOKEN_PAID_SHIFT);

        return info;
    }
}
