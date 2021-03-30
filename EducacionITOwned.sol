// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract EducacionITOwned {
    address public owner;
    address public newOwner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require (msg.sender == owner);
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
    }

    function acceptOwnership() public {
        if (msg.sender == newOwner)
        {
            owner = newOwner;
        }
    }
}