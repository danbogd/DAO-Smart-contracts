pragma solidity ^0.4.11;

// Интерфейс токена
interface DAOToken {
    function stop();
    function start();
    function balanceOf (address user) returns (uint);
}

interface SafeICO {
    function changePrice(uint _newPrice);
}
// Контракт ДАО
contract DAOContract {

    // Переменная для хранения токена
    DAOToken public token;
    SafeICO public iso;

    // Минимальное число голосов
    uint8 public minVotes;

    // Переменная для предложения по цене
    uint public proposalPrice;

    // Переменная для хранения состояния голосования
    bool public voteActive = false;

    // Стукрутра для голосов
    struct Votes {
        int current;
        uint numberOfVotes;
    }

    // Переменная для структуры голосов
    Votes public election;

    // Функция инициализации ( принимает адрес токена)
    function DAOContract(DAOToken _token, SafeICO _iso) public {
        token = _token;
        iso = _iso;
        minVotes = 10;
    }

    // Функция для предложения нового символа
    function newPrice (uint _price) public {
        // Проверяем, что голосвание не идет
        require(!voteActive);
        proposalPrice = _price;
        voteActive = true;

        // Остановка работы токена
        token.stop();
    }

    // Функция для голосования
    function vote(bool _vote) public {
        // Проверяем, что голосование идет
        require(voteActive);
        // Логика для голосования
        if (_vote){
            election.current += int(token.balanceOf(msg.sender));
        }
        else {
            election.current -= int(token.balanceOf(msg.sender));
        }

        election.numberOfVotes += token.balanceOf(msg.sender);

    }

    // Функция для смены цены
    function changePrice(uint _proposalPrice) public {

        // Проверяем, что голосование активно
        require(voteActive);

        // Проверяем, что было достаточное количество голосов
        require(election.numberOfVotes >= minVotes);

        // Логика для смены символа
        if (election.current > 0) {
            iso.changePrice(_proposalPrice);
        }
        // Сбрасываем все переменные для голосования
        election.numberOfVotes = 0;
        election.current = 0;
        voteActive = false;

        // Возобновляем работу токена
        token.start();

    }

}