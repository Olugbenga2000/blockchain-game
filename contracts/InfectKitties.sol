// "SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.6.12;
import "./VirusInfect.sol";
interface CryptoKittiesInterface{
    function getKitty(uint256 _id)external view returns(
        bool isGestating,
        bool isReady,
        uint256 coolDownIndex,
        uint256 nextActionAt,
        uint256 stringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
     );
}
contract InfectKitties is VirusInfect{
    CryptoKittiesInterface public cryptokitties;

    function setCryptoKittiesAddress(address _address) external onlyOwner{
        cryptokitties = CryptoKittiesInterface(_address);
    }

    function infectKitty(uint _virusId, uint _kittyId)external onlyOwnerOf(_virusId){
        uint kittyWinProbability = _kittyId % 10;
        CryptoVirus storage virus = viruses[_virusId];
        uint chanceToWin = generateNum(10);

        if (chanceToWin > kittyWinProbability){
            virus.level += 1;
            _mintVirus("KittyVirus", _kittyId, msg.sender);
        }

    }

}