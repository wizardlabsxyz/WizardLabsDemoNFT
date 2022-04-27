const { ethers } = require("hardhat");

async function main () {
  await deployer('RevealableNFT', ['RevealableNFT', 'RVB', 'ipfs://QmRhQpnVt8YAS96WtvcAJ1VG6vEuUAUXMT7iKMkCwptX48/']);
}

async function deployer(name, args=null) {
  const contractFactory = await ethers.getContractFactory(name);
  console.log('Deploying... ' + name);
  const contract = await contractFactory.deploy(...args);
  await contract.deployed();
  console.log('deployed to:', contract.address);
  return contract.address;
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });