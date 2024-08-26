// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../lib/IOpenOracleCommonDataFeed.sol";

contract GenericRPCWrapper {

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

    IOpenOracleCommonDataFeed public rpcFeed;
    uint8 public taskType = 17;
    mapping(address => uint256) userTaskCounter;
    mapping(bytes32 => CallRequest) public taskIdToRequests;
    mapping(bytes32 => CallResponse) public taskIdToResponses;

    constructor(IOpenOracleCommonDataFeed _rpcFeed){
        rpcFeed = IOpenOracleCommonDataFeed(_rpcFeed);
    }

    function request(CallRequest calldata _callRequest) external returns (bytes32 taskId) {
        taskId = keccak256(abi.encode(msg.sender, userTaskCounter[msg.sender]));
        userTaskCounter[msg.sender]++;
        rpcFeed.requestNewReportWithData(taskType, abi.encode(_callRequest.chainId, _callRequest.contractAddress, _callRequest.functionData));
        taskIdToRequests[taskId] = _callRequest;
    }

    function update_response(bytes32 _taskId, bytes calldata _response, uint256 sd, uint256 timestamp, uint32 startBlock, uint32 endBlock) external onlyFeed{
        require(taskIdToRequests[_taskId].chainId != 0, "Invalid task ID");
        taskIdToResponses[_taskId] = CallResponse(_response, sd, timestamp, startBlock, endBlock);
        delete taskIdToRequests[_taskId];
        emit ResponseReceived(_taskId, _response);
    }

    function get_hex_response(bytes32 _taskId, uint256 _maxResponseAge) external view returns (bytes memory response) {
        CallResponse memory callResponse = taskIdToResponses[_taskId];
        require(callResponse.timestamp != 0, "No response available");
        require(callResponse.timestamp + _maxResponseAge >= block.timestamp, "Response too old");
        return callResponse.result;
    }

    modifier onlyFeed(){
        require(msg.sender == address(rpcFeed), "Only feed can call this function");
        _;
    }

    event ResponseReceived(bytes32 indexed taskId, bytes response);
}
