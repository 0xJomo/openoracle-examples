// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";
import "../IOpenOracleCommonDataFeed.sol";
import "../library/BytesLib.sol";

contract DOPTrap is ITrap {

    using BytesLib for bytes;

    struct effectivenessDataPoint {
        uint256 effectiveness;
        uint32 startBlock;
        uint32 endBlock;
    }

    uint8 public taskType = 24;
    IOpenOracleCommonDataFeed public oracle = IOpenOracleCommonDataFeed(0x726974f8e7bAEBD67aF7E9a9cb5Dc84dF3694901);

    function collect() external view override returns (bytes memory) {
        // getoperatoreffectiveness
        (bytes memory result,,,uint32 startBlock,uint32 endBlock) = oracle.latestRoundData(taskType);
        uint256 effectiveness = result.toUint256(0);
        return abi.encode(effectivenessDataPoint({effectiveness: effectiveness, startBlock: startBlock, endBlock: endBlock}));
    }

    function shouldRespond(
        bytes[] calldata data
    ) external pure override returns (bool, bytes memory) {
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