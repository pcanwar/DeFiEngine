// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;


uint256 constant ERC20_transferFrom_selector = 0x23b872dd00000000000000000000000000000000000000000000000000000000;
uint256 constant ERC20_transferFrom_from_offset = 0x04;
uint256 constant ERC20_transferFrom_to_offset = 0x24;
uint256 constant ERC20_transferFrom_amount_offset = 0x44;
uint256 constant ERC20_transferFrom_size = 0x64;

uint256 constant ERC20_transfer_selector = 0xa9059cbb00000000000000000000000000000000000000000000000000000000;
uint256 constant ERC20_transfer_to_offset = 0x04;
uint256 constant ERC20_transfer_amount_offset = 0x24;
uint256 constant ERC20_transfer_size = 0x44;

uint256 constant ERC20_decimals_selector = 0x313ce56700000000000000000000000000000000000000000000000000000000;
uint256 constant ERC20_balanceOf_selector = 0x70a0823100000000000000000000000000000000000000000000000000000000;
uint256 constant ERC20_totalSupply_selector = 0x18160ddd00000000000000000000000000000000000000000000000000000000;

uint256 constant SECONDS_IN_A_DAY = 86400;
uint256 constant Memory_pointer = 0x40;

uint256 constant TotalStaked_shift = 224;
uint256 constant RewardDebt_shift = 192;
uint256 constant ProcessedIndex_shift = 160;

uint256 constant RewardTier_threshold_shift = 224;
uint256 constant RewardTier_multiplier_shift = 192;
uint256 constant TimeMultiplier_duration_shift = 224;
uint256 constant TimeMultiplier_multiplier_shift = 192;


uint256 constant StakeInfo_size = 0x60;
uint256 constant StakeInfo_amount_offset = 0x00;
uint256 constant StakeInfo_reward_offset = 0x20;
uint256 constant StakeInfo_startTime_offset = 0x40;

uint256 constant RewardTier_size = 0x40; 
uint256 constant RewardTier_threshold_offset = 0x00;
uint256 constant RewardTier_multiplier_offset = 0x20;

uint256 constant TimeMultiplier_size = 0x40; 
uint256 constant TimeMultiplier_duration_offset = 0x00;
uint256 constant TimeMultiplier_multiplier_offset = 0x20;

