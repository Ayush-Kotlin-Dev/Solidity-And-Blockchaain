// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Consumer{

    function getBalance() public view returns (uint){
        return address(this).balance ;
    }

    function deposit() public payable {}
}
contract SmartContractWallet{

    address payable public owner ;

    mapping (address => uint256) public allowance ;
    mapping (address => bool) private _approved ;

    mapping (address=>bool) public guardians ;
    address payable nextOwner ;
    mapping (address=> mapping (address => bool)) nextOwnerGuardianVoteBool ;

    uint guardianResetCount ;
    uint public constant confirmationsFromguardiansForReset = 3 ;

    constructor(){
        owner = payable(msg.sender);
    }

    function setGuardian(address _guardian , bool _isGuardian)public  {
        require(msg.sender==owner , "NotOwner");
        guardians[_guardian] = _isGuardian;
    }
    function proposeNewOwner(address payable _newOwner) public {
        require(guardians[msg.sender], "NotGuardian of the wallet , aborting");
        require(nextOwnerGuardianVoteBool[_newOwner][msg.sender] == false ,"Vote has already been cast");

        if(_newOwner != nextOwner){
            nextOwner = _newOwner;
            guardianResetCount = 0;
        }
        guardianResetCount ++ ;

        if(guardianResetCount >= confirmationsFromguardiansForReset){
            owner = nextOwner;
            nextOwner = payable(address(0));
        }

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