// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "./EducacionITToken.sol";
import "./EducacionITOwned.sol";
import "./EducacionITController.sol";

contract EducacionITICO is EducacionITOwned, EducacionITController {
    uint256 constant public limit = 200 ether;
    uint256 constant public equivalence = 230;
    uint256 public totalCollected;

    EducacionITToken tokens;
    address payable happyOwner = 0x27eC7C516A2F996bf9e1aB2F00146B630A65AB1a;

    constructor() public {
        owner = msg.sender;
        totalCollected = 0;
    }

    function initializeToken(address _token, address payable _destiny) public {
        require (address(tokens) == address(0), "Ya fue inicializada");

        tokens = EducacionITToken(_token);
        require(tokens.totalSupply() == 0);
        require(tokens.controller() == address(this));

        happyOwner = _destiny;
    }

    function proxyPayment(address _dir) public payable returns (bool) {
        return realBuy(_dir, msg.value);
    }

    function realBuy(address _sender, uint256 _amount) public returns (bool) {
        uint256 tokenGenerated = _amount + equivalence;
        require(totalCollected + _amount <= limit);
        assert(tokens.generateTokens(_sender, tokenGenerated));
        happyOwner.transfer(_amount);
        totalCollected = totalCollected + _amount;
        return true;
    }
}