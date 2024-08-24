// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

// contract AnotherContract {
//     function willFail() external pure {
//         require(false, "This function always fails!");
//     }
// }

// contract TryCatchExample {
//     string public lastError;

//     function callExternalFunction(address _contract) public {
//         AnotherContract instance = AnotherContract(_contract);
        
//         // Attempt to call the external function and handle any errors
//         try instance.willFail() {
//             // If the function call succeeds
//             lastError = "Call succeeded";
//         } catch Error(string memory reason) {
//             // If the function call fails with a revert reason
//             lastError = reason;
//         } catch (bytes memory lowLevelData) {
//             // If the function call fails without a revert reason
//             lastError = "Low-level error";
//         }
//     }
// }


contract Willthrow{
    function aFunction() public pure {
        // require(false , "Error Function by Ayush ");
        assert(false);
    }

}

contract ErrorHandling {
    event ErrorLogging(string reason);
    event ErrorlogCode(uint code );
    event ErrorLogByte(bytes lowLevelData);

    function CatchTheError () public {
        Willthrow will = new Willthrow();
        try will.aFunction(){
             // This code will not be executed if the above code throws an exception
            //  print("Inside Try block");
         } catch Error (string memory reason) {
             // This code will be executed if the above code throws an exception
            //  print("Inside Catch block");
            emit ErrorLogging(reason);
         } catch Panic (uint errorCode){
            emit ErrorlogCode(errorCode);
         } catch (bytes memory lowLevelData) {
            emit ErrorLogByte(lowLevelData);
         }
    }
}