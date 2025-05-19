// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {TryCatchReason} from "../src/TryCatchReason.sol";

contract Rare1 {
    function rare(uint256) external {

    }
}

contract Rare2 {
    function rare(uint256) external {
        revert("rare");
    }
}

contract TryCatchReasonTest is Test {
    TryCatchReason c;

    function setUp() public {
        c = new TryCatchReason();
    }

    function test_TryCatchReason(uint256 x) public {
        Rare1 r1 = new Rare1();
        bytes memory result = c.main(address(r1), x);
        string memory resultString = bytesToString(result);
        assertEq(resultString, "");
    }

    function test_TryCatchReason_Revert() public {
        Rare2 r2 = new Rare2();
        bytes memory result = c.main(address(r2), 1);

        // Debugging: Print the lengths and byte values
        emit log_uint(result.length);
        emit log_bytes(result);

        // Use the raw bytes representation of "rare" as expected
        bytes memory expected = hex"72617265";
        emit log_uint(expected.length);
        emit log_bytes(expected);

        // Direct byte comparison
        assertEq(result, expected);
    }

    function bytesToString(bytes memory data) internal pure returns (string memory) {
        return string(data);
    }
}