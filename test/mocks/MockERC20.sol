// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20{

    constructor() ERC20("x","x") {}

    function mainTokens(address to, uint256 tokens) external  {
        _mint(to, tokens);
    }

}