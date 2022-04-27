async function main () {
    await hre.run("verify:verify", {
        address: '0x2e0162a295A22C63B71c13aa09E21E1375781818',
        constructorArguments: [
          'RevealableNFT',
          'RVB',
          'ipfs://QmRhQpnVt8YAS96WtvcAJ1VG6vEuUAUXMT7iKMkCwptX48/'
        ],
      });
}


main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });