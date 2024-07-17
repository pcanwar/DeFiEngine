// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;

import "./Constant.sol";
// import "./Error.sol";

import { IExecutor } from "./IExecutor.sol";

abstract contract Executor is IExecutor {
    constructor() {
    }


    function _safeTransferFrom(address token, address from, address to, uint256 amount) internal {
        bool success;
        assembly {
            let ptr := mload(Memory_pointer)
            mstore(ptr, ERC20_transferFrom_selector)
            mstore(add(ptr, ERC20_transferFrom_from_offset), from)
            mstore(add(ptr, ERC20_transferFrom_to_offset), to)
            mstore(add(ptr, ERC20_transferFrom_amount_offset), amount)
            success := call(gas(), token, 0, ptr, ERC20_transferFrom_size, 0, 0)
        }
        // require(success, "transfer failed");
        if (!success) {
            revert TransferFailed();
        }
    }

    function _safeTransfer(address token, address to, uint256 amount) internal {
        bool success;
        assembly {
            let ptr := mload(Memory_pointer)
            mstore(ptr, ERC20_transfer_selector)
            mstore(add(ptr, ERC20_transfer_to_offset), to)
            mstore(add(ptr, ERC20_transfer_amount_offset), amount)
            success := call(gas(), token, 0, ptr, ERC20_transfer_size, 0, 0)
        }
        if (!success) {
            revert TransferFailed();
        }
    }


}