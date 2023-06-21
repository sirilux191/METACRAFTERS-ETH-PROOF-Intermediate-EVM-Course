# Abstract & Interface

The Operation contract is a Solidity smart contract that implements the data store functionality and increment/decrement operations. It demonstrates the usage of an interface and an abstract contract in Solidity.

## Description

### Features

- **Data Storage**: The contract provides a function to store a value and retrieve the stored value.

- **Increment and Decrement**: The contract allows incrementing and decrementing a number stored in the contract.

- **Interface**: The contract implements the IStore interface, which defines the store and retrieve functions that must be implemented by contracts that adhere to the interface.

- **Abstract Contract**: The contract inherits from the Increment abstract contract, which defines the increment function as abstract and provides a default implementation for the decrement function. Contracts that inherit from Increment must implement the increment function.

### Contract Functions

- store(uint256 num): Allows storing a value by assigning it to the Number state variable.

- retrieve() view returns (uint): Retrieves the stored value from the Number state variable.

- increment(): Increments the value stored in the Number state variable by one.

- decrement(): Decrements the value stored in the Number state variable by one.

## Getting Started

To use the Operation contract, you need to follow these steps:

1. Deploy the contract to an Ethereum network by compiling and deploying the AbstractInterface.sol file.
2. Interact with the deployed contract using a tool like Remix, Truffle, or web3.js.

## Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., AbstractInterface.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Interface for a data store contract
interface IStore {
    function store(uint256) external;       // Function to store a value
    function retrieve() external view returns (uint);    // Function to retrieve a value
}

// Abstract contract for incrementing a number
abstract contract Increment {
    uint256 favoriteNum;    // State variable to hold the favorite number

    // Abstract function for incrementing the number
    function increment() virtual external;

    // Default implementation for decrementing the number
    function decrement() virtual external {
        favoriteNum--;
    }
}

// Contract that implements the data store and increment functionality
contract Operation is IStore, Increment {
    uint256 Number;     // State variable to hold the number

    // Implementation of the store function from IStore interface
    function store(uint256 num) external {
        Number = num;
    }

    // Implementation of the retrieve function from IStore interface
    function retrieve() external view returns (uint) {
        return Number;
    }

    // Implementation of the increment function from Increment abstract contract
    function increment() override external {
        Number++;
    }

    // Implementation of the decrement function from Increment abstract contract
    function decrement() override  external {
        Number--;
    }
}
```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile AbstractInterface.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Operation" contract from the dropdown menu, and then click on the "Deploy" button.

After deploying the Operation contract, you can perform the following actions:

1. Store a value using the store(uint256 num) function.
2. Retrieve the stored value using the retrieve() function.
3. Increment the stored value by calling the increment() function.
4. Decrement the stored value by calling the decrement() function.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
