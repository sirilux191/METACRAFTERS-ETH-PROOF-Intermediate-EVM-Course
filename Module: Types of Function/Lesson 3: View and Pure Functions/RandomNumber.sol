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