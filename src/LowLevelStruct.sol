// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelStruct {
    function main(address a) public returns (uint256 x, uint256 y) {
        // call function "point()" on address a
        // do not use an interface
        // point() returns a struct with two uint256 fields, i.e. 
        // struct Point {
        //     uint256 x;
        //     uint256 y;
        // }
        // return the two fields
        // revert if the low level call reverts

        // 1. Get the function selector for point()
        bytes4 selector = bytes4(keccak256("point()"));

        // 2. Perform the low-level call. Since point() takes no arguments
        (bool success, bytes memory returnData) = a.call(abi.encodeWithSelector(selector));

        // 3. If the call failed, revert. This satisfies the requirement
        require(success, "Low-level call to point() failed");

        // 4. Decode the returnData. Since point() returns a struct { uint256 x; uint256 y; }
        (uint256 xVal, uint256 yVal) = abi.decode(returnData, (uint256, uint256));

        // 5. Return the decoded struct fields
        return (xVal, yVal);

    }
}   