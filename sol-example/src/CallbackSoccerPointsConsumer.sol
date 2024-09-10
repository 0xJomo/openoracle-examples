// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./OpenBytesLib.sol";
import "../lib/IOpenOracleCommonDataFeed.sol";

contract CallbackSoccerPointsConsumer {
    IOpenOracleCommonDataFeed public dataFeed;

    // Track request IDs, timestamps, results, and response statuses
    uint256 public pointsRequestId = 0;
    mapping(uint256 => uint256) public pointsRequestTimestamp;
    mapping(uint256 => uint256) public pointsRequestResult;
    mapping(uint256 => bool) public requestResponded; // Track whether a request has been responded to

    uint256 public maxPointsAge = 1 days;

    constructor(address _dataFeed) {
        dataFeed = IOpenOracleCommonDataFeed(_dataFeed);
    }

    // Request soccer points for a specific team using a callback
    function requestPoints(uint32 league, uint64 season, uint32 team) public returns (uint256) {
        uint256 currentRequestId = pointsRequestId;

        dataFeed.requestNewReportWithDataCallback(
            14, 
            abi.encode(league, season, team), 
            currentRequestId
        );
        
        pointsRequestTimestamp[currentRequestId] = block.timestamp;
        pointsRequestId++;

        // Mark the request as not responded to yet
        requestResponded[currentRequestId] = false;

        return currentRequestId; // Return the request ID
    }

    // Get the soccer points for a specific request ID
    function getPoints(uint256 requestId) external view returns (uint256) {
        // Check if the request has been responded
        if (!requestResponded[requestId]) {
            revert RequestNotResponded(requestId);
        }

        uint256 timestamp = pointsRequestTimestamp[requestId];

        if (timestamp + maxPointsAge < block.timestamp) {
            revert PointsTooOld(timestamp);
        }

        return pointsRequestResult[requestId];
    }

    // Callback function invoked by the oracle to deliver soccer points result
    function fulfillResult(
        uint256 requestId,       // requestId being responded
        bytes memory hex_result, // result in hex bytes
        bytes memory             // extra data, if any
    ) external {
        uint256 points = OpenBytesLib.hexToDec(hex_result);
        pointsRequestResult[requestId] = points;
        requestResponded[requestId] = true; // Mark the request as responded
    }

    error PointsTooOld(uint256 pointsTimestamp);
    error RequestNotResponded(uint256 requestId);
}