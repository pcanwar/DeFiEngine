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

uint256 constant STAKER_INFO_START_TIME_SHIFT = 0;
uint256 constant STAKER_INFO_LAST_UPDATE_TIME_SHIFT = 64;
uint256 constant STAKER_INFO_IS_ACTIVE_SHIFT = 128;
uint256 constant STAKER_INFO_AUTO_RENEW_SHIFT = 129;
uint256 constant STAKER_INFO_AMOUNT_SHIFT = 130;
uint256 constant STAKER_INFO_REWARD_SHIFT = 194;
uint256 constant STAKER_INFO_STAKING_OPTION_ID_SHIFT = 258;
uint256 constant STAKER_INFO_REWARD_EARNED_SHIFT = 322;
uint256 constant STAKER_INFO_PERSONAL_QUOTA_SHIFT = 386;
uint256 constant STAKER_INFO_USER_REWARD_PER_TOKEN_PAID_SHIFT = 450;

uint256 constant STAKING_OPTION_DURATION_SHIFT = 0x00;
uint256 constant STAKING_OPTION_PERIOD_FINISH_SHIFT = 0x40; 
uint256 constant STAKING_OPTION_LAST_UPDATE_TIME_SHIFT = 0x80; 
uint256 constant STAKING_OPTION_IS_ACTIVE_SHIFT = 0xC0; 
uint256 constant STAKING_OPTION_REWARD_RATE_SHIFT = 0xC8; 
uint256 constant STAKING_OPTION_MIN_STAKE_SHIFT = 0x100; 
uint256 constant STAKING_OPTION_MAX_STAKE_SHIFT = 0x140; 
uint256 constant STAKING_OPTION_TOTAL_QUOTA_SHIFT = 0x180; 
uint256 constant STAKING_OPTION_REMAINING_QUOTA_SHIFT = 0x1C0; 
uint256 constant STAKING_OPTION_REWARD_PER_TOKEN_STORED_SHIFT = 0x200; 