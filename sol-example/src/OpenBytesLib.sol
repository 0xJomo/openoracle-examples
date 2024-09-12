// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

library OpenBytesLib {
    function hexToDec(bytes memory b) public pure returns (uint256) {
        require(b.length <= 32, "Bytes length exceeds 32 bytes");

        uint256 number;
        for (uint256 i = 0; i < b.length; i++) {
            number = number * 256 + uint8(b[i]);
        }

        return number;
    }
}
