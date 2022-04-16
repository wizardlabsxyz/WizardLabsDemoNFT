require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

// Go to https://www.alchemyapi.io, sign up, create
// a new App in its dashboard, and replace "KEY" with its key

// Ropsten WizardLabsDemoNFT Key
const RINKEBY_ALCHEMY_API_KEY = "Bk4gFDQ7onQkwQ8EhCQh7FRZIFySm0Vv";

// Replace this private key with your Ropsten account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Be aware of NEVER putting real Ether into testing accounts

// WizardLabsTestDeveloper
// 0x9DAfB9860FcD9A1E1dc00b4660E65cEcDd88E4bB
const RINKEBY_PRIVATE_KEY = "0d70af53fcd791de9664a02a367aeebaa6052f341e5939db5a315b5d3b02d2e6";

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: `https://eth-rinkeby.alchemyapi.io/v2/${RINKEBY_ALCHEMY_API_KEY}`,
      accounts: [`${RINKEBY_PRIVATE_KEY}`]
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "HHH6GJPM28725AMYYHR4FMYNTB9HXEW1MW"
  }
};