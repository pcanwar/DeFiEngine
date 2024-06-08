// SPDX-License-Identifier: NONE
pragma solidity ^0.8.25;

import "./Constant.sol";
import { IExecutor } from "./IExecutor.sol";
abstract contract Executor is IExecutor {
    constructor() {
    }
    function _safeTransferFrom(address token, address from, address to, uint256 amount) internal {
        bool success;
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, ERC20_transferFrom_selector)
            mstore(add(ptr, 0x04), from)
            mstore(add(ptr, 0x24), to)
            mstore(add(ptr, 0x44), amount)
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
            let ptr := mload(0x40)
            mstore(ptr, ERC20_transfer_selector)
            mstore(add(ptr, 0x04), to)
            mstore(add(ptr, 0x24), amount)
            success := call(gas(), token, 0, ptr, ERC20_transfer_size, 0, 0)
        }
        if (!success) {
            revert TransferFailed();
        }
    }

}