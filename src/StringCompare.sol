// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract StringCompare {

    // Solidity does not have a built-in string comparison function so we need to create our own by converting the strings to bytes and then comparing the bytes
    function compare(string memory a, string memory b) public returns (bool) {

        bytes memory bytesA = bytes(a);
        bytes memory bytesB = bytes(b);

        if (bytesA.length != bytesB.length) {
            return false;
        }

        for (uint i = 0; i < bytesA.length; i++) {
            if (bytesA[i] != bytesB[i]) {
                return false;
            }
        }

        return true;
    }
}
