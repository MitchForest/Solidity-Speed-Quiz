// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelReturnUint {
    function main(address a) public returns (uint256) {
        // call function "bar()" on address a
        // do not use an interface
        // return the return value of the call

        // 1. Get the function selector for bar()
        bytes4 selector = bytes4(keccak256("bar()"));

        // 2. Perform the low-level call. Since bar() takes no arguments
        (bool success, bytes memory returnData) = a.call(abi.encodeWithSelector(selector));

        // 3. Ensure the call was successful
        require(success, "Low-level call to bar() failed");

        // 4. Decode the returnData into a uint256
        uint256 result = abi.decode(returnData, (uint256));

        // 5. Return the decoded uint256 value
        return result;

    }
}

// forge test --match-contract LowLevelReturnTest

