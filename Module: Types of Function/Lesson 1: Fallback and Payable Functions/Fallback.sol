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