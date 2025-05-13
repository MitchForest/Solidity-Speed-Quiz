// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract RemoveElement {

    // Solidity does not have a built-in function to remove an element from an array so we need to create our own by swapping the element at the index with the last element and then popping the last element

    uint256[] public arr;

    function setArr(uint256[] memory _arr) public {
        arr = _arr;
    }

    function removeElement(uint256 index) public {

        require(index < arr.length, "Index doesn't exist");
        arr[index] = arr[arr.length - 1];
        arr.pop();

    }
}

// forge test --match-contract RemoveElement