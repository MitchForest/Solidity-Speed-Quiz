// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;
contract Bytes {

    // Create a dynamic bytes array of length z and populate it with sequential byte values from 0x00 to 0x(z-1)
    function main(uint8 z) public returns (bytes memory) {
        // if z = 0, return empty bytes
        // if z = 1, return bytes 0x00
        // if z = 2, return bytes 0x0001
        // if z = 3, return bytes 0x000102
        // if z = 4, return bytes 0x00010203
        // ...
        // etc
        bytes memory result = new bytes(z);

        for (uint8 i = 0; i < z; i++){
            result[i] = bytes1(i);
            // iteration 1: 5-byte array [0x00, 0x00, 0x00, 0x00, 0x00]; hex 0x00
            // iteration 2: [0x00, 0x01, 0x00, 0x00, 0x00]; 0x0001
            // iteration 3: [0x00, 0x01, 0x02, 0x00, 0x00]; 0x000102
            // iteration 4: [0x00, 0x01, 0x02, 0x03, 0x00]; 0x00010203
            // iteration 5: [0x00, 0x01, 0x02, 0x03, 0x04]; 0x0001020304
        }

        return result;

   }
}