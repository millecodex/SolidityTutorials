contract Token {
    uint256 public totalSupply;
    string public name = "Jeff Token";
    string public symbol = "JFK";
    
    //required to emit the event and it can be subscribed to (listener)
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
        );
    
    //mappings here (uint) default to zero
    mapping(address => uint256) public balanceOf;
    
    //constructor is only executed once upon deployment
    //can only be public or internal
    constructor(uint256 _initialSupply) public {
        //other initialization logic
        
        //msg. is a global variable
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
        //allocate the initial supply
    }
    
    function transfer(address _to, uint256 _value) public returns(bool success) {
        //require same as if statement
        require(balanceOf[msg.sender]>=_value);    
        //transfer the balance
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] +- _value;
        //transfer event
        Transfer(msg.sender,_to,_value);
        return true;
    }
}