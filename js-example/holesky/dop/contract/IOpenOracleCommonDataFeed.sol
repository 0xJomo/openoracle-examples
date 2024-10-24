// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./IOpenOracleTaskManager.sol";

interface IOpenOracleCommonDataFeed {
    event NewPriceReported(
        uint8 indexed taskType, 
        uint32 referenceTaskIndex, 
        bytes result,
        uint256 sd, 
        uint256 timestamp, 
        uint32 createdBlock, 
        uint32 respondedBlock
    );

    event UpdateAVGReported(
        uint8 indexed taskType,
        uint8 indexed sourceType,
        uint256 indexed dayTime,
        uint256 currentBlock
    );

    /// @notice Call the task manager to request latest data
    function requestNewReport(uint8 _taskType) external;

    /// @notice Call the task manager to request latest data
    function requestNewReportWithData(uint8 _taskType,bytes calldata _taskData) external;

    function requestNewReportCallback(uint8 _taskType, uint256 requestId) external;

    function requestNewReportWithDataCallback(uint8 _taskType,bytes calldata _taskData, uint256 requestId) external;

    /// @notice Saves the latest data from task manager in contract
    function saveLatestData(
        IOpenOracleTaskManager.Task calldata task, 
        IOpenOracleTaskManager.WeightedTaskResponse calldata response, 
        IOpenOracleTaskManager.TaskResponseMetadata calldata metadata
    ) external;

    /// @notice Returns the latest data
    function latestRoundData(uint8 taskType) view external returns (
        bytes memory result,
        uint256 sd,
        uint256 timestamp,
        uint32 startBlock,
        uint32 endBlock
    );

    /// @notice Returns the latest avg data
    function latestRoundAVGData(uint8 taskType) view external returns (
        uint256 price,
        uint256 latestBlock
    );

    function getDayAVGData(uint8 taskType,uint256 dayTime) view external returns(
        uint256 price,
        uint256 latestBlock
    );

    /// @notice Returns the latest data
    function getRoundData(uint32 roundId) view external returns (
        bytes memory result,
        uint256 sd,
        uint256 timestamp,
        uint32 startBlock,
        uint32 endBlock
    );

    function setDefaultThresholds(uint8 responderThreshold, uint96 stakeThreshold) external;

    function setThresholds(uint8 taskType, uint8 responderThreshold, uint96 stakeThreshold) external;
}
