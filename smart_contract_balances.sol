pragma solidity ^0.4.18;

contract Ownable { // Ownable - ��������������� ����� ��� �������� �� ��, ��� ����� ������ ���������� ������� ��������� (�.�. ��� �������������, ������� ���� �������� ��������)
    
    address public owner; // ����� ������ ����� ���������
    
    constructor() public { // ����������� - ������ ���������� ����, ��� ������ ��������
        owner = msg.sender;
    }

    modifier onlyOwner() { // �������� �� ��, ��� ������ �������� ����� �������� ������� (� ������� �������� ���� �����������)
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner { // ����� ��������� ���������
        owner = newOwner;
    }
    
}



contract AplexCoin is Ownable { // ��� ��������� (������) �������� �������� �������������� �������
   
    mapping (address => uint256) balances; // ������� ��������
    uint256 public totalSupply; // ������� ������� ��������
    uint256 public constant decimal = 18; // ���������� ������ ����� ������� (����� �� ������ 10^18, ����� �� ��������� ���� ���� �����)
   
    constructor() public { // �����������
       
    }
    
    function transfer(address _to, uint256 _value) public returns(bool success){ // �������� ������� �� ������������, ���������� �������� � ������� ������������ (_to) � ���������� _value
        if(balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]){
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            return true;
        }
        return false;
    }
    
    function transferFrom(address _from, address _to, uint _value) public returns (bool success) { // �������� ������� �� _from � _to � ���������� _value
        if(balances[_from] >= _value && balances[_to] + _value >= balances[_to]) {
            balances[_from] -= _value; 
            balances[_to] += _value;
            return true;
        } 
        return false;
    }
   
    function balanceOf(address _owner) public view returns (uint256 balance){ // ������ ������ ������������ �� ��� ������
        return balances[_owner];
    }
   
    function mint(address _to, uint256 _value) public onlyOwner { // ������� ����� �������
        assert(totalSupply + _value >= totalSupply && balances[_to] + _value >= balances[_to]);
        totalSupply += _value;
        balances[_to] += _value;
    }
   
    function () public payable { // �������� ����� � ���� ������� (fallback �������)
        uint256 tokensToMint;
        tokensToMint = msg.value;
        mint(msg.sender, tokensToMint);
    }
    
    function withDrawal() public { // ����� ������� � ��������
        owner.transfer(address(this).balance);
    }
   
}
