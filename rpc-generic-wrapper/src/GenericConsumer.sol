// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {GenericRPCWrapper} from "./GenericRPCWrapper.sol";

contract MockConsumer {
    GenericRPCWrapper public openOracleGenericRPCWrapper;
    
    constructor(address _wrapperAddress) {
        openOracleGenericRPCWrapper = GenericRPCWrapper(_wrapperAddress);
    }

    function createCrossChainRequest(
        uint256 _chainId,
        address _contractAddress,
        bytes memory _functionData
    ) external returns (bytes32 taskId) {
        // request from GenericRPCWrapper
        taskId = openOracleGenericRPCWrapper.request(
            GenericRPCWrapper.CallRequest({
                chainId: _chainId,
                contractAddress: _contractAddress,
                functionData: _functionData
            })
        );
    }

    function getCrossChainResponse(bytes32 _taskId, uint256 _maxResponseAge) external view returns (bytes memory response) {
        // get_hex_response from GenericRPCWrapperFacet
        return openOracleGenericRPCWrapper.get_hex_response(_taskId, _maxResponseAge);
    }
}
