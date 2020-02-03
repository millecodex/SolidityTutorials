pragma solidity >=0.5.0 <0.6.0;

import "./zombieattack.sol";
import "./erc721.sol";
import "./safemath.sol";

//multiple inheritances with a comma
contract ZombieOwnership is ZombieAttack, ERC721 {
using SafeMath for uint256;
  // 1. Define mapping here
  mapping (uint => address) zombieApprovals;
  

  function balanceOf(address _owner) external view returns (uint256) {
      //access the mappings that are arrays -> square brackets
    return ownerZombieCount[_owner];
  }

//this name is defined in the ERC721 standard, so we can't reuse it
  function ownerOf(uint256 _tokenId) external view returns (address) {
      //access the mappings that are arrays -> square brackets
    return zombieToOwner[_tokenId];
  }

function _transfer(address _from, address _to, uint256 _tokenId) private {
    // Replace with SafeMath's `add` and 'sub'
    ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
    ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].sub(1);
    zombieToOwner[_tokenId] = _to;
    //we created our own private _transfer function, so now fire the standard
    //Transfer event
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require(zombieToOwner[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender);
    // Call _transfer
    _transfer(_from, _to, _tokenId);
  }

    // Add function modifier here
  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
    zombieApprovals[_tokenId] = _approved;
     //Fire the Approval event here
    emit Approval(msg.sender, _approved, _tokenId);
  }

}
