pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol"
import "./safemath.sol"

contract ZombieFactory is Ownable{

    //declare that safemath is being used
    //'using' means safemath is a 'library'
    using SafeMath for uint256;

    // declare our event here
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;

    //mappings are key-value stores
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        // and fire it here
        uint id = zombies.push(Zombie(
            _name, 
            _dna,
            1,
            uint32(now + cooldownTime),
            0,
            0)  )-1;
        //msg.sender refers to the caller's address
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id,_name,_dna);
    } 

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        //`require' keyword is a test that throws an error if it fails
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
