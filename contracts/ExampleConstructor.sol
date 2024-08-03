// SPDX-License-Identifier: MIT
pragma solidity 0.8.15 ;

contract ConstructorExample {
    address public owner;
    uint256 public initialValue;

    // Constructor function
    constructor(uint256 _initialValue) {
        owner = msg.sender;  // Set the owner to the address that deploys the contract
        initialValue = _initialValue;  // Initialize the initialValue variable
    }
    
    // Example function to get the owner
    function getOwner() public view returns (address) {
        return owner;
    }
}
