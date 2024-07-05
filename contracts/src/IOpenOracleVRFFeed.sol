// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./IOpenOracleIdenticalAnswerTaskManager.sol";

interface IOpenOracleVRFFeed {
    event NewIdenticalAnswerReported(
        uint8 indexed taskType, 
        uint32 referenceTaskIndex,
        bytes result,
        uint256 timestamp, 
        uint32 createdBlock, 
        uint32 respondedBlock
    );

    // /// @notice Call the task manager to request latest data
    // function requestNewReport() external;

    /// @notice Saves the latest data from task manager in contract
    function saveLatestData(
        IOpenOracleIdenticalAnswerTaskManager.Task calldata task, 
        IOpenOracleIdenticalAnswerTaskManager.AggregatedTaskResponse calldata response, 
        IOpenOracleIdenticalAnswerTaskManager.TaskResponseMetadata calldata metadata
    ) external;

    /// @notice Returns the latest data
    function latestRoundData() view external returns (
        bytes calldata result,
        uint256 timestamp,
        uint32 startBlock,
        uint32 endBlock
    );

    function setThresholds(uint8 responderThreshold, uint96 stakeThreshold) external;
}
