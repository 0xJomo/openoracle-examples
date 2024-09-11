// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {GenericRPCWrapper} from "./GenericRPCWrapper.sol";

contract AaveRateConsumer {
    GenericRPCWrapper public openOracleGenericRPCWrapper;
    
    uint256[] public mainnetRequestIds;
    uint256[] public arbitrumRequestIds;
    uint256[] public optimismRequestIds;

    mapping(uint256 => bool) public requestIdHasResponse;

    constructor(address _wrapperAddress) {
        openOracleGenericRPCWrapper = GenericRPCWrapper(_wrapperAddress);
    }

    // Function to request Aave rates across different chains
    function requestAaveRates() external returns (uint256 mainnetRequestId, uint256 arbitrumRequestId, uint256 optimismRequestId) {
        // Request mainnet Aave USDC variable borrow rate
        mainnetRequestId = openOracleGenericRPCWrapper.request(
            GenericRPCWrapper.CallRequest({
                chainId: 1,
                contractAddress: 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2,
                functionData: abi.encodeWithSignature("getReserveData(address)", 0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48) // USDC
            })
        );

        mainnetRequestIds.push(mainnetRequestId);

        // Request Arbitrum Aave USDC variable borrow rate
        arbitrumRequestId = openOracleGenericRPCWrapper.request(
            GenericRPCWrapper.CallRequest({
                chainId: 42161,
                contractAddress: 0x794a61358D6845594F94dc1DB02A252b5b4814aD,
                functionData: abi.encodeWithSignature("getReserveData(address)", 0xaf88d065e77c8cC2239327C5EDb3A432268e5831) // USDC
            })
        );

        arbitrumRequestIds.push(arbitrumRequestId);

        // Request Optimism Aave USDC variable borrow rate
        optimismRequestId = openOracleGenericRPCWrapper.request(
            GenericRPCWrapper.CallRequest({
                chainId: 10,
                contractAddress: 0x794a61358D6845594F94dc1DB02A252b5b4814aD,
                functionData: abi.encodeWithSignature("getReserveData(address)", 0x0b2c639c533813f4aa9d7837caf62653d097ff85) // USDC
            })
        );

        optimismRequestIds.push(optimismRequestId);
    }

    // Function to aggregate rates across different chains
    function aggregateRates() external view returns (uint256) {
        uint256 totalRate;
        uint256 validResponses = 0;

        for (uint i = 0; i < mainnetRequestIds.length; i++) {
            uint256 mainnetRequest = mainnetRequestIds[i];
            if (requestIdHasResponse[mainnetRequest]) {
                bytes memory response = openOracleGenericRPCWrapper.get_hex_response(mainnetRequest, 1 days);
                uint256 mainnetRate = abi.decode(response, (,,,,uint128,,,,,,,,,));
                totalRate += mainnetRate;
                validResponses++;
            }

            uint256 arbitrumRequest = arbitrumRequestIds[i];
            if (requestIdHasResponse[arbitrumRequest]) {
                bytes memory response = openOracleGenericRPCWrapper.get_hex_response(arbitrumRequest, 1 days);
                uint256 arbitrumRate = abi.decode(response, (,,,,uint128,,,,,,,,,));
                totalRate += arbitrumRate;
                validResponses++;
            }

            uint256 optimismRequest = optimismRequestIds[i];
            if (requestIdHasResponse[optimismRequest]) {
                bytes memory response = openOracleGenericRPCWrapper.get_hex_response(optimismRequest, 1 days);
                uint256 optimismRate = abi.decode(response, (,,,,uint128,,,,,,,,,));
                totalRate += optimismRate;
                validResponses++;
            }
        }

        require(validResponses > 0, "No valid responses received");

        return totalRate / validResponses;
    }
}
