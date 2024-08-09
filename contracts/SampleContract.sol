
// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SampleContract{
    string public myString = "Hello WOrld" ;

    function updateString(string memory _newString) public {
        myString=_newString;
    }
}