// SPDX-License-Identifier: None
pragma solidity ^0.8.25;

// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {StakeInfo} from "./Struct.sol";
import "./Executor.sol";


contract StakingRewards is Executor, Ownable {

    mapping(address => bytes32) public stakers;
    constructor(
    ) Ownable(msg.sender) {} 
    
    function Stake(address stakingToken, uint256 amount) public   {
        _safeTransferFrom(stakingToken, msg.sender, address(this), amount);
    }

    function unStake(address stakingToken, uint256 amount) public   {
        _safeTransfer(stakingToken, msg.sender, amount);
    }


}