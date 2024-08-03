
// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;
contract StringsEsxample{
    
    string public myString = "Ayush" ;
    bytes public myBytes = "Hello World";

    function setMyString(string memory _myString) public {

        myString = _myString;
    }


    function compareTwoString(string memory _myString) public view returns (bool){
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));
    }
}