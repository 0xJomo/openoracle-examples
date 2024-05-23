// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@eigenlayer-middleware/src/libraries/BN254.sol";

interface IOpenOracleTaskManager {
    // EVENTS
    event NewTaskCreated(uint32 indexed taskIndex, Task task, bytes taskData);

    event TaskResponded(
        Task task,
        WeightedTaskResponse taskResponse,
        TaskResponseMetadata taskResponseMetadata
    );

    event TaskCompleted(uint32 indexed taskIndex);

    event FundsWithdrawn(uint taskNum, address creator, uint amount);

    event AggregatorUpdated(address aggregator);

    // Add events for adding and removing from feed allowlist
    event AddressAddedToFeedlist(address indexed _address);
    event AddressRemovedFromFeedlist(address indexed _address);

    // STRUCTS
    struct Task {
        uint8 taskType;
        uint32 taskCreatedBlock;
        uint8 responderThreshold;
        uint96 stakeThreshold;
        address payable creator;
        uint creationFee;
    }

    // Task response is hashed and signed by operators.
    // these signatures are aggregated and sent to the contract as response.
    struct TaskResponse {
        // Can be obtained by the operator from the event NewTaskCreated.
        uint32 referenceTaskIndex;
        // This is just the response that the operator has to compute by itself.
        uint256 result;
        // This is just the response that the operator has to compute by itself.
        uint256 timestamp;
    }

    struct OperatorResponse {
        address operator;
        TaskResponse response;
        bytes signature;
    }

    struct WeightedTaskResponse {
        // Can be obtained by the operator from the event NewTaskCreated.
        uint32 referenceTaskIndex;
        // Weighted result from operator responses
        uint256 result;
        // Standard deviation for weighted result
        uint256 sd;
        // Timestamp for result
        uint256 timestamp;
    }

    // Extra information related to taskResponse, which is filled inside the contract.
    struct TaskResponseMetadata {
        uint32 taskResponsedBlock;
    }

    // FUNCTIONS
    // NOTE: this function creates new task.
    function createNewTask(
        uint8 taskType,
        uint8 responderThreshold,
        uint96 stakeThreshold
    ) external;

    // NOTE: this function creates new task.
    function createNewTaskWithData(
        uint8 taskType,
        uint8 responderThreshold,
        uint96 stakeThreshold,
        bytes calldata taskData
    ) external;

    function respondToTask(
        Task calldata task,
        OperatorResponse[] calldata responses,
        WeightedTaskResponse calldata weightedTaskResponse
    ) external;

        // Function to add an address to the feed list
    function addToFeedlist(address _address) external;

    // Function to remove an address from the feed list
    function removeFromFeed(address _address) external;
    
    /// @notice Returns the current 'taskNumber' for the middleware
    function taskNumber() external view returns (uint32);

    /// @notice Returns the TASK_RESPONSE_WINDOW_BLOCK
    function getTaskResponseWindowBlock() external view returns (uint32);
}
