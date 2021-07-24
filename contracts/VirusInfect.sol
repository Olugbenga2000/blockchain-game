// "SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.6.12;
import "./VirusFactory.sol";
contract VirusInfect is VirusFactory{

  uint coolDownPeriod = 1 minutes;
  uint requiredToWin = 6;
  event Winner(uint virusId);

  function infect(uint _virusId, uint _enemyId) external onlyOwnerOf(_virusId){
    require(_isReady(_virusId), "virus isnt ready");
    CryptoVirus storage myVirus = viruses[_virusId];
    CryptoVirus storage enemyVirus = viruses[_enemyId];
    uint chanceToWin = generateNum(10);

    if (chanceToWin > requiredToWin){
      _calculateWinsAndLosses(myVirus,enemyVirus);
      emit Winner(_virusId);
    } else {
      _calculateWinsAndLosses(enemyVirus, myVirus);
      emit Winner(_enemyId);
    }
    _activateCoolDown(myVirus);
  }

  function _isReady(uint virusId) internal view returns(bool){
    return viruses[virusId].cooldown <= now;
  }

  function _calculateWinsAndLosses(CryptoVirus storage _winner, CryptoVirus storage _losser) internal {
    _winner.wins += 1;
    _winner.level += 1;
    _losser.losses += 1;
  }

  function _activateCoolDown(CryptoVirus storage _virus) internal {
    _virus.cooldown = uint32(now + coolDownPeriod);
  }
}

