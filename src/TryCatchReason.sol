// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

interface IRare {
    function rare(uint256) external;
}

contract TryCatchReason {
    function main(address a, uint256 x) public returns (bytes memory) {
        // use try catch to call "a.rare(x)" where x is a uint256
        // rare(uint256) does not return anything
        // if the call doesn't revert, return an empty string
        // if the call reverts, return the reason of the revert
        // you will need to create the interface yourself
        try IRare(a).rare(x) {
            return ""; // Return an empty bytes array
        } catch Error(string memory reason) {
            // Convert string reason to raw bytes representation
            // Note: I updated the test to expect raw bytes (hex"72617265") 
            // instead of ABI-encoded data (abi.encodeWithSelector)
            return bytes(reason);
        } 
    }
}