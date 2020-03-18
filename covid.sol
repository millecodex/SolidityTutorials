pragma solidity ^0.6.4;

contract Covid {
    //global variables
    uint public totalInfected = 0;
    uint public totalDeceased = 0;
    uint public totalRecovered = 0;
    uint public percentageInfected = 50;
    uint public testedNegative=0;
    
    //mappings (key => value), e.g. (address=>uint) for person's balance
    //mappings here (uint) default to zero
    //doctor might want to store an array of patients... (address=>patients[])
    //mapping(address => address[]) doctorsPatientList;
    //update by
    //doctorsPatientList[msg.sender].push(patientAddress);
    //access by
    //doctorsPatientList[msg.sender][0];
    
    //these are storage arrays (BC storage) NOT memory (volatile) arrays
    address[] doctors;
    address[] patients;
    
    //the person calling this must be a doctor
    //doctors[id] = msg.sender;
    
    function addDoctor(address _address) internal {
        doctors.push(_address);
    }
    
    //don't want patients entering data (might be dead)
    function test(address _patient) external {
        //require doctor to be in doctors list
        doctors.push(_patient);
        patients.push(_patient);
        
        //test new patient
        if(isPositive()) {
            totalInfected ++;
            //change patient status to infected
        } else {
            testedNegative ++;
        }
    }
    
    //keccak256 is an alias of SHA3 used by ethereum and solidity
    //block.timestamp and difficulty are built-in functions
    //this random function is NOT SECURE!! (but still fun)
    function isPositive() private view returns (bool) {
        uint seed = uint256(keccak256(abi.encodePacked(block.timestamp + block.difficulty)));
        uint rand = seed % 100;
        if(rand > percentageInfected) {
            return true;
        }
        return false;
    }
    /*
    function testRand() public view returns(uint){
        uint seed = uint256(keccak256(abi.encodePacked(block.timestamp + block.difficulty)));
        uint rand = seed % 100;
        return rand;
    }*/
    
    function viewDoctors() public view returns(address){
        //string memory result = 'List:';
        address _result;
        for(uint i=0; i< doctors.length; i++) {
            _result = doctors[i];       
        }
        return _result;
    }
    
    function deceased(address _patient) external {
        totalDeceased ++;
        
    }
    
    function recovered(address _patient) private {
        totalRecovered ++;
    }
    
    function currentInfected() public view returns(uint){
        return totalInfected - totalRecovered - totalDeceased;
    }
    
    //veiw is read-only,  don't modify blockchain
    //this is color-coded in remix: BLUE
    //note this is the same as the global variable getter function
    function getInfected() external view returns(uint){
        return totalInfected;
    }
    
}