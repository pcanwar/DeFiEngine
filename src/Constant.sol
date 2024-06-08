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

uint256 constant SECONDS_IN_A_DAY = 86400;

