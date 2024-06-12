// SPDX-License-Identifier: None
pragma solidity ^0.8.25;

// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {StakeInfo} from "./Struct.sol";
import "./Executor.sol";
import { StakerEncoding } from "./StakerEncoding.sol";


contract StakingRewards is Executor, Ownable {

    using StakerEncoding for StakeInfo;
    using StakerEncoding for bytes32;

    mapping(address => bytes32) public stakers;   
    
     constructor(
    ) Ownable(msg.sender) {} 
    
    function Stake(address stakingToken, address staker, uint256 amount) public   {
        _safeTransferFrom(stakingToken, staker, address(this), amount);
        StakeInfo memory info = getStakerInfo(staker);
        info.amount += amount;
        updateStakerInfo(staker, info);
    }

    function UnStake(address stakingToken, address staker, uint256 amount) public   {
        _safeTransfer(stakingToken, staker, amount);
    }

    function getStakerInfo(address staker) public view returns (StakeInfo memory) {
        return stakers[staker].decode();
    }

    function updateStakerInfo(address staker, StakeInfo memory info) internal {
        stakers[staker] = info.encode();
    }


}