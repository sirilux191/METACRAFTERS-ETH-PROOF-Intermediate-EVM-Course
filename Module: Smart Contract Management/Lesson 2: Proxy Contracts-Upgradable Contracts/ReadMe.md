# ERC20Proxy

These contracts provide a complete ERC20 token implementation. The MyERC20Token contract allows for the creation and management of custom ERC20 tokens with features such as transfers, approvals, and allowances. The ERC20Proxy contract acts as a proxy, enabling the deployment of multiple instances of the MyERC20Token contract with different configurations, allowing users to create and manage multiple ERC20 tokens efficiently.

# MyERC20Token

## Description

MyERC20Token is an ERC20 token contract that represents a fungible token with customizable parameters such as name, symbol, and decimals.

### Features

- Token Creation: Deploy an instance of the contract to create a new ERC20 token.
- Token Transfer: Transfer tokens from one address to another, updating the sender's and recipient's balances accordingly.
- Token Approval: Set an allowance for a specific spender address to spend a certain amount of tokens on behalf of the owner.
- Token TransferFrom: Allow the approved spender to transfer tokens on behalf of the token owner.

### Contract Functions

- constructor: Initializes the token by setting its name, symbol, decimals, and initial supply.
- transfer: Transfers a specified amount of tokens from the sender's address to a recipient address.
- approve: Approves a spender to spend a specified amount of tokens on behalf of the owner.
- transferFrom: Transfers tokens from the from address to the to address on behalf of the spender.

# ERC20Proxy

## Description

ERC20Proxy is a contract that acts as a proxy for deploying multiple instances of the MyERC20Token contract.

### Features

- Instance Creation: Deploy multiple instances of the MyERC20Token contract with different token configurations.
- Instance Count: Get the total number of deployed instances.
- Instance Access: Get the instance address at a specific index.

### Contract Functions

- createInstance: Deploys a new instance of the MyERC20Token contract with the provided token parameters and returns the instance address.
- getInstanceCount: Returns the total number of deployed instances.
- getInstanceAtIndex: Returns the instance address at the specified index.

## Getting Started

To use the MyERC20Token and ERC20 Proxy contract, you need to follow these steps:

1. Deploy the contract to an Ethereum network by compiling and deploying the SimpleStorage.sol file.
2. Interact with the deployed contract using a tool like Remix, Truffle, or web3.js.

## Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., ERC20Proxy.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract MyERC20Token {
    string public name; // Name of the ERC20 token
    string public symbol; // Symbol of the ERC20 token
    uint8 public decimals; // Decimal places for the token
    uint256 public totalSupply; // Total supply of the token
    mapping(address => uint256) public balanceOf; // Mapping of addresses to token balances
    mapping(address => mapping(address => uint256)) public allowance; // Mapping of addresses to allowances

    event Transfer(address indexed from, address indexed to, uint256 value); // Event emitted when tokens are transferred
    event Approval(address indexed owner, address indexed spender, uint256 value); // Event emitted when an allowance is set

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * (10**uint256(_decimals)); // Calculate the total supply based on decimals
        balanceOf[msg.sender] = totalSupply; // Assign the total supply to the contract deployer's balance
    }

    function transfer(address _to, uint256 _value) external returns (bool) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); // Check if the sender has sufficient balance
        balanceOf[msg.sender] -= _value; // Subtract the transferred amount from the sender's balance
        balanceOf[_to] += _value; // Add the transferred amount to the recipient's balance
        emit Transfer(msg.sender, _to, _value); // Emit the Transfer event
        return true;
    }

    function approve(address _spender, uint256 _value) external returns (bool) {
        allowance[msg.sender][_spender] = _value; // Set the allowance for spender
        emit Approval(msg.sender, _spender, _value); // Emit the Approval event
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool) {
        require(balanceOf[_from] >= _value, "Insufficient balance"); // Check if the sender has sufficient balance
        require(allowance[_from][msg.sender] >= _value, "Not allowed to spend"); // Check if the spender is allowed to spend the specified amount
        balanceOf[_from] -= _value; // Subtract the transferred amount from the sender's balance
        balanceOf[_to] += _value; // Add the transferred amount to the recipient's balance
        allowance[_from][msg.sender] -= _value; // Decrease the spender's allowance by the transferred amount
        emit Transfer(_from, _to, _value); // Emit the Transfer event
        return true;
    }
}

contract ERC20Proxy {

    address[] public instances; // Array of deployed instance contracts

    event ContractCreated(address indexed instance); // Event emitted when a new instance contract is created

    function createInstance(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) external returns (address) {
        address instance = address(new MyERC20Token(_name, _symbol, _decimals, _initialSupply)); // Deploy a new instance of MyERC20Token contract
        instances.push(instance); // Add the new instance address to the instances array
        emit ContractCreated(instance); // Emit the ContractCreated event
        return instance; // Return the new instance address
    }

    function getInstanceCount() external view returns (uint256) {
        return instances.length; // Return the count of deployed instances
    }

    function getInstanceAtIndex(uint256 _index) external view returns (address) {
        require(_index < instances.length, "Invalid index"); // Check if the index is within bounds
        return instances[_index]; // Return the instance address at the specified index
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile ERC20TokenProxy.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "ERC20Proxy" contract from the dropdown menu, and then click on the "Deploy" button.

To deploy these contracts, follow these steps:

- Deploy the ERC20Proxy contract
- Call the createInstance function of the ERC20Proxy contract to deploy new instances of the MyERC20Token contract.
- Interact with the deployed token instances by calling their respective functions, such as transfer, approve, and transferFrom.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
