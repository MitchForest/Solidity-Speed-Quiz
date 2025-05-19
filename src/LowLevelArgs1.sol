// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelArgs1 {
    function main(address a, uint256 x) public {
        // call rare(x) using a low-level call
        // if the low level call reverts, revert also

        // 1. Get the function selector for rare(uint256)
        bytes4 selector = bytes4(keccak256("rare(uint256)"));

        // 2. Encode the calldata with the selector and the argument x
        bytes memory calldataPayload = abi.encodeWithSelector(selector, x);

        // 3. Perform the low-level call
        (bool success, ) = a.call(calldataPayload);

        // 4. If the call failed, revert
        require(success, "Low-level call to rare(uint256) failed");

    }
}