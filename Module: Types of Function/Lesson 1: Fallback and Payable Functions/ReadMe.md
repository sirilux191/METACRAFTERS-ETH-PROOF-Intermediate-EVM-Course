# Fallback and Payable Example

The FallbackExample contract showcases the fallback functions and their behavior in different scenarios. Below is a detailed description of the contract's features and its functions:

## Description

### Features

- Fallback Functions: The contract demonstrates the usage of two types of fallback functions: receive() and fallback(). These functions are executed when a function is not found in the contract and when specific conditions are met.

- Contract State: The contract contains a state variable called result of type uint256, which holds the result of operations performed within the contract.

### Contract Functions

1. The `add` function takes two uint256 parameters, x and y, and adds them together. The result is stored in the result variable.

2. The `receive` function is a special fallback function that is executed when the contract receives ether (i.e., when someone sends ether to the contract's address) or function which is not present is called and msg.data is also not present. In this contract, the receive function sets the result variable to 1.

3. The `fallback` function is a special fallback function that is executed when the contract receives ether (i.e., when someone sends ether to the contract's address) or function which is not present is called and msg.data is present. In this contract, the receive function sets the result variable to 2.

## Getting Started

To use the FallbackExample contract, you need to follow these steps:

1. Deploy the contract to an Ethereum network by compiling and deploying the Fallback.sol file.
2. Interact with the deployed contract using a tool like Remix, Truffle, or web3.js.

## Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., Fallback.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract FallbackExample{

    uint256 public result;

    //Function to add two numbers
    function add(uint256 x, uint256 y) external {
        result = x + y;
    }


    //Executed when function is not present and msg.data is also not present
    receive() external payable {
        result = 1;
    }

    //Executed when function is not present and msg.data is present
    //Also executed when function is not present and msg.data and receive() both are not present
    fallback() external payable {
        result = 2;
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile Fallback.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "FallbackExample" contract from the dropdown menu, and then click on the "Deploy" button.

After deploying the FallbackExample contract, the following actions can be performed:

- Addition of two positive numbers.
- Sending ether directly to contract address.
- Calling any arbitary function which is not present.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
