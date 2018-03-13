pragma solidity ^0.4.19;


contract Loan {
    address public owner;
    mapping(address => uint) public loans;

    event Taken(address indexed loaner, uint value);
    event Refund(address indexed loaner, uint value);

    modifier onlyOwner() {
        if (msg.sender != owner) {
            return;
        }
        _;
    }

    modifier onlyNotOwner() {
        if (msg.sender == owner) {
            return;
        }
        _;
    }

    function Loan() public{
        owner = msg.sender;
    }

    function take(uint _value)public onlyNotOwner() returns(bool) {
        loans[msg.sender] = _safeAdd(loans[msg.sender], _value);
        Taken(msg.sender, _value);
        return true;
    }

    function refunds(address _loaner, uint _value) public onlyOwner() returns(bool) {
        loans[_loaner] = _safeSub(loans[_loaner], _value);
        Refund(_loaner, _value);
        return true;
    }

    function _safeSub(uint _a, uint _b) internal pure returns(uint) {
        require(_b <= _a);
        return _a - _b;
    }

    function _safeAdd(uint _a, uint _b) internal pure returns(uint) {
        uint c = _a + _b;
        require(c >= _a);
        return c;
    }
}

