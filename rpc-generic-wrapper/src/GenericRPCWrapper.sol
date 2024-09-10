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

    enum RequestStatus { Pending, Completed, Expired }

    IOpenOracleCommonDataFeed public rpcFeed;
    uint8 public taskType = 17;
    uint256 public requestExpirationTime = 1 days;

    mapping(address => uint256) userRequestCounter;  // Keeps track of how many requests a user has made
    mapping(uint256 => CallRequest) public requestIdToRequests;  // Maps request ID to requests
    mapping(uint256 => CallResponse) public requestIdToResponses; // Maps request ID to responses
    mapping(uint256 => RequestStatus) public requestIdToStatus; // Maps request ID to its current status (Pending, Completed, Expired)

    event RequestMade(uint256 indexed requestId, address indexed user, uint256 chainId, address contractAddress);
    event ResponseReceived(uint256 indexed requestId, bytes response, uint256 sd, uint256 timestamp, uint32 startBlock, uint32 endBlock);
    event RequestExpired(uint256 indexed requestId);

    modifier onlyFeed() {
        require(msg.sender == address(rpcFeed), "Only feed can call this function");
        _;
    }

    constructor(IOpenOracleCommonDataFeed _rpcFeed) {
        rpcFeed = IOpenOracleCommonDataFeed(_rpcFeed);
    }

    // Request a new data call with the oracle
    function request(CallRequest calldata _callRequest) external returns (uint256 requestId) {
        uint256 userRequestCount = userRequestCounter[msg.sender]++;
        requestId = uint256(keccak256(abi.encode(msg.sender, userRequestCount, _callRequest.chainId, _callRequest.contractAddress)));
        
        // Make the request to the oracle with a callback
        rpcFeed.requestNewReportWithDataCallback(taskType, abi.encode(_callRequest.chainId, _callRequest.contractAddress, _callRequest.functionData), requestId);
        
        // Store the request and set the status to pending
        requestIdToRequests[requestId] = _callRequest;
        requestIdToStatus[requestId] = RequestStatus.Pending;

        emit RequestMade(requestId, msg.sender, _callRequest.chainId, _callRequest.contractAddress);
    }

    // Callback function invoked by the oracle to deliver the result
    function fulfillResult(
        uint256 requestId,         // Request ID for the call
        bytes memory result,       // The result of the request
        bytes memory               // Placeholder for any extra data
    ) external onlyFeed{
        require(requestIdToRequests[requestId].chainId != 0, "Invalid request ID");

        // Store the response data and update the status to Completed
        requestIdToResponses[requestId] = CallResponse({
            result: result,
            sd: 0,  // Placeholder value for now
            timestamp: block.timestamp,
            startBlock: uint32(block.number),
            endBlock: uint32(block.number)
        });

        requestIdToStatus[requestId] = RequestStatus.Completed;

        emit ResponseReceived(requestId, result, 0, block.timestamp, uint32(block.number), uint32(block.number));
    }

    // Get the hex-encoded response for a given request ID, checking if the response is still valid
    function get_hex_response(uint256 requestId, uint256 _maxResponseAge) external view returns (bytes memory response) {
        CallResponse memory callResponse = requestIdToResponses[requestId];
        require(callResponse.timestamp != 0, "No response available");

        // Check for expired response
        if (callResponse.timestamp + _maxResponseAge < block.timestamp) {
            requestIdToStatus[requestId] = RequestStatus.Expired;
            emit RequestExpired(requestId);
            revert("Response too old");
        }

        return callResponse.result;
    }

    // Check if a request has expired based on the timestamp
    function checkExpiration(uint256 requestId) public {
        CallResponse memory callResponse = requestIdToResponses[requestId];
        if (callResponse.timestamp != 0 && block.timestamp > callResponse.timestamp + requestExpirationTime) {
            requestIdToStatus[requestId] = RequestStatus.Expired;
            emit RequestExpired(requestId);
        }
    }

    // Utility function to check the status of a request
    function getRequestStatus(uint256 requestId) external view returns (RequestStatus) {
        return requestIdToStatus[requestId];
    }
}