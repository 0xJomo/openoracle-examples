// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./LibDiamond.sol";
import "../lib/IOpenOracleCommonDataFeed.sol";

contract CrossChainWrapperFacet {
    
    using LibDiamond for LibDiamond.DiamondStorage;

    struct CallRequest {
        uint256 chainId;
        address contractAddress;
        bytes functionData;
    }

    struct CallResponse {
        bytes result;
        uint256 sd;
        uint256 timestamp;
        uint32 startBlock;
        uint32 endBlock;
    }

    function initialize(IOpenOracleCommonDataFeed _alchemyCallNode) external {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        require(address(ds.alchemyCallNode) == address(0), "Already initialized");
        ds.alchemyCallNode = _alchemyCallNode;
    }

    function request(CallRequest calldata _callRequest) external returns (bytes32 taskId) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        taskId = keccak256(abi.encode(msg.sender, ds.userTaskCounter[msg.sender]));
        ds.userTaskCounter[msg.sender]++;
        ds.alchemyCallNode.requestNewReportWithData(17, abi.encode(_callRequest.chainId, _callRequest.contractAddress, _callRequest.functionData));
        ds.taskIdToRequests[taskId] = _callRequest;
    }

    function update_response(bytes32 _taskId, bytes calldata _response, uint256 sd, uint256 timestamp, uint32 startBlock, uint32 endBlock) external {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        require(ds.taskIdToRequests[_taskId].chainId != 0, "Invalid task ID");
        ds.taskIdToResponses[_taskId] = CallResponse(_response, sd, timestamp, startBlock, endBlock);
        delete ds.taskIdToRequests[_taskId];
    }

    function get_hex_response(bytes32 _taskId, uint256 _maxResponseAge) external view returns (bytes memory response) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        CallResponse memory callResponse = ds.taskIdToResponses[_taskId];
        require(callResponse.timestamp != 0, "No response available");
        require(callResponse.timestamp + _maxResponseAge >= block.timestamp, "Response too old");
        return callResponse.result;
    }
}
