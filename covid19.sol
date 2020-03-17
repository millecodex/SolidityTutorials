pragma solidity ^0.6.4;

contract Covid {
    //global variables
    uint public totalInfected = 0;
    uint public totalDeceased = 0;
    uint public totalRecovered = 0;
    
    //mappings here (uint) default to zero
    mapping(uint => string) doctors;
    mapping(uint => string) patients;
    
    //don't want patients entering data (might be dead)
    function test() public returns (bool results) {
        //for now assume random assignment of positive results
        
        totalInfected ++;
        return true;
    }
    
    function deceased() private {
        totalDeceased ++;
    }
    
    function recovered() private {
        totalRecovered ++;
    }
    
    //veiw is read-only,  don't modify blockchain
    //this is color-coded in remix: BLUE
    function getInfected() external view returns(uint){
        return totalInfected;
    }
    
}
