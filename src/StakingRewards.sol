// SPDX-License-Identifier: None
pragma solidity ^0.8.25;

// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {StakeInfo} from "./Struct.sol";
import "./Executor.sol";
import { StakerEncoding } from "./StakerEncoding.sol";


contract StakingRewards is Executor {
    
    using StakerEncoding for StakeInfo;
    using StakerEncoding for bytes32;
    using SafeERC20 for IERC20;
    
    uint256 private _totalSupply;

    IERC20 public _stakingToken;

    mapping(IERC20 => bool) public _rewardToken;
    // mapping(IERC20 => bool) public _stakingToken;

    mapping(uint256 => uint256) public timeMultipliers;

    mapping(address => bytes32) public _stakers;
    mapping(address => uint256) public _rewards;
    mapping(address account => uint256) private _balances;

    event ClaimedRewards(address account, uint256 reward);

    /*
    * A cryptocurrency address has to be supported
    */
    // modifier stakingTokenInterface(address _contract) {
    //     require(_stakingToken[IERC20(_contract)] == true,"Contract address is not Supported ");
    //     _;
    // }

    /*
    * A cryptocurrency address has to be supported
    */
    modifier rewardTokenInterface(address _contract) {
        require(_rewardToken[IERC20(_contract)] == true,"Contract address is not Supported ");
        _;
    }
     constructor(){
        // rewardToken = IERC20(_rewardToken);
        // _rewardToken[IERC20(rewardToken_)] = true;
        // _stakingToken[IERC20(stakingToken_)] = true;
        // _stakingToken = IERC20(stakingToken_);
    } 

    function init(address stakingToken_, address rewardToken_) external {
        _rewardToken[IERC20(rewardToken_)] = true;
        _stakingToken = IERC20(stakingToken_);
    }

    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }
    // uncompleted 
    function Stake(address staker, uint256 amount) public    {
        unchecked {
        _totalSupply += amount;
        }
        address stakingToken_ = address(_stakingToken);
        _balances[staker] += amount;
        StakeInfo memory info = getStakerInfo(staker);
        info.amount += amount;
        updateStakerInfo(staker, info);

        _safeTransferFrom(stakingToken_, staker, address(this), amount);
 
    }

    function UnStake(address staker, uint256 amount) public   {

        unchecked {
        _totalSupply -= amount;
        }
        address stakingToken_ = address(_stakingToken);

        _balances[staker] -= amount;
        // better to return a boolen for _safeTransfer
        _safeTransfer(stakingToken_, staker, amount);
    }

    function claimedRewards(address rewardToken_) public rewardTokenInterface(rewardToken_){
        // implemet non reentrant and check and decrease the total supply . 

        uint256 rewardsAmount = _rewards[msg.sender];
        if (rewardsAmount > 0) {
            _rewards[msg.sender] = 0;
            // address _rewardToken = address(rewardToken);

            _safeTransfer(rewardToken_, msg.sender, rewardsAmount);
            emit ClaimedRewards(msg.sender, rewardsAmount);  
        }
        
    }

    function getStakerInfo(address staker) public view returns (StakeInfo memory) {
        return _stakers[staker].decode();
    }

    function updateStakerInfo(address staker, StakeInfo memory info) internal {
        _stakers[staker] = info.encode();
    }


}