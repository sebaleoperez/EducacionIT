// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;
import "./EducacionITControlled.sol";

contract EducacionITToken is EducacionITControlled {
    mapping(address => uint256) public balances;
    uint256 public totalSupply;

    constructor() public {
        controller = msg.sender;
    }

    function balanceOf(address _owner) public view returns(uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        return realTransfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public 
        returns (bool success){
            return realTransfer(_from, _to, _value);
    }

    function realTransfer(address _from, address _to, uint256 _value) public 
        returns (bool) {
            if (_value == 0) return true;
            require(_to != address(0) && _to != address(this));

            uint256 previousBalanceFrom = balanceOf(_from);
            if (previousBalanceFrom < _value) {
                return false;
            }

            balances[_from] = balances[_from] - _value;

            uint256 previousBalanceTo = balanceOf(_to);
            require(previousBalanceTo + _value > previousBalanceTo);

            balances[_to] = balances[_to] + _value;
            emit Transfer(_from, _to, _value);
        }

        function generateTokens(address _owner, uint256 _amount) public onlyController
            returns (bool) {
                uint256 currentTotalSupply = totalSupply;
                require(currentTotalSupply + _amount >= totalSupply);

                uint256 previousBalanceTo = balanceOf(_owner);
                require(previousBalanceTo + _amount > previousBalanceTo);

                totalSupply = currentTotalSupply + _amount;
                balances[_owner] = previousBalanceTo + _amount;

                emit Transfer(address(0), _owner, _amount);

                return true;
        }

        event Transfer(address indexed from, address indexed to, uint256 value);
}