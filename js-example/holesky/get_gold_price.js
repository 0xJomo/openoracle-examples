const { ethers } = require('ethers');
const { parseHexString } = require('../utils.js')

const contractAddress = '0xB233eE56e57f7eB1B1144b28214Abc74b273d3D5';

const rpcEndpoint = 'https://ethereum-holesky-rpc.publicnode.com'
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
