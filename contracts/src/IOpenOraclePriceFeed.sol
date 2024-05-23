// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./IOpenOracleTaskManager.sol";

interface IOpenOraclePriceFeed {
    event NewPriceReported(
        uint8 indexed taskType, 
        uint32 referenceTaskIndex, 
        uint256 price, 
        uint256 sd, 
        uint256 timestamp, 
        uint32 createdBlock, 
        uint32 respondedBlock
    );

    /// @notice Call the task manager to request latest data
    function requestNewReport() external;

    /// @notice Call the task manager to request latest data
    function requestNewReportWithData(bytes calldata _taskData) external;

    /// @notice Saves the latest data from task manager in contract
    function saveLatestData(
        IOpenOracleTaskManager.Task calldata task, 
        IOpenOracleTaskManager.WeightedTaskResponse calldata response, 
        IOpenOracleTaskManager.TaskResponseMetadata calldata metadata
    ) external;

    /// @notice Returns the latest data
    function latestRoundData() view external returns (
        uint256 price,
        uint256 sd,
        uint256 timestamp,
        uint32 startBlock,
        uint32 endBlock
    );

    function setThresholds(uint8 responderThreshold, uint96 stakeThreshold) external;
}
