const HDWalletProvider = require('@truffle/hdwallet-provider');
const mnemonic = 'stage craft wise ball clarify taxi beauty moment hard surface cry brisk';
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    dashboard: {},
    loc_development_development: {
      network_id: "*",
      port: 8545,
      host: "127.0.0.1"
    },
    kovan: {
      provider: () => new HDWalletProvider(mnemonic, 'https://kovan.infura.io/v3/9bbf175a09e54c80938a061522edaad2'),
      network_id: 42, // Kovan's network ID
      gas: 5500000,
    },
    goerli: {
      provider: () => new HDWalletProvider(mnemonic, 'https://goerli.infura.io/v3/9bbf175a09e54c80938a061522edaad2'),
      network_id: 5, // Goerli's network ID
      gas: 5500000,
    },
  },
  compilers: {
    solc: {
      version: "0.8.13"
    }
  },
  db: {
    enabled: false,
    host: "127.0.0.1"
  }
};

// require("@nomiclabs/hardhat-waffle");
// const projectId = '3a8353efa3b348f8a791fd6140f0e67b'
// const fs = require('fs')
// const keyData = fs.readFileSync('./p-key.txt', {
//   encoding:'utf8', flag:'r'
// })

// module.exports = {
//   defaultNetwork: 'hardhat',
//   networks:{
//     hardhat:{
//       chainId: 1337 // config standard 
//     },
//     mumbai:{
//       url:`https://polygon-mumbai.infura.io/v3/3a8353efa3b348f8a791fd6140f0e67b`,
//       accounts:['0xf136408CcE69044d8256F2Bc1CB6192C5130e8EC']
//     },
//     mainnet: {
//       url:`https://mainnet.infura.io/v3/3a8353efa3b348f8a791fd6140f0e67b`,
//       accounts:['0xf136408CcE69044d8256F2Bc1CB6192C5130e8EC']
//     }
//   },
//   solidity: {
//     version: "0.8.4",
//     settings: {
//       optimizer: {
//         enabled: true,
//         runs: 200
//       }
//     }
//   }
// };