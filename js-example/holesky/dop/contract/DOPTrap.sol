// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";
import "./IOpenOracleCommonDataFeed.sol";
import "./BytesLib.sol";

contract DOPTrap is ITrap {

    using BytesLib for bytes;

    uint8 internal taskType;
    IOpenOracleCommonDataFeed internal oracle;

    constructor(
        uint8 _taskType,
        IOpenOracleCommonDataFeed _oracle
    ) {
        taskType = _taskType;
        oracle = _oracle;
    }

    function collect() external view returns (bytes memory) {
        (bytes memory result,,,,) = oracle.latestRoundData(taskType);
        return result;
    }

    function shouldRespond(
        bytes[] calldata data
    ) external pure returns (bool, bytes memory) {
        uint256 len = data.length;
        if (len < 2) {
            return (false, bytes(""));
        }
/*        Drosera has Trap:
    1. if current (p2p.org) performance score < TOP-10 Node operators
    2. and withdraw queue < X1 days
    3. and gas fees < Y usdc
    4. and stake queue < X2 days
    5. → re-delegate X% of stake stake*/
        /*for (uint256 i = 1; i < len; i++) {

           //todo
        }*/

        return (true, bytes(""));
    }
}