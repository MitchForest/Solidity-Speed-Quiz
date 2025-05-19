// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelArgs2 {
    function main(address a, uint256 x, uint256 y) public {
        // call rare(x, y) using a low-level call
        // if the low level call reverts, revert also

        // 1. Get the function selector for rare(uint256,uint256)
        bytes4 selector = bytes4(keccak256("rare(uint256,uint256)"));

        // 2. Encode the calldata with the selector and the arguments x and y
        bytes memory calldataPayload = abi.encodeWithSelector(selector, x, y);

        // 3. Perform the low-level call
        (bool success, ) = a.call(calldataPayload);

        // 4. If the call failed, revert.
        require(success, "Low-level call to rare(uint256,uint256) failed");

    }
}