pragma solidity ^0.5.0;

contract AdvancedStorage {
    //an array of integers
    uint[] public ids;
    
    function add(uint id) public { //no view or pure because this function
    //will modify the storage on the blockchain
        ids.push(id);
    }
    
    //this get function isn't strickly required because solidity
    //creates a getter function when the array is instantiated
    function get(uint position) view public returns(uint) {
        return ids[position];
    }
    // complex type like array requires specifying the memory location
    function getAll() view public returns(uint[] memory) {
        return ids;
    }
    
    function length() view public returns(uint) {
        return ids.length;
    }
}   
