// SPDX-License-Identifier: None
pragma solidity ^0.8.25;

// import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import {StakeInfo} from "./Struct.sol";
import "./Executor.sol";


contract StakingRewards is Executor, ReentrancyGuard, Ownable {
    // using SafeERC20 for IERC20;

    constructor(
    ) Ownable(msg.sender) {} 
    function Stake(uint256 amount) public nonReentrant  {
        _safeTransferFrom(stakingToken, address(this), msg.sender, amount);

    }


}