// Lấy contract đặt vào blockchain
const Token = artifacts.require("Token");
const EthSwap = artifacts.require("EthSwap");

module.exports = async function(deployer) {
    //deploy contract token
    await deployer.deploy(Token);
    const token = await Token.deployed()
    //deploy contract sàn
    await deployer.deploy(EthSwap);
    const ethSwap = await EthSwap.deployed()
    
    await token.transfer(ethSwap.address,'1000000000000000000000000') // chuyển token lên EthSwap
};
