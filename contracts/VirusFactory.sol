// "SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.6.12;
import "./Virus.sol";
contract VirusFactory is Virus {

    function mintVirus(string memory _name , uint _level, address _newOwner) public {
        require(_level >= 0 && _level < 10,"The level parameter is not valid");
        require (ownerVirusCount[_newOwner] < 6, "user already has 6 tokens");
        uint level = _level;
        if (_level == 0){
           level = generateNum(10);
        }else{
            _mintVirus(_name, level ,_newOwner);
        }
    }

    function _mintVirus(string memory _name , uint _level, address _newOwner) internal {
        viruses.push(CryptoVirus({
            name : _name,
            level : _level,
            wins : 0,
            losses : 0,
            cooldown : uint32(now)
        }));
        uint id = viruses.length - 1;
        virusToOwner[id] = _newOwner;
        ownerVirusCount[_newOwner]++;
        _mint(_newOwner, id);
}
    function generateNum(uint _mod) internal view returns (uint){
        uint randomNumber = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender )));
        return randomNumber % _mod;

    }

    function safeTransferFrom(address _from, address _to, uint _virusId) 
    public override onlyOwnerOf(_virusId) virusExists(_virusId){
        ownerVirusCount[_from] -= 1;
        ownerVirusCount[_to] += 1;
        virusToOwner[_virusId] = _to;
        super.safeTransferFrom(_from, _to, _virusId);
    }
}