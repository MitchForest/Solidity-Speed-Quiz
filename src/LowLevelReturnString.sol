// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelReturnString {
    function main(address a) public returns (string memory) {
        // call function "baz()" on address a
        // do not use an interface
        // baz() returns a string. Return the string.
        // However, if baz reverts, return an empty string 

        // 1. Get the function selector for baz()
        bytes4 selector = bytes4(keccak256("baz()"));

        // 2. Perform the low-level call
        (bool success, bytes memory returnData) = a.call(abi.encodeWithSelector(selector));

        // 3. Handle the result based on success status
        if (success) {
            // If the call succeeded, decode the returnData as a string and return it
            return abi.decode(returnData, (string));
        } else {
            // If the call failed (reverted), return an empty string
            return "";
        }
    }
}
