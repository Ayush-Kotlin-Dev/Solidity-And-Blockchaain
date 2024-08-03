// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleMesSender{

    address public someAddress ;


     function updateSomeAddress() public {
        someAddress = msg.sender ;
     }
}