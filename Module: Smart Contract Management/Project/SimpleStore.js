import React, { useState } from "react";
import { ethers } from "ethers";
import SimpleStorage_abi from "./SimpleStorage_abi.json";

const SimpleStorage = () => {
  const contractAddress = "0xcf10e95659F9FFBB1Eb3A595Ad86094B9A8FadB6";
  const [errorMessage, setErrorMessage] = useState(null); // State variable for error messages
  const [defaultAccount, setDefaultAccount] = useState(null); // State variable for the default account
  const [connButtonText, setConnButtonText] = useState("Connect Wallet"); // State variable for the connection button text

  const [currentContractVal, setCurrentContractVal] = useState(null); // State variable for the current contract value
  const [currentNameVal, setCurrentNameVal] = useState(null);
  const [currentFavNumVal, setCurrentFavNumVal] = useState(null);

  const [provider, setProvider] = useState(null); // State variable for the provider
  const [signer, setSigner] = useState(null); // State variable for the signer
  const [contract, setContract] = useState(null); // State variable for the contract instance

  // Function to handle connecting the wallet
  const connectWalletHandler = () => {
    if (window.ethereum) {
      window.ethereum
        .request({ method: "eth_requestAccounts" })
        .then((result) => {
          accountChangedHandler(result[0]); // Call the accountChangedHandler function with the new account
          setConnButtonText("Wallet Connected"); // Update the connection button text
        })
        .catch((error) => {
          setErrorMessage("Transaction rejected by the user."); // Set error message if the user rejects the transaction
          console.error(error);
        });
    } else {
      setErrorMessage("Need to install Metamask"); // Set error message if MetaMask is not installed
    }
  };

  // Function to handle changes in the connected account
  const accountChangedHandler = (newAccount) => {
    setDefaultAccount(newAccount); // Update the default account
    updateEthers(); // Call the updateEthers function to update the provider, signer, and contract
  };

  // Function to update the ethers provider, signer, and contract
  const updateEthers = () => {
    let tempProvider = new ethers.providers.Web3Provider(window.ethereum);
    setProvider(tempProvider); // Update the provider

    let tempSigner = tempProvider.getSigner();
    setSigner(tempSigner); // Update the signer

    let tempContract = new ethers.Contract(
      contractAddress,
      SimpleStorage_abi,
      tempSigner
    );
    setContract(tempContract); // Update the contract instance
  };

  // Function to retrieve the current value from the contract
  const getCurrentVal = async () => {
    try {
      const val = await contract.retrieve(); // Call the retrieve function of the contract
      setCurrentContractVal(val.toString()); // Update the current contract value
    } catch (error) {
      setErrorMessage("An error occurred while retrieving the current value."); // Set error message if an error occurs
      console.error(error);
    }
  };

  // Function to set a new value in the contract
  const setValue = async (event) => {
    event.preventDefault();
    try {
      await contract.store(event.target.setValue.value); // Call the store function of the contract with the new value
    } catch (error) {
      if (error.code === "ACTION_REJECTED") {
        setErrorMessage("Transaction rejected by the user."); // Set error message if the user rejects the transaction
      } else {
        setErrorMessage("An error occurred while setting the value."); // Set error message for other errors
        console.error(error);
      }
    }
  };

  // Function to add a person's favorite number and name to the contract
  const addPersonValue = async (event) => {
    event.preventDefault();
    try {
      await contract.addPerson(
        event.target.stringValueInput.value,
        event.target.uintValueInput.value
      ); // Call the addPerson function of the contract with the new values
    } catch (error) {
      setErrorMessage("An error occurred while adding a person."); // Set error message if an error occurs
      console.error(error);
    }
  };

  // Function to retrieve a person's favorite number and name from the contract
  const peopleValue = async (event) => {
    event.preventDefault();
    try {
      const result = await contract.people(event.target.getPeople.value); // Call the people function of the contract with the index
      const name = result[1].toString();
      const favNum = result[0].toString();
      setCurrentNameVal(name); // Update the current name value
      setCurrentFavNumVal(favNum); // Update the current favorite number value
    } catch (error) {
      setErrorMessage(
        "An error occurred while retrieving the person's information."
      ); // Set error message if an error occurs
      console.error(error);
    }
  };

  // The return statement that renders the HTML elements and components.
  // It includes a form to set a new value, a button to retrieve the current value,
  // and displays the current contract value and any error messages.
  return (
    <div>
      <h1>Simple Simple Storage</h1>
      <button onClick={connectWalletHandler}>{connButtonText}</button>
      <h3>Address: {defaultAccount}</h3>
      <h2>Set Value Below: </h2>
      <form onSubmit={setValue}>
        <input id="setValue" type="number" />
        <br />
        <button type={"submit"}> Set Value</button>
      </form>
      <br />
      <button onClick={getCurrentVal}>Get Current Value</button>
      <h3>The Current Value is: {currentContractVal}</h3>

      <form onSubmit={addPersonValue}>
        <input type="text" id="stringValueInput" placeholder="Enter Name" />
        <br />
        <input
          type="number"
          id="uintValueInput"
          placeholder="Enter Favorite Number"
        />
        <br />
        <button type={"submit"}>Add information of person</button>
      </form>
      <br />
      <form onSubmit={peopleValue}>
        <input id="getPeople" type="number" />
        <br />
        <button type={"submit"}> Get information of person by index</button>
        <h3>The Current Name is: {currentNameVal}</h3>
        <h3>The Current Favorite Number is: {currentFavNumVal}</h3>
      </form>
      <h3>Error if any: {errorMessage}</h3>
    </div>
  );
};

export default SimpleStorage;
