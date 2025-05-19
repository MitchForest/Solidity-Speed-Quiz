// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract RationalFunction {

    function f(uint256 x) public pure returns (uint256) {
        // return the function f(x) = 1 / (1 - 1/x) with two decimals rounded down
        // f(0) = revert
        // f(1) = revert
        // f(2) = 200
        // f(3) = 150
        // f(4) = 133
        // f(5) = 125

        if (x == 0 || x == 1) {
            revert("RationalFunction: x cannot be 0 or 1");
        }

        // Simplified f(x) = x / (x - 1)
        // To scale by 100 for two decimal places and round down:
        // result = (x * 100) / (x - 1)
        // Solidity's integer division naturally rounds down.
        
        uint256 numerator = x * 100;
        uint256 denominator = x - 1;
        
        return numerator / denominator;
    }
}
