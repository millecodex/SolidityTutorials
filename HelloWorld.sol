pragma solidity ^0.5.0;

contract HelloWorld{
    //'public' allows the hello() function to be called outside the smart contract
    //'returns' needs 's' to specify the return type
    //'memory' is the location
    //'pure' means no modification to the blockchain
    function hello() pure public returns(string memory){
        return 'Helllo World';
    }
}