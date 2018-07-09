pragma solidity ^0.4.18;

contract Ownable { // Ownable - вспомогательный класс для проверки на то, что метод вызван владельцем данного контракта (т.е. тем пользователем, который этот контракт запустил)

    address public owner; // Здесь храним адрес владельца

    constructor() public { // Конструктор - делаем владельцем того, кто создал контракт
        owner = msg.sender;
    }
    
    modifier onlyOwner() { // Проверка на то, что только владелец может вызывать функцию (к которой применен этот модификатор)
    require(msg.sender == owner);
    _;
    }

    function transferOwnership(address newOwner) public onlyOwner { // Смена владельца контракта
        owner = newOwner;
    }

}



contract AplexCoin is Ownable { // Код контракта (класса) владения монетами пользователями системы

    mapping (address => uint256) balances; // таблица балансов
    uint256 public totalSupply; // сколько токенов выпущено
    uint256 public constant decimal = 18; // количество знаков после запятой (чтобы не писать 10^18, когда мы выпускаем лишь один токен)

    constructor() public { // Конструктор

    }

    function transfer(address _to, uint256 _value) public returns(bool success){ // Передача токенов от пользователя, вызвавшего контракт к другому пользователю (_to) в количестве _value
        if(balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]){
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            return true;
        }
        return false;
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool success) { // Передача токенов от _from к _to в количестве _value
        if(balances[_from] >= _value && balances[_to] + _value >= balances[_to]) {
            balances[_from] -= _value; 
            balances[_to] += _value;
        return true;
        } 
        return false;
    }

    function balanceOf(address _owner) public view returns (uint256 balance){ // Узнаем баланс пользователя по его адресу
        return balances[_owner];
    }

    function mint(address _to, uint256 _value) public onlyOwner { // Чеканка новых токенов
        assert(totalSupply + _value >= totalSupply && balances[_to] + _value >= balances[_to]);
        totalSupply += _value;
        balances[_to] += _value;
    }

    function () public payable { // Внесение денег в нашу систему (fallback функция)
        uint256 tokensToMint;
        tokensToMint = msg.value;
        mint(msg.sender, tokensToMint);
    }

    function withDrawal() public { // Вывод средств с кошелька
    owner.transfer(address(this).balance);
    }

}
