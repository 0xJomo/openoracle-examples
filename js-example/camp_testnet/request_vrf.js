const { ethers } = require('ethers');

const rpcEndpoint = 'https://rpc.camp-network-testnet.gelato.digital'
const contractAddress = '0x2ea329336246e89BFF5bB87E6dCc74EBe9d2b039';

// The ABI for your contract (simplified for this example)
const contractABI = require('../../contracts/abi/OpenOracleVRFFeed.js');

// The account address that will interact with the contract
// const ownerPrivateKey = 'ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80'
const ownerPrivateKey = 'd4abb0b9f0481d61dacd947b8d8a7238928ee1db211e2cd2417d8e819433504f'

// Example: Create a New Task
async function createNewTask() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const wallet = new ethers.Wallet(ownerPrivateKey, provider);
  const contract = new ethers.Contract(contractAddress, contractABI, wallet);

  try {
    const vrfSeed = 123456789
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
