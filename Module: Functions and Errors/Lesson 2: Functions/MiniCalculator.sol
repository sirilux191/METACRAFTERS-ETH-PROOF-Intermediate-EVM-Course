// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract MiniCalculator {
    uint16 private n = 786;          //Fixed input to generate random number
    address public immutable owner;  //Public varible to check owner of contract
    uint256 public balance;          //Public varible to check balance of contract

    constructor() {
        owner = msg.sender;          //Initiliazes creater as owner of contract
    }

    modifier onlyOwner {              //Modifier for withdraw function
        require(msg.sender == owner, "Only Owner can withdraw donations");
        _;
    }

    function Donate() public payable {     //Function to accept Donations
        balance += msg.value;
    }

    function Withdraw(uint256 amount, address payable recipient) public onlyOwner{
        require(balance >= amount, "You don't have enough balance");                      //Checks if balance is available
        require(recipient != address(0), "You are transferring amount to zero address");  //Prevents from sending ether to zero address
        balance -= amount;                                                                //Updating value of balance
        payable(recipient).transfer(amount);                                              //Transferring amount to recipient address
    }

    function GenerateRandomNumber(uint256 x) external view returns (uint256){             //Function to generate random number
        return( x * random());
    }

    function random() internal view returns(uint256){     //Function to generate pseudo random number using timestamp of block
        return (n * block.timestamp);
    }

    function Add(uint256 a, uint256 b) public pure returns (uint256){  //Function for addition of two input positive numbers
        return (a+b);
    }

}