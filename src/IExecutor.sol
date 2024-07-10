// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;

interface IExecutor {
     error TransferFromFailed();
     error TransferFailed();
     error InsufficientBalance();
     error InvalidTokenAddress(); 
     error AddressNotContract();
     error InvalidTokenAmount();
     error InvalidOwner();

}