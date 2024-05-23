const { ethers } = require('ethers');

const contractAddress = '0x19AEA3fb493609dded4DE500cD1f09E7b152b78E'; // Soccer team score
const ownerPrivateKey = '<Insert your own>'

const rpcEndpoint = 'https://testnet-rpc.plumenetwork.xyz/http'
const contractABI = require('../contracts/abi/OpenOraclePriceFeed.js');

// Example: Create a New Task
async function requestNewData() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const wallet = new ethers.Wallet(ownerPrivateKey, provider);
  const contract = new ethers.Contract(contractAddress, contractABI, wallet);

  try {
    // Call the function
    const taskData = ethers.utils.solidityPack(["uint32","uint64","uint32"],[39,2021,33]) // Premier league, season 2021, Manchester Utd
    await contract.requestNewReportWithData(taskData);

    console.log('request submitted');
  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}


console.log('Creating task....');
requestNewData()
