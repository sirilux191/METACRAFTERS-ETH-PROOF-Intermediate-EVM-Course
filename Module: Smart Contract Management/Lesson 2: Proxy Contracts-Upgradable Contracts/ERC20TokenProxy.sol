// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import "./ERC20Token.sol";
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
