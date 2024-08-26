// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {GenericRPCWrapper} from "./GenericRPCWrapper.sol";

contract MockConsumer {
    GenericRPCWrapper public openOracleCrossChainWrapper;
    
    constructor(address _wrapperAddress) {
        openOracleCrossChainWrapper = GenericRPCWrapper(_wrapperAddress);
    }

    function createCrossChainRequest(
        uint256 _chainId,
        address _contractAddress,
        bytes memory _functionData
    ) external returns (bytes32 taskId) {
        // Call the request function from CrossChainWrapper
        taskId = openOracleCrossChainWrapper.request(
            GenericRPCWrapper.CallRequest({
                chainId: _chainId,
                contractAddress: _contractAddress,
                functionData: _functionData
            })
        );
    }

    function getCrossChainResponse(bytes32 _taskId, uint256 _maxResponseAge) external view returns (bytes memory response) {
        // Call the get_hex_response function from CrossChainWrapperFacet
        return openOracleCrossChainWrapper.get_hex_response(_taskId, _maxResponseAge);
    }
}
