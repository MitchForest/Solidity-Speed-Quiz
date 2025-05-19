// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract Account2 {
    address immutable owner;

    constructor(address _owner) payable {
        owner = _owner;
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        (bool ok, ) = owner.call{value: address(this).balance}("");
        require(ok);
    }
}

contract AccountMaker {
    function makeAccount(address owner) external payable returns (address) {
        // use create2 to create an account with the owner address
        // the salt should be the owner address
        // the value sent to them should be msg.value


        // 1. Prepare the initialization bytecode for Account2.
        // This includes the creation code of Account2 and its constructor arguments (the owner address).
        bytes memory bytecode = abi.encodePacked(
            type(Account2).creationCode,
            abi.encode(owner)
        );

        // 2. Prepare the salt. It MUST match the way the test file calculates it for prediction.
        // Test uses: bytes32 ownerB32 = bytes32(bytes20(uint160(owner)));
        bytes32 salt = bytes32(bytes20(uint160(owner)));

        // 3. Deploy the contract using CREATE2 opcode.
        address newAccountAddress;

        // The `create2` opcode takes 4 arguments:
        // - value: amount of ETH to send with the deployment (msg.value or callvalue() in assembly)
        // - offset: memory offset of the bytecode to deploy
        // - size: size of the bytecode to deploy
        // - salt: the 32-byte salt
        assembly {
            newAccountAddress := create2(
                callvalue(), // msg.value - the Ether to send to the new contract
                add(bytecode, 0x20), // Pointer to the start of the bytecode (skip the length part of `bytes memory`)
                mload(bytecode),     // Length of the bytecode
                salt                 // The salt we prepared, now matching test prediction
            )
        }

        // 4. Check if deployment was successful and return the address.
        require(newAccountAddress != address(0), "CREATE2_DEPLOY_FAILED");
        return newAccountAddress;
    }
}
