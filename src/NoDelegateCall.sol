// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.28;

contract NoDelegateCall {
    // your code here
    // Store the contract's actual address at deployment
    address public immutable actualAddress;

    constructor() {
        actualAddress = address(this);
    }
    // hint: https://www.rareskills.io/post/nodelegatecall

    function meaningOfLifeAndEverything() public view returns (uint256 fourtyTwo) {
        // your code here
        // this function should be callable, but not delegatecallable
        // it should return 42

        // Check if the current execution context (address(this)) matches the original deployed address.
        require(address(this) == actualAddress, "Delegatecall not allowed");
        
        fourtyTwo = 42;
    }
}