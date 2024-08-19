// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./LibDiamond.sol";
import "./CrossChainWrapperFacet.sol";

// Diamond reminder: as facets are an extension of the diamond, they have the "same address" and can share storage slots

contract AaveDecodingFacet {

    function getAaveMainnetWBTCLendingRate(bytes32 taskId, uint256 _maxResponseAge) external view returns (uint128 currentBorrowRate) {        
        bytes memory response = CrossChainWrapperFacet(address(this)).get_hex_response(taskId, _maxResponseAge);
        (, , , currentBorrowRate, , , ,) = abi.decode(response, (uint256, uint128, uint128, uint128, uint128, uint128, uint128, uint128));
    }

    function getAaveArbitrumWBTCLendingRate(bytes32 taskId, uint256 _maxResponseAge) external view returns (uint128 currentBorrowRate) {        
        bytes memory response = CrossChainWrapperFacet(address(this)).get_hex_response(taskId, _maxResponseAge);
        (, , , currentBorrowRate, , , ,) = abi.decode(response, (uint256, uint128, uint128, uint128, uint128, uint128, uint128, uint128));
    }

    function getAaveUSDCLendingRate(bytes32 taskId, uint256 _maxResponseAge) external view returns (uint128 currentBorrowRate) {
        bytes memory response = CrossChainWrapperFacet(address(this)).get_hex_response(taskId, _maxResponseAge);
        (, , , currentBorrowRate, , , ,) = abi.decode(response, (uint256, uint128, uint128, uint128, uint128, uint128, uint128, uint128));
    }
}
