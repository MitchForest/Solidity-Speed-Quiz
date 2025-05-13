// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract StringIndex {

    // Convert the string to bytes and return the indexed byte as a new single-character string.
    function main(string memory str, uint256 index) public returns (string memory) {
        // return the character at index in str
        // assume str only consists of ascii characters
        bytes memory strBytes = bytes(str);
        bytes1 char = strBytes[index];
        return string(abi.encodePacked(char));
    } 
}