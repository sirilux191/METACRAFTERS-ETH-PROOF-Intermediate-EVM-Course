# GlobalFunctions

This Solidity smart contract, called GlobalFunctions, provides global functions and features such as ownership management, depositing and withdrawing funds, retrieving block data, and accessing the contract address.

## Description

---

The GlobalFunctions contract is designed to provide useful global functions and capabilities for Ethereum smart contracts. The key features of this contract include:

- Ownership management: The contract owner has special privileges and can change the ownership to another address.
- Block data retrieval: Provides functions to retrieve block-related data such as timestamp, block number, and random value.
- Contract address retrieval: Allows accessing the contract address from within the contract.
- Deposit and withdraw funds: Supports depositing and withdrawing funds to and from the contract, with only the contract owner having permission to perform these actions.

### Contract Functions

- `changeOwner(address _newOwner)`: Allows the contract owner to change the ownership of the contract to a new address.
- `getBlockData()`: Returns block-related data including timestamp, block number, and random value.
- `getContractAddress()`: Retrieves the address of the deployed contract.
- `deposit()`: Function to deposit funds into the contract (available only to the contract owner).
- `withdraw(uint256 amount, address payable recipient)`: Allows the contract owner to withdraw a specific amount of funds to the specified recipient address.

## Getting Started

---

To use the GlobalFunctions contract, you need to follow these steps:

1. Deploy the contract to an Ethereum network by compiling and deploying the GlobalFunctions.sol file.
2. Interact with the deployed contract using a tool like Remix, Truffle, or web3.js.

### Executing program

---

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., GlobalFunctions.sol). Copy and paste the following code into the file:

```javascript
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

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile GlobalFunctions.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "GlobalFunctions" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can perform the following actions:

- Call the `changeOwner` function to change the ownership of the contract to a new address.
- Use the `getBlockData` function to retrieve block-related data.
- Get the contract address by calling the `getContractAddress` function.
- Deposit funds to the contract using the `deposit` function (only available to the contract owner).
- Withdraw funds from the contract to a specified recipient address using the `withdraw` function (only available to the contract owner).

Ensure that you have the necessary permissions and provide the required parameters when interacting with the contract functions.

## Authors

---

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

---

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
