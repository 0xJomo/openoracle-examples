const { ethers } = require('ethers');

const contractAddress = '0xB233eE56e57f7eB1B1144b28214Abc74b273d3D5';
const ownerPrivateKey = '0x14a50447fdefa33d732510cf4008a3282900c3be64c145ff42f633714db8f394'

const rpcEndpoint = 'https://ethereum-holesky-rpc.publicnode.com'
const contractABI = require('../../contracts/abi/OpenOracleCommonDataFeed.js');

// Example: Create a New Task
async function requestNewData() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const wallet = new ethers.Wallet(ownerPrivateKey, provider);
  const contract = new ethers.Contract(contractAddress, contractABI, wallet);

  try {
    const taskType = 14 // Soccer team score

    // Call the function
    const taskData = ethers.utils.solidityPack(["uint32","uint64","uint32"],[39,2022,33]) // Premier league, season 2022, Manchester Utd
    await contract.requestNewReportWithData(taskType, taskData);

    console.log('request submitted');
  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}


console.log('Creating task....');
requestNewData()
