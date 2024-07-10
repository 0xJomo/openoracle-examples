const { ethers } = require('ethers');

const contractAddress = '0x9B1d74AAC508Bf95C8A0e08458093bca8E9D3cB3';
const ownerPrivateKey = 'd4abb0b9f0481d61dacd947b8d8a7238928ee1db211e2cd2417d8e819433504f'

const rpcEndpoint = 'https://testnet-rpc.plumenetwork.xyz/http'
const contractABI = require('../../contracts/abi/OpenOracleCommonDataFeed.js');

// Example: Create a New Task
async function requestNewData() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const wallet = new ethers.Wallet(ownerPrivateKey, provider);
  const contract = new ethers.Contract(contractAddress, contractABI, wallet);

  try {
    const taskType = 17 // Powerball Most Recent Result

    // Call the function
    await contract.requestNewReport(taskType);

    console.log('request submitted');
  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}


console.log('Creating task....');
requestNewData()
