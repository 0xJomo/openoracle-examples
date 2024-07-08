// const fetch = require('node-fetch');

async function addFeedConfig() {

  try {

    const requestBody = {
      "TestCoinRankFeed": {
        "url": "https://3rdparty-apis.coinmarketcap.com/v1/cryptocurrency/contract?address=0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
        "path": [
          "data rank",
          "status elapsed"
        ]
      }
    }
    const result = await fetch('https://us-central1-openoracle-de73b.cloudfunctions.net/backend_apis_holesky/api/update_price_feed_config', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'key':'openlayer2024',
      },
      body: JSON.stringify(requestBody),
    })

    console.log('result:', await result.json());
  } catch (error) {
    console.log(error)
    console.error('Error fetching data:', error.message);
  }
}


addFeedConfig();