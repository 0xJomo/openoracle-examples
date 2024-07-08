// const fetch = require('node-fetch');

async function addFeedConfig() {

  try {

    const requestBody = {
      "MostRecentPowerballDraw": {
        "url": "https://www.calottery.com/api/DrawGameApi/DrawGamePastDrawResults/12/1/20",
        "path": [
          "MostRecentDraw DrawNumber",
          "MostRecentDraw DrawDate",
          "MostRecentDraw JackpotAmount",
          "MostRecentDraw WinningNumbers 0 Number",
          "MostRecentDraw WinningNumbers 1 Number",
          "MostRecentDraw WinningNumbers 2 Number",
          "MostRecentDraw WinningNumbers 3 Number",
          "MostRecentDraw WinningNumbers 4 Number",
          "MostRecentDraw WinningNumbers 5 Number",
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