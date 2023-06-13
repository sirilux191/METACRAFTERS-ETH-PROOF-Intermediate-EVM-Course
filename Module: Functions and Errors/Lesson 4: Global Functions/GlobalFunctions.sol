// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract GlobalFunctions {
    uint256 public balance = 0;     
    address public owner;          

    constructor() {
        owner = msg.sender;         //Initializing msg.sender as owner
    }

    modifier onlyOwner() {          //Modifier to give access to owner only
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    //Function to change owner of contract
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    //Function to retrieve timestamp, block number and random number
    function getBlockData() public view returns (uint, uint, uint) {
        return(block.timestamp, block.number, block.prevrandao);
    }

    //Function to get address of this contract
    function getContractAddress() public view returns (address) {
        return address(this);
    }

    function Deposit() public payable onlyOwner{    //Function to deposit funds
        balance += msg.value;                       //Updating value of balance
    }

    //Function to withdraw funds
    function Withdraw(uint256 amount, address payable recipient) public onlyOwner{
        require(balance >= amount, "You don't have enough balance");                      //Checks if balance is availble
        require(recipient != address(0), "You are transferring amount to zero address");  //Prevents from sending ether to zero address
        balance -= amount;                                                                //Updating value of balance
        payable(recipient).transfer(amount);                                              //Transferring amount to recipient address
    }
}