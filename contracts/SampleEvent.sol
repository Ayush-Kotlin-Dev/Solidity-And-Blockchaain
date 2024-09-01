
// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract EventExample {

    mapping (address => uint) public tokenBalance ;

    constructor(){
        tokenBalance[msg.sender] = 100 ;
    }


    function sendtoken(address _to ,uint _amount )public returns(bool){

        require(tokenBalance[msg.sender] >= _amount , "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount ;

        return true ;
    }

    event LogEvent(address indexed sender, uint amount);

    function sendEther() public payable {
        emit LogEvent(msg.sender, msg.value);
    }

}


contract Bank {
    mapping(address => uint) public balances;

    event Deposit(address indexed account, uint amount);
    event Withdraw(address indexed account, uint amount);

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value); // Using event as return
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount); // Using event as return
    }
}