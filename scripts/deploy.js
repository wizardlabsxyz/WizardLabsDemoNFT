const { ethers } = require("hardhat");

async function main () {
  await deployer('WizardLabsDemoNFT', ['WizardLabsDemoNFT', 'WLNFT', 'ipfs://QmNzyXzsaMXfzFiRTTarBtBW9qZaDWyLS3QVyQ2XfHdbqE/']);
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