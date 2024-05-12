// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface iStake {
    // change the event names
    event Transferred(address indexed holder, uint256 amount);
    event Status(uint256 fee);

    function withdraw(uint256 amount) external;
    function deposit(uint256 amount) external;

}

// this is a mock contract .. 
contract Stake is iStake, ReentrancyGuard, Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;
    using SafeERC20 for IERC20;
    
    // keep holders
    EnumerableSet.AddressSet private holders;
    IERC20 private immutable token;
    uint256 private totalRewards;
    // reward rate 10% per year
    uint256 private rewardRate = 1000;
    uint256 constant private rewardInterval = 30 days ;// 365 days;
    // staking fee 2.30%
    uint256 private stakeFee = 230;
    //  possible to claim after 30 days
    uint256 private  claimAfterPeriodOfTime = 30 days;
    
    mapping (address => uint256) private balance;
    mapping (address => uint256) private stakingLockTime;
    mapping (address => uint256) private stakingClaimedTime;

    constructor (address initialOwner, address tokenAddress)  Ownable(initialOwner){
        require( tokenAddress != address(0) , "Token address cannot be zero");
        token = IERC20(tokenAddress);
    }
    
    function resetClaimAfterPeriod(uint256 _claimAfterPeriodOfTime) external  onlyOwner {
        claimAfterPeriodOfTime = _claimAfterPeriodOfTime;
    }
    
    function resetStakingFee(uint256 _stakeFee) external onlyOwner {
        stakeFee = _stakeFee;
    }
    
    function resetRewardRate (uint256 _rewardRate) external onlyOwner {
        rewardRate = _rewardRate;
        emit Status(rewardRate);
    }
    
    function totalRewardsAmount() external view returns(uint256){
        return totalRewards;
    }
     
 function setAccount(address account) private {
        require(account != address(0) , "Account address cannot be zero");
        // require(account == msg.sender, "Only the account can access this function.");

        uint256 pendingBalance = calculatePendingStake(account);
        if (pendingBalance > 0) {
            uint256 stakedAmount = balance[account];
            stakedAmount += pendingBalance;
            balance[account] = stakedAmount;
            uint256 _totalRewards = totalRewards;
            _totalRewards += stakedAmount;
            totalRewards = _totalRewards;
            emit Transferred(account, pendingBalance);
        }
        stakingClaimedTime[account] = block.timestamp;
    }
    
    function calculatePendingStake(address _holder) public view returns (uint256) {
        require(_holder != address(0) , "Holder address cannot be zero");
        require(_holder == msg.sender,"Holder address"); // need to check it may unnecessarily [read func]
        uint256 calculateTimeDiff = block.timestamp - stakingClaimedTime[_holder];
        uint256 stakedAmount = balance[_holder];
        uint256 pendingBalanceAfterStaking ;
        uint256 _amount = stakedAmount * rewardRate * calculateTimeDiff;
        pendingBalanceAfterStaking = (_amount/ rewardInterval) / 1e4;
       
        return pendingBalanceAfterStaking;
    }
    
    function getHolders() public view returns (uint256) {
        return holders.length();
    }
    
    // transfer the fees into this smart contract. 
    // deposit the current amount after paying fees 
    function deposit(uint256 amount) external nonReentrant {
        require(amount > 0, "Cannot deposit");
        require(token.transferFrom(msg.sender, address(this), amount)== true, " Approve Tokens");
        setAccount(msg.sender);

        uint256 callItFee = amount * stakeFee;
        uint256 fee = callItFee / 1e4;
        uint256 currentAmountAfterFee = amount- fee;             
        if (!holders.contains(msg.sender)) {
            holders.add(msg.sender);
            stakingLockTime[msg.sender] = block.timestamp;
        } else if (holders.contains(msg.sender)) {
            stakingLockTime[msg.sender] = block.timestamp;
        }
        balance[msg.sender] += currentAmountAfterFee;
        token.safeTransferFrom(msg.sender, address(this), fee);
        emit Status(fee);
        emit Transferred(msg.sender, currentAmountAfterFee);

    }
    
 
    function withdraw(uint256 amount) external nonReentrant {
        require(amount > 0 , "No balance");
        require(!holders.contains(msg.sender) , "Caller is not a holder");

        uint256 accountRewarded = calculatePendingStake(msg.sender);
        require(balance[msg.sender] + accountRewarded >= amount, "Low Balance");
        require((block.timestamp - stakingLockTime[msg.sender]) > claimAfterPeriodOfTime, "Claim your stakes after");
        setAccount(msg.sender);
        uint256 amountToKeep = balance[msg.sender] - amount ;
        balance[msg.sender] = amountToKeep;
        if (holders.contains(msg.sender) && balance[msg.sender] <= 0) {
            holders.remove(msg.sender);
        }
        token.safeTransferFrom(address(this) , msg.sender, amount);
        // need event
    }
    

    function balanceAfterReward(address account) public view returns(uint256){
        return balance[account] + calculatePendingStake(account);
    } 
    
    
    function balanceOf(address account) public view returns(uint256){
        return token.balanceOf(account);
    }
    
    
    
    function _transfer(address _tokenAddrress , uint256 _amount) public onlyOwner {
        require(_tokenAddrress != address(token), "not allowed");
        token.safeTransferFrom(msg.sender, address(this), _amount);

    }
    
    function transferBack(address _tokenAddr, address _to, uint256 _amount) public onlyOwner {
        require(_tokenAddr != address(token), "Zero_Address");
        token.safeTransferFrom(address(this), _to, _amount);
    }
}