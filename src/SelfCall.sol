// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract SelfCall {

    bool public success;
    function main() public {
        // call me() on this contract
        // think outside the box! You can only write code here, no creating external contracts
        // or modifying other parts of this contract

        // To make msg.sender == address(this) inside me(), we need to perform an external call from this contract to itself.

        // 1. Get the function signature for me()

        // 2. Prepare the calldata. Since me() takes no arguments, it's just the selector
        bytes memory calldataPayload = abi.encodeWithSignature("me()");

        // 3. Perform the low-level call to this contract's address
        (bool callSuccess, ) = address(this).call(calldataPayload);

        // 4. Ensure the self-call was successful (i.e., me() didn't revert for other reasons)
        require(callSuccess, "Self-call to me() failed");
        
        // After this, the success flag in storage should be true due to me() executing successfully
    }

    function me() external {
        require(msg.sender == address(this), "not self");
        success = true;
    }
}