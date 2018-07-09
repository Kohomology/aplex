pragma solidity ^0.4.0;

contract DealsFactory { // Контракт, задачей которого является создание нового смарт-контракта Deal между пользователями системы
    
    mapping (uint256 => address) deals; // Ассоциативный массив сделок (по номеру сделки получаем ее адрес)
    
    uint256 count; // Размер ассоциативного массива
    
    function createDeal(uint256 _id_buyer, uint256 _id_machine, uint256 _id_seller, uint256 _delay_time, uint256 _date, uint256 _price, uint256 _id_polygon, uint256 _type) { // Создание новой сделки
        Deal newDeal = new Deal(_id_buyer, _id_machine, _id_seller, _delay_time, _date, _price, _id_polygon, _type);
        count += 1;
        deals[count] = newDeal;
    }
    
}

contract Deal { // Контракт сделки
    
	uint256 public id_buyer; // id рекламодателя
	uint256 public id_machine; // id экрана
	uint256 public id_seller; // id владельца # TODO – можно убрать, т.к. по id экрана можно вычислить id владельца
	uint256 public delay_time; // Время показа (количество секунд, в формате UNITX-time)
	uint256 public date; // Дата показа (начиная с которой заявку разрешено выставлять на аукцион)
	uint256 public price; // Цена сделки (стоимость показа за одну секунду во внутренней валюте системы)
	uint256 public id_polygon; // id области, в которой лежит экран (изначально на вход подаются симплексы, но для
						// простоты они преобразуются индексы областей заранее (на этапе формирования базы данных
						// на сервере компании, т.е. до передачи информации в блокчейн)
						// с расчетом попадания каждого экрана в нужный симплекс)
	uint256 public type_of_advertising; // тип рекламы (по направлениям, как раньше это было реализовано в Google AdScense)
	bool public workIsReady; // показана ли реклама
	
	 // Конструктор
    function Deal(uint256 _id_buyer, uint256 _id_machine, uint256 _id_seller, uint256 _delay_time, uint256 _date, uint256 _price, uint256 _id_polygon, uint256 _type) public {
		id_buyer = _id_buyer;
		id_machine = _id_machine;
		id_seller = _id_seller;
		delay_time = _delay_time;
		date = _date;
		price = _price;
		id_polygon = _id_polygon;
		type_of_advertising = _type;
		workIsReady = false;        
    }
    
	// Вызывается экраном автоматически, когда показ объявления завершен
    function workDone() public {
        workIsReady = true;
    }
    
}

