// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./OpenBytesLib.sol";
import "../lib/IOpenOracleCommonDataFeed.sol";

contract GenericPriceConsumer {
    IOpenOracleCommonDataFeed public dataFeed;

    constructor(address _dataFeed) {
        dataFeed = IOpenOracleCommonDataFeed(_dataFeed);
    }

    function updatePrice(uint8 _taskType) external {
        if (_taskType > 13) {
            revert InvalidTaskType();
        }
        dataFeed.requestNewReport(_taskType);
    }

    function getPrice(uint8 _taskType, uint256 maxPriceAge) external view returns (uint256) {
        if (_taskType > 13) {
            revert InvalidTaskType();
        }

        (bytes memory result,, uint256 timestamp,,) = dataFeed.latestRoundData(_taskType);

        if (timestamp + maxPriceAge < block.timestamp) {
            revert PriceTooOld(timestamp);
        }

        return OpenBytesLib.hexToDec(result);
    }

    error InvalidTaskType();
    error PriceTooOld(uint256 priceTimestamp);
}
