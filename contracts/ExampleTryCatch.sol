// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract AnotherContract {
    function willFail() external pure {
        require(false, "This function always fails!");
    }
}

contract TryCatchExample {
    string public lastError;

    function callExternalFunction(address _contract) public {
        AnotherContract instance = AnotherContract(_contract);
        
        // Attempt to call the external function and handle any errors
        try instance.willFail() {
            // If the function call succeeds
            lastError = "Call succeeded";
        } catch Error(string memory reason) {
            // If the function call fails with a revert reason
            lastError = reason;
        } catch (bytes memory lowLevelData) {
            // If the function call fails without a revert reason
            lastError = "Low-level error";
        }
    }
}
