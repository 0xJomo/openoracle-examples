## Solidity Examples

Under src and test you will find examples on how to consume different OpenLayer datafeeds inside a smart contract. There are further examples being baked, check them out soon...

> These examples leverage the Foundry framework. For more instructions please refer to: https://book.getfoundry.sh/

### To install Foundry
```shell
# first run
curl -L https://foundry.paradigm.xyz | bash

# then run
foundryup
```

### To test and see fetched prices

```shell
$ forge test -vv
```

If it went smoothly you will be greeted with:
```shell
[⠢] Compiling...
[⠰] Compiling 5 files with 0.8.12
[⠒] Solc 0.8.12 finished in 1.18s
Compiler run successful!

Ran 3 tests for test/ConsumerTests.t.sol:ConsumerTests
[PASS] testGenericPriceConsumer() (gas: 57237)
Logs:
  Silver price: 2790
  Platinum price: 94494

[PASS] testGoldPriceConsumer() (gas: 38995)
Logs:
  Gold price: 149695

[PASS] testSoccerPointsConsumer() (gas: 38318)
Logs:
  Points: 72

Suite result: ok. 3 passed; 0 failed; 0 skipped; finished in 7.12s (9.54s CPU time)

Ran 1 test suite in 7.14s (7.12s CPU time): 3 tests passed, 0 failed, 0 skipped (3 total tests)

```