// https://eth-mainnet.g.alchemy.com/v2/yT9MIqu4QArfmDR2RQ-beYob49Xc58Hu
//require('@nomiclabs/hardhat-waffle');

//module.exports = {
//  solidity: '0.8.0',
//  networks: {
//    sepolia:{
//      url:'https://eth-sepolia.g.alchemy.com/v2/yT9MIqu4QArfmDR2RQ-beYob49Xc58Hu',
//      accounts: ['0ab077dd0cf7be9407d6d4e090dc7db6e5258109b138c4aa7c9333ff6bd392a4']
//    }
//  }
//}

require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: "0.8.0",
  networks: {
    electroneum_testnet: {
      url: "https://rpc.ankr.com/electroneum_testnet",
      chainId: 5201420,
      accounts: ['0ab077dd0cf7be9407d6d4e090dc7db6e5258109b138c4aa7c9333ff6bd392a4'], // 你的私鑰
    },
  },
};

