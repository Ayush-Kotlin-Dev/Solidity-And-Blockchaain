// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract LowLevelExample {
    function sendEther(address payable _to) public payable {
        // Using call to send Ether, returns a boolean indicating success/failure
        (bool success, ) = _to.call{value: msg.value}("");
        require(success, "Call failed");
    }

    function delegateToOtherContract(address _otherContract) public {
        // Use delegatecall to execute code in the context of this contract
        (bool success, ) = _otherContract.delegatecall(
            abi.encodeWithSignature("someFunction()")
        );
        require(success, "Delegatecall failed");
    }

    function readDataFromOtherContract(address _otherContract) public view returns (bytes memory) {
        // Use staticcall for a read-only function call
        (bool success, bytes memory data) = _otherContract.staticcall(
            abi.encodeWithSignature("someViewFunction()")
        );
        require(success, "Staticcall failed");
        return data;
    }
}
