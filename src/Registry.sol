// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./StakerEncoding.sol";
import {StakerInfo, User} from "./Struct.sol";

contract Registry {
    using StakerEncoding for StakerInfo;

    mapping(address => mapping(uint256 => User)) public stakerData;
    mapping(address => uint256) public stakerCount;

    /**
     * @dev Stores encoded staker information in the registry.
     * @param info The StakerInfo to encode and store.
     * @param user The user address associated with the staker info.
     */
    function encodeAndStore(StakerInfo memory info, address user) internal {
        uint256 index = stakerCount[user]++;
        bytes32[2] memory encoded = StakerEncoding.encode(info);
        stakerData[user][index] = User({
            re1: encoded[0],
            re2: encoded[1]
        });
    }

    /**
     * @dev Decodes and retrieves staker information for a given user and index.
     * @param user The user address to retrieve staker info for.
     * @param index The index of the staker entry to decode.
     * @return StakerInfo The decoded staker info.
     */
    function decodeStakerInfo(address user, uint256 index) external view returns (StakerInfo memory) {
        require(index < stakerCount[user], "Index out of bounds");
        User memory userEncoded = stakerData[user][index];
        bytes32[2] memory encoded = [userEncoded.re1, userEncoded.re2];
        return StakerEncoding.decode(encoded);
    }
}
