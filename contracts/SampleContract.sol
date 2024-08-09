// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SampleContract{
    string public myString = "Hello WOrld" ;

    function updateString(string memory _newString) public payable {
        if(msg.value == 1 ether){
            myString=_newString;
        }else{
            payable(msg.sender).transfer(msg.value);
        }
    }
    // State variable to store the owner's address
    address public owner;

    // State variable to store the total amount received
    uint public totalReceived;

    // Constructor to set the owner as the address that deploys the contract
    constructor() {
        owner = msg.sender;
    }

    // Payable function to receive Ether and update total received
    function receiveEther() public payable {
        // Update the total amount received with the value of Ether sent
        totalReceived += msg.value;
    }

    // Function to withdraw all Ether from the contract to the owner
    function withdraw() public payable {
        require(msg.sender == owner, "Only the owner can withdraw");
        payable(owner).transfer(address(this).balance);
    
    }

    // Function to check the contract's balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
