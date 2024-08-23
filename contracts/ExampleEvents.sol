// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Voting {
    event VoteCasted(address indexed voter, uint256 indexed candidateId);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    address public owner;
    mapping(uint256 => uint256) public votes;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
    

    function vote(uint256 candidateId) public {
        votes[candidateId] += 1;
        emit VoteCasted(msg.sender, candidateId);
    }
}
