// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract Multiplication {
    function multiply(uint8 rewards, uint8 numDays) public pure returns (uint256 totalRewards) {
        // TODO: Implement the logic to calculate the total rewards, which is
        // the number of rewards multiplied by the number of days.
        
        // uint8 is an 8-bit unsigned integer (0–255)
        // uint256 is a 256-bit unsigned integer (0–2^256 - 1)
        // Multiplying two uint8 values can overflow (e.g., 250 * 2 = 500, which overflows uint8)
        // To avoid overflow, cast to uint256 before multiplying
        totalRewards = uint256(rewards) * uint256(numDays);
        return totalRewards;
    }
}