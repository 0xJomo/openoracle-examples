const { ethers } = require('ethers');

const contractAddress = '0xc4d060D973b4DC80227513d96184dCE866eEb2Cf'; // Gold
const ownerPrivateKey = '<Insert your own>'

const rpcEndpoint = 'https://ethereum-holesky-rpc.publicnode.com'
const contractABI = require('../contracts/abi/OpenOraclePriceFeed.js');

// Example: Create a New Task
async function requestNewData() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const wallet = new ethers.Wallet(ownerPrivateKey, provider);
  const contract = new ethers.Contract(contractAddress, contractABI, wallet);

  try {
    // Call the function
    await contract.requestNewReport();

    console.log('request submitted');
  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}


console.log('Creating task....');
requestNewData()
