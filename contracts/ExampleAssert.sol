// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleAssert {
    uint public balance;

    // Function to increase the balance
    function deposit(uint _amount) public {
        balance += _amount;

        // Use assert to check that balance is never negative (should always be true)
        assert(balance >= _amount); // This condition should never fail
    }

    // Function to decrease the balance
    function withdraw(uint _amount) public {
        require(_amount <= balance, "Insufficient balance");
        
        balance -= _amount;

        // Use assert to ensure that the balance is correctly decreased
        assert(balance >= 0); // This condition should always hold true
    }
}
