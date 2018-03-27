pragma solidity ^0.4.11;

// Подключаем библиотеку
import 'github.com/oraclize/ethereum-api/oraclizeAPI.sol';

// Объявляем контракт
contract DollarCost is usingOraclize {

    // Объявляем переменную, в которой будем хранить стоимость доллара
    uint public dollarCost;

    // В эту функцию ораклайзер будет присылать нам результат (название функции из документации к оракулу)
    function __callback(bytes32 myid, string result) public {
        // Проверяем, что функцию действительно вызывает ораклайзер
        if (msg.sender != oraclize_cbAddress()) throw;
        // Обновляем переменную со стоимостью доллара
        // 3 количество знаков после запятой
        // parseInt позволяет вытаскивать данные из string

        dollarCost = parseInt(result, 3);
    }

    // Функция для обновления курса доллара
    function updatePrice() public payable {
        // Проверяем, что хватает средств на вызов функции
        if (oraclize_getPrice("URL") > this.balance){
            // Если не хватает, просто завершаем выполнение
            return;
        } else {
            // Если хватает - отправляем запрос в API

            // https://api.kraken.com/0/public/Ticker?pair=ETHUSD вытаскиваем - для USD
            //{"error":[],"result":{"XETHZUSD":{"a":["477.66000","1","1.000"],"b":["477.34000","9","9.000"],"c":["477.30000","0.04595520"],
            //"v":["50606.44511985","55371.51729991"],"p":["489.66441","492.86921"],"t":[14360,16077],"l":["466.80000","466.80000"],"h":["526.67000","536.00000"],"o":"522.74000"}}}

            //https://api.kraken.com/0/public/Ticker?pair=ETHEUR вытаскиваем - для EUR
            //{"error":[],"result":{"XETHZEUR":{"a":["383.28000","7","7.000"],"b":["382.83000","5","5.000"],"c":["383.68000","3.29301397"],"v":["54700.40522553","58629.19984413"],
            //"p":["393.32498","395.68311"],"t":[18405,20234],"l":["375.00000","375.00000"],"h":["427.60000","434.84000"],"o":"425.03000"}}}

            //oraclize_query("URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHUSD).result.XETHZUSD.c.[0]");
            oraclize_query("URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHEUR).result.XETHZUSD.o.[0]");
        }
    }
}