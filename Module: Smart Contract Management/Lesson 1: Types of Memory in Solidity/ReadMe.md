# SimpleStorage

The SimpleStorage smart contract is a basic example of a Solidity contract that allows users to store and retrieve a favorite number and associate it with a name. It also provides the functionality to store multiple favorite number and name pairs.

## Description

### Features

- Store and retrieve a favorite number
- Store multiple favorite number and name pairs
- Associate a favorite number with a specific name
- Access favorite numbers by name

### Contract Functions

1. `store(uint256 _favoriteNumber)`: Allows the user to store their favorite number. The provided favorite number will be assigned to the favoriteNumber variable of the contract.

2. `retrieve()`: Retrieves the most recent favorite number that was stored.

3. `addPerson(string memory _name, uint256 _favoriteNumber)`: Adds a new person to the contract's people array. This function accepts a name and a favorite number as parameters, creates a new People struct instance with the provided values, and adds it to the array. Additionally, it maps the name to the favorite number in the nameToFavoriteNumber mapping.

**Note:** This is a high-level overview of the SimpleStorage smart contract. For detailed information about the contract's functions, parameters, and usage, refer to the inline comments in the contract code.

## Getting Started

To use the SimpleStorage contract, you need to follow these steps:

1. Deploy the contract to an Ethereum network by compiling and deploying the SimpleStorage.sol file.
2. Interact with the deployed contract using a tool like Remix, Truffle, or web3.js.

## Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., SimpleStorage.sol). Copy and paste the following code into the file:

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

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile SimpleStorage.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "SimpleStorage" contract from the dropdown menu, and then click on the "Deploy" button.

After deploying the SimpleStorage contract, the following actions can be performed:

- Call the store function to store a favorite number.
- Call the retrieve function to retrieve the most recent favorite number stored.
- Call the addPerson function to add a person's favorite number and name to the contract.
- Access the people array to view the stored favorite number and name pairs.
- Use the nameToFavoriteNumber mapping to retrieve a favorite number by providing a name

Ensure that you have imported the SimpleStorage.sol contract correctly in your project.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
