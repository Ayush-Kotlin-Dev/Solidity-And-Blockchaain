// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract SimpleBlockchain {
    
    struct Block {
        uint256 index;
        uint256 timestamp;
        bytes32 previousHash;
        bytes32 merkleRoot;
        bytes32 blockHash;
    }
    
    Block[] public blockchain;

    // Function to create the genesis block
    constructor() {
        createBlock("Genesis Block");
    }
    // Function to create a new block
    function createBlock(string memory data) public {
        uint256 index = blockchain.length;
        uint256 timestamp = block.timestamp;
        bytes32 previousHash = index > 0 ? blockchain[index - 1].blockHash : bytes32(0);
        bytes32 merkleRoot = keccak256(abi.encodePacked(data));
        bytes32 blockHash = keccak256(abi.encodePacked(index, timestamp, previousHash, merkleRoot));
        
        blockchain.push(Block(index, timestamp, previousHash, merkleRoot, blockHash));
    }
    
    // Function to get the latest block
    function getLatestBlock() public view returns (Block memory) {
        return blockchain[blockchain.length - 1];
    }
}
