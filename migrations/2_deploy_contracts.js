const FVP_Token = artifacts.require("FVP_Token");

module.exports = function(deployer) {
  deployer.deploy(FVP_Token);
};
