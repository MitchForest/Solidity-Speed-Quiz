// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

library StorageSetLib {

    // it should increment the value at key 3 - This refers to increment3
    // implement increment3(...)
    function increment3(mapping(uint256 => uint256) storage self) internal {
        self[3] += 1;
    }
}


contract MappingSet {

    mapping(uint256 => uint256) public m; // m[3] will be 0 by default

    using StorageSetLib for mapping(uint256 => uint256);

    function main() public {
        //m.increment3();
        m.increment3(); // Call the library function attached to the mapping
    }
}