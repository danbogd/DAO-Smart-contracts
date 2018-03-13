


var Loan = artifacts.require("Loan");
var Debts = artifacts.require("Debts");
module.exports = function(deployer) {
  
  deployer.deploy(Loan);
  deployer.deploy(Debts);
};



