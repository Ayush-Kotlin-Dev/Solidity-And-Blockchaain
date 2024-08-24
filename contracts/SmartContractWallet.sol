// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


contract SmartContractWallet{

    address payable owner ;

    mapping (address => uint256) public allowance ;
    mapping (address => bool) private _approved ;
    constructor(){
        owner = payable(msg.sender);
    }

    function setAllowance(address _for , uint _amount) public {
        require(msg.sender == owner , "You are not the owner , aborting");
        allowance[msg.sender] -= _amount;

        if(_amount > 0 ){
            _approved[_for] = true ;
        }else {
            _approved[_for] = true ;
        }
    }

    function transform(address payable _to , uint _amount , bytes memory _payload) public  returns(bytes memory)  {
        require(msg.sender == owner , "You are not the owner , aborting");
        if ( msg.sender != owner){
            require(!_approved[msg.sender], "you are not allowed to send anything from this smart contract , aborting ");
            require(allowance[msg.sender]>= _amount , "Insufficient Allowance, aborting");

            allowance[msg.sender] -= _amount ;
        }

        (bool success , bytes memory returnData) =  _to.call{value : _amount} (_payload);
        require (success , "Aborting Something went wrong" );
        return returnData ;
     
    }

    receive() external payable { }
}