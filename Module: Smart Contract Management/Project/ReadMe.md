# Simple Storage Dapp

The SimpleStorage DApp is a decentralized application (DApp) that allows users to store and retrieve their favorite numbers along with associated names on the Ethereum blockchain. It consists of a Solidity contract and a React user interface.

## Contract Features

The Solidity contract (SimpleStorage.sol) provides the following features:

- Store: Users can store their favorite number by calling the store(uint256 \_favoriteNumber) function.
- Retrieve: The current stored favorite number can be retrieved using the retrieve() function.
- Add Person: Users can add a person's favorite number and name to the contract by calling the addPerson(string memory \_name, uint256 \_favoriteNumber) function.

## DApp Features

The React script (SimpleStorage.js) provides a user-friendly interface to interact with the SimpleStorage contract. The DApp offers the following features:

- Connect Wallet: Users can connect their Ethereum wallet (e.g., Metamask) to the DApp.
- Set Value: Users can set a new favorite number by entering a value and clicking the "Set Value" button.
- Get Current Value: The current stored favorite number is displayed by clicking the "Get Current Value" button.
- Add Person: Users can add a person's favorite number and name by entering the values and clicking the "Add information of person" button.
- Get Person: Users can retrieve a person's favorite number and name from the contract by entering the index and clicking the "Get information of person by index" button.

## Executing Program/Getting Started

1. Compile the SimpleStorage.sol and deploy it with remix.ethereum.org

```javascript

//SPDX-License-Identifier: MIT
pragma solidity 0.8.18; //Defining Version of Solidity

contract SimpleStorage {
    //Contract Intiation

    uint256 favoriteNumber; //Declaring varible type and varible

    //This will get intialized to 0 by default!

    struct People {
        //Declaring Struct People to have favoriteNumber & name assoicated
        uint256 favoriteNumber;
        string name;
    }

    People[] public people; //Declaring People array, so multiple number-name pair can be stored

    mapping(string => uint256) public nameToFavoriteNumber; //Mapping to find favorite number of people by name

    /*Store Function to store favoriteNumber,
    public Visibility Quantifier so it can accessible to anyone,*/

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // To retrieve the favorite Number Stored, Only recent favoriteNumber

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    //addPerson Function to store favoriteNumber-name pair

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name)); //Pushing favoriteNumber & Name to People array
        nameToFavoriteNumber[_name] = _favoriteNumber; //Mapping of favoriteNumber & Name
    }
}
```

2. Copy the Contract address and save it in SimpleStorage.js
3. Now create react app with following command.

```shell
npx create-react-app simplestorage
```

4. Now install ethers library using following command

```shell
cd simplestorage
npm install ethers@5.7.2
```

5. Now create a file in src folder of simplestorage folder and name it as SimpleStorage.js
6. Copy the below code and paste it there.

```javascript
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
```

7. Remove` <header>` boilerplate in App.js in src folder and replace it with `<SimpleStorage/>` and import SimpleStorage.
8. Now Create SimpleStorage_abi.json file in same src folder and copy ABI from compile tab in Remix IDE and paste it in file and save it.
9. Now start NPM Server and Your DApp will start.

```shell
npm start
```

10. Connect your wallet and start using app.

Ensure you have the necessary dependencies and libraries installed to run the DApp successfully.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
