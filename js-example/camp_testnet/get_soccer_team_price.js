const { ethers } = require('ethers');
const { parseHexString } = require('../utils.js')

const contractAddress = '0xabc6C2f445d253Db6C1f62602E911c9E8cf90880';

const rpcEndpoint = 'https://rpc.camp-network-testnet.gelato.digital'
const contractABI = require('../../contracts/abi/OpenOracleCommonDataFeed.js');

// Example: Get latest data from a price feed
async function getLatestData() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const contract = new ethers.Contract(contractAddress, contractABI, provider);

  const taskType = 14 // Soccer team
  try {
    // Call the function
    const result = await contract.latestRoundData(taskType);

    console.log("Function result:", result);
    if(taskType < 15){
      actualData = parseInt(result[0])
    }else{
      actualData = parseHexString(result[0])
    }
    console.log('result:', actualData);
  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}

getLatestData();
