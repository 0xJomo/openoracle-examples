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

You can also edit the script and replace `contractAddress` with other addresses to get other price feeds.

You can find all available price feeds here: https://openlayer.gitbook.io/openlayer/openoracle/data-types