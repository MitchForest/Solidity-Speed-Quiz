// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract IsNBitSet {
    function main(bytes32 x, uint256 n) public returns (bool) {
        // return true if the nth bit is set
        // 000....0001 with n = 0 returns true
        // 000....0001 with n = 1 returns false
        // 000....0010 with n = 1 returns true
        
        return (uint256(x) & (1 << n)) != 0;
        // Step 1: Convert bytes32 x to uint256 so we can perform bitwise operations
        // Step 2: (1 << n) creates a bitmask where only the nth bit is 1, and all other bits are 0
        // Step 3: x & bitmask compares each bit of x with the corresponding bit of the mask
        // But since all bits in the mask are 0 except the nth, this operation isolates only the nth bit in x
        // Step 4: If the nth bit in x is 1, the result will be non-zero (specifically 2^n); if it's 0, the result is 0

    }
}

/*
  Notes:
  - "n-th bit" means the bit at position n from the right (0-based index)

  Bitmask logic:
    (1 << 0) = 0x...0001 → checks bit 0
    (1 << 1) = 0x...0002 → checks bit 1
    (1 << 2) = 0x...0004 → checks bit 2
    ...
*/