pragma solidity ^0.5.0;

contract Tether {

    string public name = 'Tether';
    string public symbol = 'USDT';
    uint256 public totalSupply = 100000000;
    uint8 public decimals = 18;

    event Transfer(
     address indexed _from,
     address indexed _to,
        uint256 _value
    );

    event Approve (
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public  balanceOf;
    mapping (address => mapping(address => uint256)) public  allowance;

    constructor(){
    balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        require(balanceOf[msg.sender] >= _value, "insufficient balance to transfer");
        balanceOf[msg.sender] -=_value;
        balanceOf[msg.sender] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns(bool success){
      allowance[msg.sender][_spender] = _value;
        emit  Approve(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(_value <= balanceOf[_from] >= _value, "insufficient balance to transfer");
        require(_value <= allowance[_from][msg.sender] >= _value, "insufficient balance to transfer");
        balanceOf[_from] -=_value;
        balanceOf[_to] += _value;
        allowance[msg.sender][_from] -= value;
        emit Transfer(msg.sender, _to, _value);

    }

}
