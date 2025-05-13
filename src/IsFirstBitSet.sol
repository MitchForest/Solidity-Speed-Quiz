// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract IsFirstBitSet {

    // Return true if the first bit (rightmost) is set (aka 1) in bytes32
    function main(bytes32 x) public returns (bool) {
        // return true if the first bit is set
        // for example 0x000....0001 returns true
        // for example 0x000....0010 returns false
 
        return (uint256(x) & 1) == 1;
        // Convert x to uint256 to allow bitwise operations
        // Bitwise AND with 1 to isolate the rightmost bit
        // If the result is 1, the bit is set; otherwise, it's not
    }
}

/*
  Notes:
  - bytes32 is a 256-bit value (same asuint256)
  - "First bit" here means the rightmost one
  - To check if the first bit is 1, we do: x & 1 == 1

  Bitwise AND Basics:
    0 & 0 = 0
    1 & 0 = 0
    0 & 1 = 0
    1 & 1 = 1   (first bit is set & 1 = 1)

  Examples:
    0x...0010 & 0x...0001 = 0x...0000 → result is 0 (bit is not set)
    0x...0001 & 0x...0001 = 0x...0001 → result is 1 (bit is set)
*/