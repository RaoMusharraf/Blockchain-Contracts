// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./ITest.sol";

contract test is ITest {
    constructor(IERC20 _token) {}

    function forward(
        address token,
        address sender,
        address receiver,
        uint256 amount
    ) external {
        IERC20(token).transferFrom(sender, receiver, amount);
    }
}