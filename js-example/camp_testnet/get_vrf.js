const { ethers } = require('ethers');

const rpcEndpoint = 'https://rpc.camp-network-testnet.gelato.digital'
const contractAddress = '0x2ea329336246e89BFF5bB87E6dCc74EBe9d2b039';

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
