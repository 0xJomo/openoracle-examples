https://www.api-football.com/documentation-v3#tag/Fixtures/operation/get-fixtures-headtohead


# Football Data Feed Process

This document outlines the steps to create a task request for football data and retrieve the latest on-chain data.

## Step 1: Create Task Request

Run the following command to create the task request:

```
node createDataFeedFootballRequest.js
```

This script will generate a task request for the football data feed.

## Step 2: Wait for Task Completion

After executing the script, wait for approximately 1~2 block times to allow the task to be processed. This ensures that the request is fully handled on the blockchain.

## Step 3: Retrieve Latest On-Chain Data

Once the waiting period is over, execute the following command to get the latest football data from the blockchain:

```
node getFootballLatestData.js
```

This script will fetch and display the most recent data related to football from the blockchain.