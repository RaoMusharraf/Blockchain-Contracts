// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ITest.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

// send ERC20 tokens to this contract
contract anotherContract {

    using SafeERC20 for IERC20;
    ITest add;

    constructor(ITest _add) {
        add = _add;
    }

    function addToken(address token) public {
        IERC20(token).safeTransferFrom(msg.sender, address(this), 10);
    }

    function sendTokens(address token, address receiver) external {
        add.forward(token, address(this), receiver, 10);
    }
}