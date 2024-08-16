
// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

contract ExampleExceptionRequire{
    
    mapping(address => uint) public balanceRecieved ;

    
    function recieveMoney() public payable {
        balanceRecieved[msg.sender] += msg.value;
    }

    function withdrawlMoney(address payable _to , uint _amount) public {
        require(_amount <= balanceRecieved[msg.sender] , "You can't withdraw less than you have received ") ;
            balanceRecieved[msg.sender] -= _amount;
            _to.transfer(_amount);
        
    }

}