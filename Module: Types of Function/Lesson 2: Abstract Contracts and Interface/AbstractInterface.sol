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