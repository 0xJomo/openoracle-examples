// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {console, Test} from "forge-std/Test.sol";
import {GenericPriceConsumer} from "src/GenericPriceConsumer.sol";
import {GoldPriceConsumer} from "src/GoldPriceConsumer.sol";
import {SoccerPointsConsumer} from "src/SoccerPointsConsumer.sol";

contract ConsumerTests is Test {
    address public user = address(bytes20("user"));

    GenericPriceConsumer genericPriceConsumer;
    GoldPriceConsumer goldPriceConsumer;
    SoccerPointsConsumer soccerPointsConsumer;

    function setUp() public {
        // Fork Holesky
        vm.createSelectFork(vm.rpcUrl("holesky"));

        address dataFeed = 0xB233eE56e57f7eB1B1144b28214Abc74b273d3D5;

        genericPriceConsumer = new GenericPriceConsumer(dataFeed);
        goldPriceConsumer = new GoldPriceConsumer(dataFeed);
        soccerPointsConsumer = new SoccerPointsConsumer(dataFeed);
    }

    function testGenericPriceConsumer() public view {
        // Fetching silver price
        uint256 silverPrice = genericPriceConsumer.getPrice(2, 365 days);
        console.log("Silver price: %d", silverPrice);
        if (silverPrice == 0) {
            revert("Invalid Price");
        }

        // Fetching platinum price
        uint256 platinumPrice = genericPriceConsumer.getPrice(3, 365 days);
        console.log("Platinum price: %d", platinumPrice);
        if (platinumPrice == 0) {
            revert("Invalid Price");
        }

        // Updating prices won't work on a forked network
        //genericPriceConsumer.updatePrice(2);
        //genericPriceConsumer.updatePrice(3);
    }

    function testGoldPriceConsumer() public view {
        // Fetching gold price
        uint256 goldPrice = goldPriceConsumer.getGoldPrice(365 days);
        console.log("Gold price: %d", goldPrice);
        if (goldPrice == 0) {
            revert("Invalid Price");
        }

        // Updating gold price won't work on a forked network
        //goldPriceConsumer.updateGoldPrice();
    }

    function testSoccerPointsConsumer() public view {
        // Fetching points for a team
        // soccerPointsConsumer.requestPoints(1, 2021, 1);
        uint256 points = soccerPointsConsumer.consumePoints(365 days);
        console.log("Points: %d", points);
        if (points == 0) {
            revert("Invalid Points");
        }
    }
}
