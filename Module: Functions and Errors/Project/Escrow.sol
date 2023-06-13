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