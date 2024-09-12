// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./OpenBytesLib.sol";
import "../lib/IOpenOracleCommonDataFeed.sol";

contract GoldPriceConsumer {
    IOpenOracleCommonDataFeed public dataFeed;

    constructor(address _dataFeed) {
        dataFeed = IOpenOracleCommonDataFeed(_dataFeed);
    }

    function updateGoldPrice() external {
        dataFeed.requestNewReport(1);
    }

    function getGoldPrice(uint256 maxPriceAge) external view returns (uint256) {
        (bytes memory result,, uint256 timestamp,,) = dataFeed.latestRoundData(1);

        if (timestamp + maxPriceAge < block.timestamp) {
            revert PriceTooOld(timestamp);
        }

        return OpenBytesLib.hexToDec(result);
    }

    error PriceTooOld(uint256 priceTimestamp);
}
