// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract PersonalSavingsBank {

    uint256 public balance = 0;                     //initializes balance to zero
    address public immutable admin;                 //to check admin of contract

    constructor() {
        admin = msg.sender;                         //initializes creater as admin of contract
    }

    modifier onlyAdmin {                            //modifier, so only admin can call function
        require(msg.sender == admin, "Only admin of this contract can use this function/feature");
        _;
    }

    function deposit() public payable onlyAdmin{    //function to deposit funds
        balance += msg.value;                       //updating value of balance
    }

    function withdraw(uint256 amount, address payable recipient) public onlyAdmin{
        require(balance >= amount, "You don't have enough balance");                      //checks if balance is availble
        require(recipient != address(0), "You are transferring amount to zero address");  //prevents from sending ether to zero address
        balance -= amount;                                                                //updating value of balance
        payable(recipient).transfer(amount);                                              //transferring amount to recipient address
    }

}