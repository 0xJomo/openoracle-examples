# openoracle-examples
This repo demonstrates how to integrate with OpenOracle.

You can also find instructions here: https://openlayer.gitbook.io/openlayer/get-started/openoracle/for-data-consumers

`NOTE: OpenOracle right now only runs on Holesky testnet.`

## JS integration
The `js-example` folder contains examples on integrating using Javascript.

```
cd js-example
```

```
npm i
```

### Get latest price feed data
```
node getLatestData.js
```

### Request new report for feed
The feed updates every 10 minutes by default, new report can be requested via
```
node requestNewData.js
```

### Available feeds
You can also edit the script and replace `contractAddress` with other addresses to get other price feeds.

You can find all available price feeds here: https://openlayer.gitbook.io/openlayer/openoracle/data-types