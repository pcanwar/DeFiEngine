
# Staking Rewards Contract

The contract allows users to stake ERC20 tokens in exchange for rewards. Users can stake tokens, withdraw their staked tokens, and claim rewards based on their staking duration and the amount staked.

## Overview

### Key Features

- **Staking**: Users can stake ERC20 tokens.
- **Withdrawal**: Users can withdraw their staked tokens.
- **Reward Claiming**: Users can claim rewards based on their staking activity.
- **Incentives**: Reward multipliers based on staking duration and amount.


### Mathematical Formulas
1. **Reward Per Token Calculation**:
    ```markdown
    accumulatedRewardPerToken = accumulatedRewardPerToken + 
    ((block.timestamp - lastRewardUpdate) * baseRewardRate * 10^tokenDecimals) / totalStaked
    ```

2. **Total Earned Rewards Calculation**:
    ```markdown
    totalRewards = sum(calculateEarnedRewards(events[i], account) for i in range(staker.processedIndex, len(events)))
    ```

3. **Earned Rewards Calculation**:
    ```markdown
    earnedRewards = (stakingEvent.amount * combinedMultiplier * baseRewardRate * stakingDuration) / 10^tokenDecimals
    ```

    where:
    ```markdown
    combinedMultiplier = (timeMultiplier * tierMultiplier) / 10^tokenDecimals
    ```
