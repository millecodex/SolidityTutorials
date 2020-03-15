// comments like java or JS
/*  larger
    proper
    comments
    here
    */
pragma solidity ^0.5.11; //larger than 0.5.11, up to 0.6

//this is where the contract starts
//name by convention same as filename
contract NewContract {
    //1. fixed size types
    bool isReady;
    uint a; //integers > 0; default is 256
    address recipient;
    bytes32 data; //arbitrary binary data like strings
    
    //2. variable-size types
    string name; 
    bytes _data; //a generalization of the bytes32 type
    uint[] amounts; //arrays are static types, can't mix
    mapping(uint => string) users; // similar to JS objects
    
    //3. user-defined data
    struct User {
        uint id;
        string name;
        uint[] friendIDs;
    }
    enum Color {
        RED,
        GREEN
    }//can use Color.RED, or Color.GREEN

    //veiw is read-only, don't modify blockchain
    //this is color-coded in remix: BLUE
    function getValue() external view returns(uint){
        return value;
    }
    //without view keyword, this function can modify BC
    //color-coded: ORANGE
    function setValue(uint _value) external {
        value = _value;
    }

    /*function visibility
    'private' is the most strict; only called within SC
    'internal' still within the SC, but also can be inherited
    'external' can only be called from outside SC (no underscore)
    'public' can be called anywhere

variables can be private, internal, and public

    */

    function foo() external {
        //test that a certain amount of ether was sent
        //in solidity there is no such thing as a strict comparison '===' like from javascript; only two '=='
        if(msg.sender == 100 && block.timestamp > 123) {
            //if control
        } else {
            //else control
        }
        
        for(uint i = 0; i<100; i++) {
            //stuff here
        }
        bool isOk = true;
        while(isOk) {
            //run some stuff
            if () { 
                isOk = false;
                //break statement
                break;
                continue;
            }
        }
    }
    //arrays must match type
    //1. storage arrays
    //2. memory arrays disappear after function call
    //3. array arguments and return arrays from function
    
    //1. 
    uint[] myArray; 
    //this array is dynamically sized
    //CRUD: create, read, update, delete
    //cannot manipulate arrays outside of functions
    function foo() external {
        //write
        myArray.push(2);
        myArray.push(3);
        //read
        myArray[0];
        //update
        myArray[0]=7;
        //delete only resets the value to the default type
        delete myArray[0];
        
        //iterate through arrays
        for(uint i=0; i< myArray.length; i++) {
            myArray[i];       
        }
    }
    //2. memory arrays only declared inside function
    function bar() external {
        uint[] memory tempArray = new uint[](10);
        tempArray[1]=51;
        tempArray[2];
        tempArray[3]=33;
        delete tempArray[4];
    }
    //3. arrays in functions
    //calldata is the memory keywork (externals)
    function foobar(uint[] calldata myArg) external {
    }
    function foobar(uint[] memory myArg) internal returns(uint[] memory) {
    }
}

