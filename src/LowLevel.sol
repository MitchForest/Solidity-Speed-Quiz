// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevel {
    function main(address a) public returns (bool) {
        // call function "foo()" on address a
        // do not use an interface, use a low level call
        // return true if the call succeeded
        // return false if the call failed

        // Get the function selector for foo()
        bytes4 selector = bytes4(keccak256("foo()"));

        // Perform the low-level call
        (bool success, ) = a.call(abi.encodeWithSelector(selector));

        return success;
    }
}
