// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }
}

// Derived contract
contract SecureBank is Ownable {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function ownerWithdraw(uint _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Insufficient contract balance");
        balances[owner] -= _amount;
        payable(owner).transfer(_amount);
    }
}
