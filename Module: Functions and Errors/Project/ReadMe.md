# Escrow

The Escrow smart contract is a Solidity-based contract that facilitates the secure and transparent holding of funds between a buyer and a seller until certain conditions are met. It provides a trusted third-party arbiter to resolve any disputes that may arise during the transaction.

## Description

### Features

- Allows the creation of an escrow with a specified amount of funds.
- Enables the locking of the escrow by the buyer, seller, or arbiter.
- Supports releasing the funds to the seller upon successful completion of the transaction.
- Allows refunding the funds to the buyer if the transaction fails or disputes arise.
- Provides the option to cancel the escrow, refunding the funds to the appropriate party.
- Implements an invariant assertion function to ensure the contract's integrity.

### Contract Functions

1. Deploy the Escrow contract by providing the buyer, seller, arbiter addresses, and the amount of funds to be held in escrow.
2. Lock the escrow by calling the `lock()` function. This can be done by the buyer, seller, or arbiter.
3. If the transaction is successful, the buyer or arbiter can release the funds to the seller using the `releaseToSeller()` function.
4. If the transaction fails or disputes arise, the seller or arbiter can refund the funds to the buyer by calling the `refundToBuyer()` function.
5. Any involved party (buyer, seller, or arbiter) can cancel the escrow by calling the `cancelEscrow()` function. If the escrow is locked, the funds are refunded to the seller before canceling.
6. To verify the integrity of the escrow contract, you can use the `assertInvariant()` function.

**Note:** This is a high-level overview of the Escrow smart contract. For detailed information about the contract's functions, parameters, and usage, refer to the inline comments in the contract code.

## Getting Started

To use the Escrow contract, you need to follow these steps:

1. Deploy the contract to an Ethereum network by compiling and deploying the Escrow.sol file.
2. Interact with the deployed contract using a tool like Remix, Truffle, or web3.js.

## Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., Escrow.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Escrow {
    enum EscrowState { Created, Locked, Released } // Enum to represent different states of the escrow

    address payable public buyer; // Address of the buyer
    address payable public seller; // Address of the seller
    address public arbiter; // Address of the arbiter
    uint256 public amount; // Amount of funds held in escrow
    EscrowState public state; // Current state of the escrow

    constructor(address payable _buyer, address payable _seller, address _arbiter) payable {
        require(msg.value > 0, "Invalid escrow amount"); // Require that the escrow amount is greater than 0
        require(_buyer != address(0), "Invalid buyer address"); // Require a valid buyer address
        require(_seller != address(0), "Invalid seller address"); // Require a valid seller address
        require(_arbiter != address(0), "Invalid arbiter address"); // Require a valid arbiter address

        buyer = _buyer; // Set the buyer address
        seller = _seller; // Set the seller address
        arbiter = _arbiter; // Set the arbiter address
        amount = msg.value; // Set the escrow amount
        state = EscrowState.Created; // Set the initial state as Created
    }

    function lock() public {
        require(msg.sender == buyer || msg.sender == seller || msg.sender == arbiter, "Unauthorized"); // Require that the caller is the buyer, seller, or arbiter
        require(state == EscrowState.Created, "Invalid state transition"); // Require that the state is Created

        state = EscrowState.Locked; // Transition to the Locked state
    }

    function releaseToSeller() public {
        require(state == EscrowState.Locked, "Invalid state transition"); // Require that the state is Locked
        require(msg.sender == buyer || msg.sender == arbiter, "Unauthorized"); // Require that the caller is the buyer or arbiter

        seller.transfer(amount); // Transfer the funds to the seller
        state = EscrowState.Released; // Transition to the Released state
    }

    function refundToBuyer() public {
        require(state == EscrowState.Locked, "Invalid state transition"); // Require that the state is Locked
        require(msg.sender == seller || msg.sender == arbiter, "Unauthorized"); // Require that the caller is the seller or arbiter

        buyer.transfer(amount); // Refund the funds to the buyer
        state = EscrowState.Released; // Transition to the Released state
    }

    function cancelEscrow() public {
        require(state == EscrowState.Created || state == EscrowState.Locked, "Invalid state transition"); // Require that the state is Created or Locked
        require(msg.sender == buyer || msg.sender == seller || msg.sender == arbiter, "Unauthorized"); // Require that the caller is the buyer, seller, or arbiter

        if (state == EscrowState.Locked) {
            seller.transfer(amount); // Refund the funds to the seller before canceling the escrow
        }

        state = EscrowState.Released; // Transition to the Released state
        revert("Escrow canceled"); // Explicitly revert the transaction with a revert reason
    }

    function assertInvariant() public view {
        assert(state == EscrowState.Created || state == EscrowState.Locked || state == EscrowState.Released); // Assert that the state is one of the valid states
        assert(amount > 0); // Assert that the amount is greater than 0
        assert(buyer != address(0)); // Assert that the buyer address is valid
        assert(seller != address(0)); // Assert that the seller address is valid
        assert(arbiter != address(0)); // Assert that the arbiter address is valid
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile Escrow.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Escrow" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can perform the following actions:

To use this code:

- Specify the Ethereum addresses of the buyer, seller, and arbiter in the constructor.
- Define the desired amount of escrow funds.
- Deploy the Escrow contract.

Once the contract is deployed, you can perform the following actions:

1. Lock the escrow using lock().
2. Release the funds to the seller (if the transaction is successful) using releaseToSeller().
3. Refund the funds to the buyer (if the transaction fails or disputes arise) using refundToBuyer().
4. Cancel the escrow (optional) using cancelEscrow().
5. Verify the contract's integrity using assertInvariant().

Ensure that you have imported the Escrow.sol contract correctly in your project.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
