// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface ITest {
    function forward(
        address token,
        address sender,
        address receiver,
        uint256 amount
    ) external;
}