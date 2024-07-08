const { ethers } = require('ethers');

const rpcEndpoint = 'https://ethereum-holesky-rpc.publicnode.com'
const contractAddress = '0x298e55eDe8AE5fD1Ec68DFce867D6D77b4EEA8c5';

// The ABI for your contract (simplified for this example)
const contractABI = require('../../contracts/abi/OpenOracleVRFFeed.js');

// The account address that will interact with the contract
// const ownerPrivateKey = 'ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80'
const ownerPrivateKey = '57025ef2fe1f160216b3207011d6c688395461e8bd81bbb9d58c5b990581795f'

// Example: Create a New Task
async function createNewTask() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const wallet = new ethers.Wallet(ownerPrivateKey, provider);
  const contract = new ethers.Contract(contractAddress, contractABI, wallet);

  try {
    const vrfSeed = 12345678
    // Call the function
    const taskData = ethers.utils.solidityPack(["uint64"],[vrfSeed])
    await contract["createNewTask(bytes,uint8,uint96)"](taskData, 0, 0);

    console.log('request submitted');

  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}


console.log('Creating task....');
createNewTask();
