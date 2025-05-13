// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract StringConcat {

    // Solidity does not have a built-in string concatenation function so we need to create our own by converting the strings to bytes and then concatenating the bytes
    function concat(string memory a, string memory b) public pure returns (string memory) {
        bytes memory bytesA = bytes(a);
        bytes memory bytesB = bytes (b);
        string memory result = new string(bytesA.length + bytesB.length);
        bytes memory bytesResult = bytes(result);

        uint j = 0;

        for (uint i = 0; i < bytesA.length; i++) {
            bytesResult[j] = bytesA[i];
            j++;
        }
        for (uint i = 0; i < bytesB.length; i++) {
            bytesResult[j] = bytesB[i]; 
            j++; 
        }
        return string(bytesResult); 
    }
}