// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract SampleFallBack {

    uint public lastValueSent;
    string public messageReceived;

    // Function to set the last value sent manually
    function setLastValue(uint _value) external {
        lastValueSent = _value;
    }
    
    // Receive function to handle plain Ether transfers
    receive() external payable {
        lastValueSent = msg.value;
    }

    // Fallback function to handle unexpected calls
    fallback() external payable {
        // If we receive Ether, we update our `lastValueSent` variable
        if (msg.value > 0) {
            lastValueSent = msg.value;
        }
        messageReceived = string(msg.data);
    }
}
