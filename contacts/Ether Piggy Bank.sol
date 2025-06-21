// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Ether Piggy Bank
 * @dev A smart contract that allows users to lock Ether until a specified unlock time.
 */
contract EtherPiggyBank {
    address public owner;
    uint256 public unlockTime;

    constructor(uint256 _unlockTime) payable {
        require(_unlockTime > block.timestamp, "Unlock time should be in the future");
        owner = msg.sender;
        unlockTime = _unlockTime;
    }

    // Deposit more Ether (optional)
    receive() external payable {}

    // View balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Withdraw funds after unlock time
    function withdraw() external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(block.timestamp >= unlockTime, "Cannot withdraw before unlock time");
        payable(owner).transfer(address(this).balance);
    }
}