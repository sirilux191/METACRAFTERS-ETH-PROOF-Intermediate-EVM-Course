# ERC20 Token Contract

This contract implements the ERC20 standard token functionality, allowing users to transfer and manage tokens on the Ethereum blockchain.

## Description

### Features

- Minting: The contract owner can mint new tokens and add them to their own account.
- Burning: Token holders can burn their tokens, reducing the total token supply.
- Token Transfer: Users can transfer tokens from their account to another account.
- Approvals: Users can approve a specific address to spend a certain amount of tokens on their behalf.
- Allowance: Users can check the amount of tokens approved for a specific address to spend on their behalf.
- Balance Check: Users can check the balance of tokens in their account.

### Contract Functions

- `transfer(address recipient, uint amount)`: Transfers tokens from the caller's account to the recipient account.
- `approve(address spender, uint amount)`: Approves the spender to spend a certain amount of tokens on behalf of the caller.
- `transferFrom(address sender, address recipient, uint amount)`: Transfers tokens from the spender's account to the recipient account.
- `mint(uint amount)`: Mints new tokens and adds them to the owner's account (only callable by the contract owner).
- `burn(uint amount)`: Burns tokens from the caller's account.
- `totalSupply()`: Returns the total token supply.
- `balanceOf(address account)`: Returns the token balance of the specified account.
- `allowance(address owner, address spender)`: Returns the remaining allowance of tokens that the spender is allowed to spend on behalf of the owner.

## Getting Started

To use the ERC20 contract, you need to follow these steps:

1. Deploy the contract to an Ethereum network by compiling and deploying the ERC20.sol file.
2. Interact with the deployed contract using a tool like Remix, Truffle, or web3.js.

## Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., ERC20.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Interface for ERC20 Token
interface IERC20 {
    // Returns the total token supply
    function totalSupply() external view returns (uint);

    // Returns the token balance of the specified account
    function balanceOf(address account) external view returns (uint);

    // Transfers tokens from the caller's account to the recipient account
    function transfer(address recipient, uint amount) external returns (bool);

    // Returns the remaining allowance of tokens that the spender is allowed to spend on behalf of the owner
    function allowance(address owner, address spender) external view returns (uint);

    // Approves the spender to spend a certain amount of tokens on behalf of the caller
    function approve(address spender, uint amount) external returns (bool);

    // Transfers tokens from the spender's account to the recipient account
    function transferFrom(address spender, address recipient, uint amount) external returns (bool);

    // Event emitted when tokens are transferred from one account to another
    event Transfer(address indexed from, address indexed to, uint amount);

    // Event emitted when the spender is approved to spend tokens on behalf of the owner
    event Approval(address indexed owner, address indexed spender, uint amount);
}

// ERC20 Token Contract
contract ERC20 is IERC20 {
    address public immutable owner; // Address of the contract owner
    uint public totalSupply; // Total token supply

    // Mapping to store the token balance of each account
    mapping (address => uint) public balanceOf;

    // Mapping to store the allowance of tokens from one account to another
    mapping (address => mapping (address => uint)) public allowance;

    // Contract constructor
    constructor() {
        owner = msg.sender; // Set the contract owner as the deployer of the contract
    }

    // Modifier to restrict functions to only the contract owner
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can execute this function");
        _;
    }

    string public constant name = "SIRILUX"; // Token name
    string public constant symbol = "SIRI"; // Token symbol
    uint8 public constant decimals = 18; // Token decimal places

    // Transfers tokens from the caller's account to the recipient account
    function transfer(address recipient, uint amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient Balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Approves the spender to spend a certain amount of tokens on behalf of the caller
    function approve(address spender, uint amount) external returns (bool) {
        require(amount > 0, "Approval amount must be greater than zero");
        allowance[msg.sender][spender] += amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // Transfers tokens from the spender's account to the recipient account
    function transferFrom(address sender, address recipient, uint amount) external returns (bool) {
        require(balanceOf[sender] >= amount, "Insufficient Balance");
        require(allowance[sender][msg.sender] >= amount, "Less approval to spend tokens");
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }

    // Mints new tokens and adds them to the owner's account
    function mint(uint amount) external onlyOwner {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    // Burns tokens from the caller's account
    function burn(uint amount) external {
        require(amount > 0, "Amount should not be zero");
        require(balanceOf[msg.sender] >= amount, "Insufficient Balance");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;

        emit Transfer(msg.sender, address(0), amount);
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile ERC20.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "ERC20" contract from the dropdown menu, and then click on the "Deploy" button.

After deploying the contract, you can perform the following actions:

1. Mint Tokens: The contract owner can mint new tokens by calling the `mint` function, specifying the desired amount.
2. Transfer Tokens: Token holders can transfer their tokens to another account by calling the `transfer` function, providing the recipient's address and the amount to be transferred.
3. Approve Spender: Token holders can approve a specific address to spend tokens on their behalf by calling the `approve` function, specifying the spender's address and the approved amount.
4. Transfer From: Once approved, the approved spender can transfer tokens from the token holder's account to another account by calling the `transferFrom` function, providing the sender's address, recipient's address, and the amount.
5. Check Balance and Allowance: Users can check their token balance by calling the `balanceOf` function, passing their account address. They can also check the remaining allowance by calling the `allowance` function, providing the owner's address and the spender's address.
6. Burn Tokens: Token holders can burn their tokens by calling the `burn` function, specifying the amount of tokens to burn.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
