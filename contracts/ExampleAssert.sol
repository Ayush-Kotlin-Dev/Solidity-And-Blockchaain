// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleAssert {
    // uint public balance;

    // // Function to increase the balance
    // function deposit(uint _amount) public {
    //     balance += _amount;

    //     // Use assert to check that balance is never negative (should always be true)
    //     assert(balance >= _amount); // This condition should never fail
    // }

    // // Function to decrease the balance
    // function withdraw(uint _amount) public {
    //     require(_amount <= balance, "Insufficient balance");
        
    //     balance -= _amount;

    //     // Use assert to ensure that the balance is correctly decreased
    //     assert(balance >= 0); // This condition should always hold true
    // }

    //Second Example

    mapping(address => uint8) public balanceRecieved ;

    
    function recieveMoney() public payable {
        assert(msg.value == uint(msg.value));
        balanceRecieved[msg.sender] += uint8(msg.value);
    }

    function withdrawlMoney(address payable _to , uint8 _amount) public {
        require(_amount <= balanceRecieved[msg.sender] , "You can't withdraw less than you have received ") ;
            balanceRecieved[msg.sender] -= _amount;
            _to.transfer(_amount);
        
    }
}
