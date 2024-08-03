//SPDX License-identifier: MIT

// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;
contract MyContract{
    uint256 public myUInt ;
    uint8 public MyUint8 = 2**4;

    function setMyInt(uint _myUint) public {
        myUInt = _myUint;
    }

    function decrementUint() public {
        unchecked{
            myUInt --;
        }
    }

    function incrementUint8() public{
        MyUint8++ ;
    }
}