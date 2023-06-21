# View & Pure Function

The RandnomNumber contract is a Solidity smart contract that generates a random number by performing a calculation using a special number and the current block timestamp. It demonstrates the usage of view and pure functions in Solidity.

### Features

- **Random Number Generation**: The contract provides a function to generate a random number based on a special number and the current block timestamp.

### Contract Functions

1. `generateRandomNumber() public view returns(uint256)`

This function is used to generate a random number by performing a calculation using the special number and the current block timestamp.

- **Returns**:
  - `uint256`: The generated random number.

2. `calculate(uint256 x, uint256 y) private pure returns(uint256)`

This function is a helper function that performs a calculation by multiplying two parameters passed to it.

- **Parameters**:
  - `x`: The first parameter for the calculation.
  - `y`: The second parameter for the calculation.
- **Returns**:
  - `uint256`: The result of the calculation.

## Getting Started

To use the RandnomNumber contract, you need to follow these steps:

1. Deploy the contract to an Ethereum network by compiling and deploying the RandnomNumber.sol file.
2. Interact with the deployed contract using a tool like Remix, Truffle, or web3.js.

## Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., RandnomNumber.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract RandnomNumber{

    //Special Number to add randomness with block.timestamp
    uint256 private constant specialNumber =  78609955645099;

    //Function which uses view and returns random number
    function generateRandomNumber() public view returns(uint256){
        return (calculate(specialNumber, block.timestamp));
    }

    //Function which uses pure and returns calculation of two parameters passed
    function calculate(uint256 x, uint256 y) private pure returns(uint256){
        return x* y;
    }

}
```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile RandnomNumber.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "RandnomNumber" contract from the dropdown menu, and then click on the "Deploy" button.

After deploying the RandnomNumber contract, you can perform the following action:

1. Call the `generateRandomNumber()` function to generate a random number.

The generated random number will be calculated based on the special number and the current block timestamp, providing a degree of randomness.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
