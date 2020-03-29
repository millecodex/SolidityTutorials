pragma solidity ^0.6.4;

contract HelloWorld {
    uint256 jeff = 1;
    
    //'public' allows the hello() function to be called outside the smart contract
    //'returns' needs 's' to specify the return type
    //'memory' is the location
    //'pure' means no modification to the blockchain
    
    //does NOT consume gas
    function hello() public pure returns(string memory){
        return 'hello there amigo';    
    }
    
    //does consume gas
    function getJeff() public returns(uint){
        jeff++;
        return jeff;
    }
    
    //when this function is called, ether is sent along with it (value)
    function donate() external payable returns(uint){
    }
    
    function getBalance() external view returns(uint){
        //output contract balance
        return address(this).balance;
    }
    
    //the caller's value will be sent to _recipient
    function send(address payable _recipient) public payable{
        _recipient.transfer(msg.value);
    }
    
    //fallback function: default if no other function matches the caller
    fallback() external payable {}
    
}
