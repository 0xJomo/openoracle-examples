const { ethers } = require('ethers');

const rpcEndpoint = 'https://testnet-rpc.plumenetwork.xyz/http'
const contractAddress = '0xaDeb194Edf918C76a32a7Eb3E5cCcDed08F786B1';

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
