pragma solidity >=0.5.0 <0.6.0;

//import statement
import "./zombies1.sol";

//interface with cryptokitties contract
contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

// contract inheritance with `is' keyword
contract ZombieFeeding is ZombieFactory {

    //modifier to require caller to be owner of zombie
    modifier ownerOf(uint _zombieId) {
      require(msg.sender == zombieToOwner[_zombieId]);
      _;
    }

    //the cryptoKitties contract address
    //this is hard-coded, not the best idea
    //address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract;
    function setKittyContractAddress(address _address) external onlyOwner{
      kittyContract = KittyInterface(_address);
    }

    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime);
    }

    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= now);
    }

    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
        //check its our zombie to feed
        require(msg.sender == zombieToOwner[_zombieId]);
        //set pointer to the zombies Array location ID
        Zombie storage myZombie = zombies[_zombieId];
        //check we're ready to feed
        require(_isReady(myZombie));
         _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        // Add an if statement here to check if its a kitty
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            //change last two digits to 99
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("NoName", newDna);
        //trigger cooldown
        _triggerCooldown(myZombie);
    }
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        // And modify function call here:
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    } 
}

    
}