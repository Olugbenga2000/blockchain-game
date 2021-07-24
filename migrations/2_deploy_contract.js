const VirusFactory = artifacts.require("VirusFactory");

module.exports = function(deployer) {
  deployer.deploy(VirusFactory);
};
