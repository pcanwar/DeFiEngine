// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;

import "./Constant.sol";

import { StakeInfo } from "./Struct.sol";

library StakerEncoding {
    function encode(StakeInfo memory info) internal pure returns (bytes32) {
        return bytes32(
            (uint256(info.amount) << TotalStaked_shift) |
            (uint256(info.reward) << RewardDebt_shift) |
            (uint256(info.startTime) << ProcessedIndex_shift)
        );
    }

    function decode(bytes32 data) internal pure returns (StakeInfo memory) {
        uint256 amount = uint256(data >> TotalStaked_shift);
        uint256 reward = uint256((data << (256 - RewardDebt_shift)) >> (256 - RewardDebt_shift));
        uint64 startTime = uint64(uint256((data << (256 - ProcessedIndex_shift)) >> (256 - ProcessedIndex_shift)));

        return StakeInfo(amount, reward, startTime);
    }
}
