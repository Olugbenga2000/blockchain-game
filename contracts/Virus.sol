// "SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.6.12;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract Virus is ERC721 {
  
  address public owner;
  struct CryptoVirus{
    string name;
    uint level;
    uint wins;
    uint losses;
    uint cooldown;
  }

  CryptoVirus[] public viruses;
  mapping(uint => address) public virusToOwner;
  mapping(address => uint) public ownerVirusCount;

  constructor() public ERC721("CryptoVirus", "Virus") {
    owner = msg.sender;
  }

  modifier virusExists(uint _tokenId){
    require(virusToOwner[_tokenId] != address(0), "this tokenId does not exist");
    _;
  }

  modifier onlyOwnerOf(uint _tokenId){
    require(msg.sender == virusToOwner[_tokenId], "msg.sender is not the owner");
    _;
  }

  modifier onlyOwner(){
    require(msg.sender == owner, "only the owner can call the function");
    _;
  }
}
