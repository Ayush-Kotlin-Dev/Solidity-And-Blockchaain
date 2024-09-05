// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// Base contract
contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Function to check if the caller is the owner
    function isOwner() public view returns(bool) {
        return msg.sender == owner;
    }
}

// Derived contract inheriting from Ownable
contract MyContract is Ownable {
    string public contractName;

    constructor(string memory _name) {
        contractName = _name;
    }

    // This function can only be called by the owner
    function changeName(string memory _newName) public {
        require(isOwner(), "Only owner can change the name");
        contractName = _newName;
    }
}
