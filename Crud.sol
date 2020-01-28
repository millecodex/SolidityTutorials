pragma solidity ^0.5.0;

contract Crud{
    // struct is a defined data type (usually UpperCase)
    struct User {
        uint id;
        string name;
    }
    User[] public users;
    //avoid any users with id=0
    uint public nextId = 1;
    
    function create(string memory name) public {
        users.push(User(nextId, name));
        nextId++;
    }
    // in solidity a function can return multiple items `uint, string'
    // this cannot be done in javascript
    function read(uint id) view public returns(uint, string memory) {
        uint i = find(id);
        return(users[i].id, users[i].name);
    }
    
    function update(uint id, string memory name) public {
        uint i = find(id);
        users[i].name = name;
    }
    
    function destroy(uint id) public {
        uint i = find(id);
        delete users[i];
    }
    // iterate through the user array
    // internal keyword is only accessible within the SC
    function find(uint id) view internal returns(uint) {
        for(uint i=0; i<users.length; i++) {
            if(users[i].id == id) {
                return i;
            }
        }//else
        //revert keyword (error) execution stops, tx state
        //change is cancelled, but gas is still consumed
        revert('User does not exist');
    }
}