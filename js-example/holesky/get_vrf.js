const { ethers } = require('ethers');

const rpcEndpoint = 'https://ethereum-holesky-rpc.publicnode.com'
const contractAddress = '0x298e55eDe8AE5fD1Ec68DFce867D6D77b4EEA8c5';

// The ABI for your contract (simplified for this example)
const contractABI = require('../../contracts/abi/OpenOracleVRFFeed.js');

async function getLatestVrfData() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const contract = new ethers.Contract(contractAddress, contractABI, provider);

  try {
    // Call the function
    const result = await contract.latestRoundData();

    console.log("Function result:", result);
    console.log('result number:', BigInt(result[0]) % BigInt(2**32));
  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}


console.log('Getting data....');
getLatestVrfData();
