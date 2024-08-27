// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {GenericRPCWrapper} from "./GenericRPCWrapper.sol";

contract AaveRateConsumer {
    GenericRPCWrapper public openOracleGenericRPCWrapper;
    
    bytes32[] public mainnetTaskIds;
    bytes32[] public arbitrumTaskIds;
    bytes32[] public optimismTaskIds;

    mapping(bytes32 => bool) public taskIdHasResponse;

    constructor(address _wrapperAddress) {
        openOracleGenericRPCWrapper = GenericRPCWrapper(_wrapperAddress);
    }

    function requestAaveRates() external returns (bytes32 mainnetTaskId, bytes32 arbitrumTaskId, bytes32 optimismTaskId) {
        // request mainnet aave USDC variable borrow rate
        mainnetTaskId = openOracleGenericRPCWrapper.request(
            GenericRPCWrapper.CallRequest({
                chainId: 1,
                contractAddress: 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2,
                functionData: abi.encodeWithSignature("getReserveData(address)", 0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48) // USDC
            })
        );

        mainnetTaskIds.push(mainnetTaskId);

        // request arbitrum aave USDC variable borrow rate
        arbitrumTaskId = openOracleGenericRPCWrapper.request(
            GenericRPCWrapper.CallRequest({
                chainId: 42161,
                contractAddress: 0x794a61358D6845594F94dc1DB02A252b5b4814aD,
                functionData: abi.encodeWithSignature("getReserveData(address)", 0xaf88d065e77c8cC2239327C5EDb3A432268e5831) // USDC
            })
        );

        arbitrumTaskIds.push(arbitrumTaskId);

        // request optimism aave USDC variable borrow rate
        optimismTaskId = openOracleGenericRPCWrapper.request(
            GenericRPCWrapper.CallRequest({
                chainId: 10,
                contractAddress: 0x794a61358D6845594F94dc1DB02A252b5b4814aD,
                functionData: abi.encodeWithSignature("getReserveData(address)", 0x0b2c639c533813f4aa9d7837caf62653d097ff85) // USDC
            })
        );

        optimismTaskIds.push(optimismTaskId);
    }

    function aggregateRates() external {
        for(uint i = mainnetTaskIds.length - 1; i >= 0; i--) {
            bytes32 mainnetTask = mainnetTaskIds[i];
            if(taskIdHasResponse[mainnetTask]) {
                bytes memory response = openOracleGenericRPCWrapper.get_hex_response(mainnetTask, 1 days);
                uint256 mainnetRate = abi.decode(response, (,,,,uint128,,,,,,,,,));
            }

            bytes32 arbitrumTask = arbitrumTaskIds[i];
            if(taskIdHasResponse[arbitrumTask]) {
                bytes memory response = openOracleGenericRPCWrapper.get_hex_response(arbitrumTask, 1 days);
                uint256 arbitrumRate = abi.decode(response, (,,,,uint128,,,,,,,,,));
            }

            bytes32 optimismTask = optimismTaskIds[i];
            if(taskIdHasResponse[optimismTask]) {
                bytes memory response = openOracleGenericRPCWrapper.get_hex_response(optimismTask, 1 days);
                uint256 optimismRate = abi.decode(response, (,,,,uint128,,,,,,,,,));
            }
        }

        return (mainnetRate, arbitrumRate, optimismRate)/3;
    }
}