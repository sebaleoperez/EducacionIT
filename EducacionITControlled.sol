// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract EducacionITControlled {
    address public controller;

    constructor() public {
        controller = msg.sender;
    }

    modifier onlyController {
        require (msg.sender == controller);
        _;
    }

    function changeController(address _newController) 
        onlyController public {
            controller = _newController;
    }
}