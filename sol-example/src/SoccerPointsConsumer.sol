// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./OpenBytesLib.sol";
import "../lib/IOpenOracleCommonDataFeed.sol";

contract SoccerPointsConsumer {
    IOpenOracleCommonDataFeed public dataFeed;

    constructor(address _dataFeed) {
        dataFeed = IOpenOracleCommonDataFeed(_dataFeed);
    }

    function requestPoints(uint32 league, uint64 season, uint32 team) external {
        dataFeed.requestNewReportWithData(14, abi.encode(league, season, team));
    }

    function consumePoints(uint256 maxPointsAge) external view returns (uint256) {
        (bytes memory result,, uint256 timestamp,,) = dataFeed.latestRoundData(14);

        if (timestamp + maxPointsAge < block.timestamp) {
            revert PointsTooOld(timestamp);
        }

        return OpenBytesLib.hexToDec(result);
    }

    error PointsTooOld(uint256 pointsTimestamp);
}
