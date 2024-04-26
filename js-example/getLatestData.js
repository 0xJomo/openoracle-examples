const { ethers } = require('ethers');

const contractAddress = '0xc4d060D973b4DC80227513d96184dCE866eEb2Cf'; // Gold

const rpcEndpoint = 'https://ethereum-holesky-rpc.publicnode.com'
const contractABI = require('../contracts/abi/OpenOraclePriceFeed.js');

// Example: Get latest data from a price feed
async function getLatestData() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const contract = new ethers.Contract(contractAddress, contractABI, provider);

  try {
    // Call the function
    const result = await contract.latestRoundData();

    console.log("Function result:", result);
    console.log('Data result:', parseInt(result[0]) / 100.00);
  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}

getLatestData();
