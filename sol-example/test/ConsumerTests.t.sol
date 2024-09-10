// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {console, Test} from "forge-std/Test.sol";
import {GenericPriceConsumer} from "../src/GenericPriceConsumer.sol";
import {GoldPriceConsumer} from "../src/GoldPriceConsumer.sol";
import {SoccerPointsConsumer} from "../src/SoccerPointsConsumer.sol";
import {CallbackPriceConsumer} from "../src/CallbackPriceConsumer.sol";  

contract ConsumerTests is Test {
    address public user = address(bytes20("user"));

    GenericPriceConsumer genericPriceConsumer;
    CallbackPriceConsumer callbackPriceConsumer; 
    SoccerPointsConsumer soccerPointsConsumer;

    function setUp() public {
        // Fork Holesky (Ethereum testnet)
        vm.createSelectFork(vm.rpcUrl("holesky"));

        address dataFeed = 0xB233eE56e57f7eB1B1144b28214Abc74b273d3D5;  

        genericPriceConsumer = new GenericPriceConsumer(dataFeed);
        callbackPriceConsumer = new CallbackPriceConsumer(dataFeed, 1); // set a Gold callback feed
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

    function testCallbackPriceConsumer() public {
        // Fetching the latest gold price from CallbackPriceConsumer
        uint256 latestPrice = callbackPriceConsumer.getLatestPrice();
        console.log("Latest price from CallbackPriceConsumer: %d", latestPrice);
        if (latestPrice == 0) {
            revert("Invalid Price");
        }

        // Updating the price in CallbackPriceConsumer won't work on a forked network
        //callbackPriceConsumer.updatePrice();
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
