pragma solidity ^0.4.11;

// Подключаем библиотеку
import 'github.com/oraclize/ethereum-api/oraclizeAPI.sol';


contract EuroCost is usingOraclize {

    uint public euroCost;


    function __callback(bytes32 myid, string result) public {
        // Проверяем, что функцию действительно вызывает ораклайзер
        if (msg.sender != oraclize_cbAddress()) throw;


        euroCost = parseInt(result, 3);
    }

    // Функция для обновления курса евро
    function updatePrice() public payable {

        if (oraclize_getPrice("URL") > this.balance){

            return;
        } else {



            oraclize_query("URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHEUR).result.XETHZEUR.c.[0]");
        }
    }
}