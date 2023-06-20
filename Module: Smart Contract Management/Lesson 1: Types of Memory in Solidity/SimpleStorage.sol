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