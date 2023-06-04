# Personal Savings Bank

A simple smart contract implemented in Solidity for a personal savings bank. This contract allows the admin to deposit and withdraw funds.

## Features

- Deposit funds: The admin can deposit funds into the contract.
- Withdraw funds: The admin can withdraw funds from the contract to a specified recipient.

## Usage

1. Deposit funds:

   - Call the `deposit()` function, specifying the amount of funds to deposit.
   - Only the admin can deposit funds.

2. Withdraw funds:
   - Call the `withdraw()` function, specifying the amount of funds to withdraw and the recipient address.
   - Only the admin can withdraw funds.
   - The contract must have a sufficient balance to cover the withdrawal amount.

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., PersonalSavingsBank.sol). Copy and paste the following code into the file:

```javascript
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
```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile PersonalSavingsBank.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "PersonalSavingsBank" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the deposit function.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the [MIT License](LICENSE.md).
