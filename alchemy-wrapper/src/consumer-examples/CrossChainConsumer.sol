// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../Diamond.sol";
import "../CrossChainWrapperFacet.sol";

contract MockConsumer {
    Diamond public openOracleCrossChainWrapper;
    
    constructor(address _wrapperAddress) {
        openOracleCrossChainWrapper = Diamond(payable(_wrapperAddress));
    }

    function createCrossChainRequest(
        uint256 _chainId,
        address _contractAddress,
        bytes memory _functionData
    ) external returns (bytes32 taskId) {
        // Call the request function from CrossChainWrapperFacet
        taskId = CrossChainWrapperFacet(address(openOracleCrossChainWrapper)).request(
            CrossChainWrapperFacet.CallRequest({
                chainId: _chainId,
                contractAddress: _contractAddress,
                functionData: _functionData
            })
        );
    }

    function getCrossChainResponse(bytes32 _taskId, uint256 _maxResponseAge) external view returns (bytes memory response) {
        // Call the get_hex_response function from CrossChainWrapperFacet
        return CrossChainWrapperFacet(address(openOracleCrossChainWrapper)).get_hex_response(_taskId, _maxResponseAge);
    }
}
