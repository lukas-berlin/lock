const Lock = artifacts.require("./Lock.sol");

module.exports = function(deployer) {
  deployer.deploy(Lock);
};
