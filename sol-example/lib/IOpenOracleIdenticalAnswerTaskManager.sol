// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./BN254.sol";

interface IOpenOracleIdenticalAnswerTaskManager {
    // EVENTS
    event NewIdenticalAnswerTaskCreated(uint32 indexed taskIndex, Task task);

    event TaskResponded(
        Task task,
        AggregatedTaskResponse taskResponse,
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
        bytes taskData;
        uint32 taskCreatedBlock;
        uint8 responderThreshold;
        uint96 stakeThreshold;
        address payable creator;
        uint creationFee;
    }

    struct AggregatedMsg {
        uint32 referenceTaskIndex;
        bytes result;
    }

    struct AggregatedTaskResponse {
        AggregatedMsg msg;
        uint256 timestamp;
        BN254.G1Point aggregatedSignature;
        BN254.G2Point apkG2;
    }

    // Extra information related to taskResponse, which is filled inside the contract.
    struct TaskResponseMetadata {
        uint32 taskResponsedBlock;
    }

    // FUNCTIONS
    // NOTE: this function creates new task.
    function createNewTask(
        uint8 taskType,
        bytes calldata taskData,
        uint8 responderThreshold,
        uint96 stakeThreshold
    ) external;

    function respondToTask(
        Task calldata task,
        address[] calldata operators,
        AggregatedTaskResponse calldata response
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
