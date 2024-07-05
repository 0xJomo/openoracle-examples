const openOracleVRFFeedAbi = [
  {
    "type": "constructor",
    "inputs": [
      {
        "name": "__openOracleIdenticalAnswerTaskManager",
        "type": "address",
        "internalType": "contract OpenOracleIdenticalAnswerTaskManager"
      }
    ],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "createNewTask",
    "inputs": [
      {
        "name": "taskData",
        "type": "bytes",
        "internalType": "bytes"
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
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "createNewTask",
    "inputs": [
      {
        "name": "taskData",
        "type": "bytes",
        "internalType": "bytes"
      }
    ],
    "outputs": [],
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
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "latestRoundData",
    "inputs": [],
    "outputs": [
      {
        "name": "result",
        "type": "bytes",
        "internalType": "bytes"
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
    "name": "saveLatestData",
    "inputs": [
      {
        "name": "task",
        "type": "tuple",
        "internalType": "struct IOpenOracleIdenticalAnswerTaskManager.Task",
        "components": [
          {
            "name": "taskType",
            "type": "uint8",
            "internalType": "uint8"
          },
          {
            "name": "taskData",
            "type": "bytes",
            "internalType": "bytes"
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
        "internalType": "struct IOpenOracleIdenticalAnswerTaskManager.AggregatedTaskResponse",
        "components": [
          {
            "name": "msg",
            "type": "tuple",
            "internalType": "struct IOpenOracleIdenticalAnswerTaskManager.AggregatedMsg",
            "components": [
              {
                "name": "referenceTaskIndex",
                "type": "uint32",
                "internalType": "uint32"
              },
              {
                "name": "result",
                "type": "bytes",
                "internalType": "bytes"
              }
            ]
          },
          {
            "name": "timestamp",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "aggregatedSignature",
            "type": "tuple",
            "internalType": "struct BN254.G1Point",
            "components": [
              {
                "name": "X",
                "type": "uint256",
                "internalType": "uint256"
              },
              {
                "name": "Y",
                "type": "uint256",
                "internalType": "uint256"
              }
            ]
          },
          {
            "name": "apkG2",
            "type": "tuple",
            "internalType": "struct BN254.G2Point",
            "components": [
              {
                "name": "X",
                "type": "uint256[2]",
                "internalType": "uint256[2]"
              },
              {
                "name": "Y",
                "type": "uint256[2]",
                "internalType": "uint256[2]"
              }
            ]
          }
        ]
      },
      {
        "name": "metadata",
        "type": "tuple",
        "internalType": "struct IOpenOracleIdenticalAnswerTaskManager.TaskResponseMetadata",
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
    "name": "NewIdenticalAnswerReported",
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
        "name": "result",
        "type": "bytes",
        "indexed": false,
        "internalType": "bytes"
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

module.exports = openOracleVRFFeedAbi;