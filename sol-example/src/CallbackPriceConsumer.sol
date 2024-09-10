// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./OpenBytesLib.sol";  // Library for handling conversion from hex to decimal
import "../lib/IOpenOracleCommonDataFeed.sol";  // Interface for the Oracle data feed

contract CallbackPriceConsumer {
    IOpenOracleCommonDataFeed public dataFeed;
    uint8 public taskType;

    // Tracks request IDs, timestamps and results of price requests
    uint256 public priceRequestId = 0;
    mapping(uint256 => uint256) public priceRequestTimestamp;
    mapping(uint256 => uint256) public priceRequestResult;

    uint256 public maxPriceAge = 1 days;

    constructor(address _dataFeed, uint8 _taskType) {
        dataFeed = IOpenOracleCommonDataFeed(_dataFeed);
        taskType = _taskType;

        // Init price
        (bytes memory result,,,,) = dataFeed.latestRoundData(taskType);
        priceRequestResult[priceRequestId] = OpenBytesLib.hexToDec(result);
        priceRequestTimestamp[priceRequestId] = block.timestamp;
        priceRequestId++;
    }

    function updatePrice() public {
        dataFeed.requestNewReportCallback(taskType, priceRequestId);
        priceRequestTimestamp[priceRequestId] = block.timestamp;
        priceRequestId++;
    }

    function getLatestPrice() external returns (uint256) {
        uint256 timestamp = priceRequestTimestamp[priceRequestId - 1];

        if (timestamp + maxPriceAge < block.timestamp) {
            updatePrice();
        }

        return priceRequestResult[priceRequestId - 1];
    }

    // Callback function invoked by the oracle to deliver the gold price result
    function fulfillResult(
        uint256 requestId,       // requestId being responded
        bytes memory hex_result, // result in hex bytes
        bytes memory             
    ) external {
        uint256 price = OpenBytesLib.hexToDec(hex_result);
        priceRequestResult[requestId] = price;
    }
}
