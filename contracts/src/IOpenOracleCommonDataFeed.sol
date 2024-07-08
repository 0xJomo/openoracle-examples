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

    /// @notice Call the task manager to request latest data
    function requestNewReport(uint8 _taskType) external;

    /// @notice Call the task manager to request latest data
    function requestNewReportWithData(uint8 _taskType,bytes calldata _taskData) external;

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

    function setDefaultThresholds(uint8 responderThreshold, uint96 stakeThreshold) external;

    function setThresholds(uint8 taskType, uint8 responderThreshold, uint96 stakeThreshold) external;
}
