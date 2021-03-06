pragma solidity ^0.5.0;

contract SimpleStorage {
    //this variable will be stored on the blockchain (storage)
    string public data;

    //type--location (temp)--name
    function set(string memory _data) public {
    //to access the storage variable (above) inside the function
    //often will see the underscore because 'data' is used twice
        data = _data;
    }
    //view is a keyword similar to pure that reads 
    //the storage of a contract (readonly)
    function get() view public returns(string memory){
        return data;
    }
}