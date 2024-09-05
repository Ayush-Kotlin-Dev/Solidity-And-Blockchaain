// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Bank {
    mapping(address => uint) public balances;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict function access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // Modifier to ensure enough balance before withdrawal
    modifier hasEnoughBalance(uint _amount) {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        _;
    }

    // Deposit function
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Only owner can use this function
    function ownerWithdraw(uint _amount) public onlyOwner {
        payable(owner).transfer(_amount);
    }

    // Withdraw function restricted by hasEnoughBalance modifier
    function withdraw(uint _amount) public hasEnoughBalance(_amount) {
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }
}
