// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


contract ExampleMapping{

    mapping(uint => bool)public myMapping ;
    mapping(address => bool) public myAddressMapping ;


    function setValue(uint _index) public {
        myMapping[_index] = true ;
    }

    function setMyAddresstoTrue() public {
        myAddressMapping[msg.sender] = true ;
    }

    //My Example
    mapping(address => uint) public balances;

    // Function to set the balance for a given address
    function setBalance(address _account, uint _amount) external {
        balances[_account] = _amount;
    }

    // Function to get the balance for a given address
    function getBalance(address _account) external view returns (uint) {
        return balances[_account];
    }

}