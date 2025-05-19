// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract DivUp {

    function divUp(uint256 x, uint256 y) public pure returns (uint256) {
        // return x / y rounded up.
        // if y divides x exactly, return x / y
        // if there is a fractional part in the quotient, add 1 to the answer
        // if y == 0 revert

        // Step 1: Handle division by zero
        if (y == 0) {
            revert("DivUp: division by zero");
        }

        // Calculate the standard (truncated) quotient
        uint256 quotient = x / y;

        // Step 3 & 4: Check for remainder and adjust if necessary
        if (x % y == 0) {
            // No remainder, y divides x exactly.
            return quotient;
        } else {
            // There is a remainder, so round up by adding 1 to the quotient.
            // This addition is safe from overflow because if quotient was type(uint256).max,
            // y would have to be 1 and x%y would be 0, taking the other branch.
            return quotient + 1;
        }
    }
}
