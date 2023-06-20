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