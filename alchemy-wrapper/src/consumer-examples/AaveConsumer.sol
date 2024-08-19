// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../Diamond.sol";
import "../CrossChainWrapperFacet.sol";
import "../AaveDecodingFacet.sol";

contract AaveConsumer {
    Diamond public openOracleCrossChainWrapper;

    bytes32 public mainnetTaskId;
    bytes32 public arbitrumTaskId;

    constructor(address _wrapperAddress) {
        openOracleCrossChainWrapper = Diamond(payable(_wrapperAddress));
    }

    function requestAaveWBTCRates() external {
        // Request WBTC lending rate from Ethereum Mainnet (chainId = 1)
        mainnetTaskId = CrossChainWrapperFacet(address(openOracleCrossChainWrapper)).request(
            CrossChainWrapperFacet.CallRequest({
                chainId: 1,  // Ethereum Mainnet
                contractAddress: address(this),
                functionData: abi.encodeWithSignature("getReserveData()")
            })
        );

        // Request WBTC lending rate from Arbitrum (chainId = 42161)
        arbitrumTaskId = CrossChainWrapperFacet(address(openOracleCrossChainWrapper)).request(
            CrossChainWrapperFacet.CallRequest({
                chainId: 42161,  // Arbitrum
                contractAddress: address(this),
                functionData: abi.encodeWithSignature("getReserveData()")
            })
        );
    }

    function getAggregatedWBTCLendingRates(uint256 _maxResponseAge) external view returns (uint128 mainnetRate, uint128 arbitrumRate) {
        // Retrieve WBTC lending rate from Ethereum Mainnet
        mainnetRate = AaveDecodingFacet(address(openOracleCrossChainWrapper)).getAaveMainnetWBTCLendingRate(mainnetTaskId, _maxResponseAge);

        // Retrieve WBTC lending rate from Arbitrum
        arbitrumRate = AaveDecodingFacet(address(openOracleCrossChainWrapper)).getAaveArbitrumWBTCLendingRate(arbitrumTaskId, _maxResponseAge);
    }
}
