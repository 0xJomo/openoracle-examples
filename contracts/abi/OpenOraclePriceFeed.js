const openOraclePriceFeedAbi = [
  {
    "type": "constructor",
    "inputs": [
      {
        "name": "__openOracleTaskManager",
        "type": "address",
        "internalType": "contract OpenOracleTaskManager"
      },
      {
        "name": "__taskType",
        "type": "uint8",
        "internalType": "uint8"
      },
      {
        "name": "__responderThreshold",
        "type": "uint8",
        "internalType": "uint8"
      },
      {
        "name": "__stakeThreshold",
        "type": "uint96",
        "internalType": "uint96"
      }
    ],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "initialize",
    "inputs": [
      {
        "name": "initialOwner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "latestRoundData",
    "inputs": [],
    "outputs": [
      {
        "name": "price",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "sd",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "timestamp",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "startBlock",
        "type": "uint32",
        "internalType": "uint32"
      },
      {
        "name": "endBlock",
        "type": "uint32",
        "internalType": "uint32"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "owner",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "address",
        "internalType": "address"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "renounceOwnership",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "requestNewReport",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "saveLatestData",
    "inputs": [
      {
        "name": "task",
        "type": "tuple",
        "internalType": "struct IOpenOracleTaskManager.Task",
        "components": [
          {
            "name": "taskType",
            "type": "uint8",
            "internalType": "uint8"
          },
          {
            "name": "taskCreatedBlock",
            "type": "uint32",
            "internalType": "uint32"
          },
          {
            "name": "responderThreshold",
            "type": "uint8",
            "internalType": "uint8"
          },
          {
            "name": "stakeThreshold",
            "type": "uint96",
            "internalType": "uint96"
          },
          {
            "name": "creator",
            "type": "address",
            "internalType": "address payable"
          },
          {
            "name": "creationFee",
            "type": "uint256",
            "internalType": "uint256"
          }
        ]
      },
      {
        "name": "response",
        "type": "tuple",
        "internalType": "struct IOpenOracleTaskManager.WeightedTaskResponse",
        "components": [
          {
            "name": "referenceTaskIndex",
            "type": "uint32",
            "internalType": "uint32"
          },
          {
            "name": "result",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "sd",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timestamp",
            "type": "uint256",
            "internalType": "uint256"
          }
        ]
      },
      {
        "name": "metadata",
        "type": "tuple",
        "internalType": "struct IOpenOracleTaskManager.TaskResponseMetadata",
        "components": [
          {
            "name": "taskResponsedBlock",
            "type": "uint32",
            "internalType": "uint32"
          }
        ]
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "setThresholds",
    "inputs": [
      {
        "name": "responderThreshold",
        "type": "uint8",
        "internalType": "uint8"
      },
      {
        "name": "stakeThreshold",
        "type": "uint96",
        "internalType": "uint96"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "transferOwnership",
    "inputs": [
      {
        "name": "newOwner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "event",
    "name": "Initialized",
    "inputs": [
      {
        "name": "version",
        "type": "uint8",
        "indexed": false,
        "internalType": "uint8"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "NewPriceReported",
    "inputs": [
      {
        "name": "taskType",
        "type": "uint8",
        "indexed": true,
        "internalType": "uint8"
      },
      {
        "name": "referenceTaskIndex",
        "type": "uint32",
        "indexed": false,
        "internalType": "uint32"
      },
      {
        "name": "price",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "sd",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "timestamp",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "createdBlock",
        "type": "uint32",
        "indexed": false,
        "internalType": "uint32"
      },
      {
        "name": "respondedBlock",
        "type": "uint32",
        "indexed": false,
        "internalType": "uint32"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "OwnershipTransferred",
    "inputs": [
      {
        "name": "previousOwner",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "newOwner",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      }
    ],
    "anonymous": false
  }
]

module.exports = openOraclePriceFeedAbi;