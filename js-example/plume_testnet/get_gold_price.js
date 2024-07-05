const { ethers } = require('ethers');

const contractAddress = '0x9B1d74AAC508Bf95C8A0e08458093bca8E9D3cB3';

const rpcEndpoint = 'https://testnet-rpc.plumenetwork.xyz/http'
const contractABI = require('../../contracts/abi/OpenOracleCommonDataFeed.js');

// Example: Get latest data from a price feed
async function getLatestData() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const contract = new ethers.Contract(contractAddress, contractABI, provider);

  const taskType = 1 // Gold
  try {
    // Call the function
    const result = await contract.latestRoundData(taskType);

    console.log("Function result:", result);
    if(taskType < 15){
      actualData = parseInt(result[0]) / 100.0
    }else{
      actualData = parseHexString(result[0])
    }
    console.log('result:', actualData);
  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}

getLatestData();
