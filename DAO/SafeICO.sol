
pragma solidity ^0.4.11;


// Объявляем интерфейс
interface DAOToken {
    function transfer(address _to, uint256 _value);

}

// Объявляем контракт
contract SafeICO {

    // Объявялем переменную для токена
    DAOToken public token;
    // Объявляем переменную цены токена
    uint public buyPrice;
    // Объявляем переменную количества токенов (эфиры/стоимость токена)
    uint public tokens;

    address public owner;
    
    address public daoContract; /адрес DAO контракта

    // Функция инициализации
    function SafeICO(DAOToken _token) public {
        // Присваиваем токен
        token = _token;
        owner = msg.sender;
        buyPrice = 10 finney;

    }

    modifier onlyOwner () {
        require (msg.sender == owner);
        _;
    }

    // Функция для прямой отправки эфиров на контракт
    function () payable public {
        _buy(msg.sender, msg.value);
    }

    // Вызываемая функция для отправки эфиров на контракт, возвращающая количество купленных токенов
    function buy() payable public returns (uint){
        return _buy (msg.sender, msg.value);
    }

    // Внутренняя функция покупки токенов, возвращает число купленных токенов
    function _buy(address _sender, uint256 _amount) internal returns (uint){
        // Рассчитываем стоимость
        tokens = _amount / buyPrice;
        // Отправляем токены с помощью вызова метода токена
        token.transfer(_sender, tokens);
        // Возвращаем значение
        return toke ns;
    }
     // прописываем адрес DAO контракта, после деплоя
    function setDAOContract (address _daoContract) public onlyOwner {
        require (_daoContract != address (0));
        daoContract = _daoContract;
     // функция изменения цены токена после голосования
    function changePrice (uint _newPrice)  {
        require (msg.sender == daoContract);
        buyPrice = _newPrice;
        // требуется ограничить доступ к этой функции
    }
}