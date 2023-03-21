// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ITest.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract AnotherContract {

    using SafeERC20 for IERC20;
    ITest add;

    constructor(ITest _add) {
        add = _add;
    }
    function addToken(IERC20 token, uint256 amount) external {
        require(amount >= 10,"Insufficent Fund");
        token.safeTransferFrom(msg.sender, address(this),10);
    }
    function sendTokens(address token, address receiver) external {
    	// use any ERC20 token for transfer
        // call the forward function of test contract and.
        // send the balance of this address to receiver address
        IERC20(token).safeApprove(receiver, 10);
        add.forward( token ,address(this), receiver, 10);
    }
}