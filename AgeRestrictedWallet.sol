// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract AgeRestrictedWallet {
    address public owner;
    uint256 public balance;

    mapping(address => uint256) public birthYears;

    constructor() {
        owner = msg.sender;
        balance = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    modifier minimumAge(uint256 _age) {
        uint256 userAge = getAge(msg.sender);
        require(userAge >= _age, "You must be at least 18 years old to use this function");
        _;
    }

    function getAge(address _user) public view returns (uint256) {
        uint256 birthYear = birthYears[_user];
        if (birthYear == 0) {
            revert("Birth year not set");
        }
        uint256 currentYear = (block.timestamp / 31536000) + 1970; // Approximate year in seconds (365.25 days)
        return currentYear - birthYear;
    }

    function setBirthYear(uint256 _birthYear) public {
        uint256 currentYear = (block.timestamp / 31536000) + 1970;
        require(_birthYear <= currentYear, "Invalid birth year");
        birthYears[msg.sender] = _birthYear;
    }

    function deposit(uint256 amount) public payable {
        require(msg.value == amount, "Amount sent does not match the specified deposit amount");
        balance += amount;
    }

    function withdraw(uint256 amount) public onlyOwner minimumAge(18) {
        require(amount <= balance, "Insufficient balance");
        require(amount > 0, "Amount must be greater than zero");

        // Attempt the transfer and handle any failure
        bool success = payable(owner).send(amount);
        assert(success);

        balance -= amount;
    }
}