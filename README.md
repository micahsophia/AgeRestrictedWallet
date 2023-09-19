# AgeRestrictedWallet Smart Contract

This repository contains a Solidity smart contract called AgeRestrictedWallet that implements the require(), assert(), and revert() statements to manage a wallet with age restrictions. This README provides an overview of the contract and how to use it.

## Overview

The AgeRestrictedWallet contract is designed to manage a wallet with the following features:

- Age restriction: Users must be at least 18 years old to perform certain actions.
- Ownership control: Only the contract owner can perform certain actions.
- Deposit and withdrawal: Users can deposit funds into the wallet and the owner can withdraw funds.

The contract uses require(), assert(), and revert() statements to ensure the security and validity of operations.

## Contract Functions

### `constructor()`

- Initializes the contract by setting the owner to the address that deployed the contract and the initial balance to 0.

### onlyOwner Modifier

- A custom modifier that checks whether the caller of a function is the contract owner. If not, it raises a require() error.

### minimumAge(uint256 _age) Modifier

- A custom modifier that checks whether the caller's age is at least 18 years. It calculates the user's age using the getAge() function and raises a require() error if the requirement is not met.

### getAge(address _user)

- Returns the age of a user based on their birth year stored in the birthYears mapping. If the birth year is not set, it raises a revert() error.

### setBirthYear(uint256 _birthYear)

- Allows users to set their birth year. It checks if the provided birth year is valid (not in the future) and updates the birthYears mapping.

### deposit(uint256 amount)

- Allows users to deposit funds into the wallet. It checks if the sent amount matches the specified deposit amount and increases the wallet's balance.

### withdraw(uint256 amount)

- Allows the contract owner to withdraw funds from the wallet. It applies the onlyOwner and minimumAge modifiers to ensure the caller is the owner and at least 18 years old. It also checks the withdrawal amount and attempts to transfer the funds to the owner, using assert() to handle any transfer failure.

## How to Use

1. Deploy the AgeRestrictedWallet contract to an Ethereum network using a development environment or Remix IDE.
2. Interact with the contract through a wallet or Remix IDE's built-in interface.
3. Set your birth year using the setBirthYear(uint256 _birthYear) function.
4. Deposit funds into the wallet using the deposit(uint256 amount) function.
5. Withdraw funds as the owner using the withdraw(uint256 amount) function, ensuring you meet the age and ownership requirements.
6. Explore and experiment with the contract's functionality, including error handling using require(), assert(), and revert().

## License

This smart contract is provided under the MIT License. Feel free to use, modify, and distribute it according to the terms of the license.
