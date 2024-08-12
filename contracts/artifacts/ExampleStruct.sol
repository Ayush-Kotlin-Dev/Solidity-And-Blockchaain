
// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


contract Wallet {

    PaymentRecieved public payment ;

    function payContract () public payable {
        payment = new PaymentRecieved(msg.sender,msg.value);
    }
}

contract PaymentRecieved {

    address public from ;
    uint public amount ;

    constructor(address _from , uint _amount) {
        from = _from ;
        amount = _amount ;
    }
}

contract Wallet2 {

    struct PaymentRecievedStruct{
        address from;
        uint amount;
    }

    PaymentRecievedStruct public payment ;

    function payContract() public payable {
        payment = PaymentRecievedStruct(msg.sender,msg.value);
    }
}

contract ExamplePerson {
    // Define a struct to hold a person's information
    struct Person {
        string name;
        uint age;
        address wallet;
    }

    // Declare a variable of type Person
    Person public person;

    // Function to set the person's details
    function setPerson(string calldata _name, uint _age, address _wallet) external {
        person.name = _name;
        person.age = _age;
        person.wallet = _wallet;
    }

    // Function to get the person's details
    function getPerson() external view returns (string memory, uint, address) {
        return (person.name, person.age, person.wallet);
    }
}
