function parseHexString(hexString) {
  if(hexString.startsWith('0x')){
    hexString = hexString.slice(2);
  }

  const result = {};
  let index = 0;

  while (index < hexString.length) {
    const length = parseInt(hexString.slice(index, index + 4), 16);
    index += 4;

    const data = hexString.slice(index, index + length);
    index += length;

    const decodedData = Buffer.from(data, 'hex').toString();

    result[`data_${Object.keys(result).length}`] = decodedData;
  }

  return result;
}

module.exports = { parseHexString }