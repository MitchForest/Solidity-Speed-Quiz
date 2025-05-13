// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract ConvertToNegative {
    error TooBig();

    function convertToNegative(uint256 x) external pure returns (int256) {
        if (x > uint256(type(int256).max)) { // if x is greater than the max positive value of int256 aka 2^255 - 1
            if (x == uint256(type(int256).max) + 1) { // if x is equal to the max positive value of int256 + 1 aka 2^255
                return type(int256).min;
            }
            revert TooBig();
        }

        return -int256(x);
    }
}

/*
  Notes:
  - uint256 range: [0, 2^256 - 1]
  - int256 range: [-2^255, 2^255 - 1]
  - The most negative value an int256 can hold is -2^255 aka type(int256).min
  - So the largest uint256 that can be safely negated (as -x) is 2^255 aka type(int256).max + 1
*/