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

    //the cryptoKitties contract address
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);

    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
        //check its our zombie to feed
        require(msg.sender == zombieToOwner[_zombieId]);
        //set pointer to the zombies Array location ID
        Zombie storage myZombie = zombies[_zombieId];
         _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        // Add an if statement here to check if its a kitty
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            //change last two digits to 99
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("NoName", newDna);
    }
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        // And modify function call here:
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    } 
}

    
}