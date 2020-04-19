const ChinToken = artifacts.require("./ChinToken.sol"); //extraction

module.exports = function(deployer) {
  const _name ="Chin Token";
  const _symbol = "CHIN";
  const _decimals = 18;

  deployer.deploy(ChinToken, _name, _symbol, _decimals); 
};
