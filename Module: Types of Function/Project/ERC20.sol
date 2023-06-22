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
