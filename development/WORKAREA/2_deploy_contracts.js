const TFF_Token = artifacts.require("TFF_Token");

module.exports = function(deployer) {
  deployer.deploy(TFF_Token);
};
