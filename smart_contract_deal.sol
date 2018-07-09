pragma solidity ^0.4.0;

contract DealsFactory { // ��������, ������� �������� �������� �������� ������ �����-��������� Deal ����� �������������� �������
    
    mapping (uint256 => address) deals; // ������������� ������ ������ (�� ������ ������ �������� �� �����)
    
    uint256 count; // ������ �������������� �������
    
    function createDeal(uint256 _id_buyer, uint256 _id_machine, uint256 _id_seller, uint256 _delay_time, uint256 _date, uint256 _price, uint256 _id_polygon, uint256 _type) { // �������� ����� ������
        Deal newDeal = new Deal(_id_buyer, _id_machine, _id_seller, _delay_time, _date, _price, _id_polygon, _type);
        count += 1;
        deals[count] = newDeal;
    }
    
}

contract Deal { // �������� ������
    
	uint256 public id_buyer; // id �������������
	uint256 public id_machine; // id ������
	uint256 public id_seller; // id ��������� # TODO � ����� ������, �.�. �� id ������ ����� ��������� id ���������
	uint256 public delay_time; // ����� ������ (���������� ������, � ������� UNITX-time)
	uint256 public date; // ���� ������ (������� � ������� ������ ��������� ���������� �� �������)
	uint256 public price; // ���� ������ (��������� ������ �� ���� ������� �� ���������� ������ �������)
	uint256 public id_polygon; // id �������, � ������� ����� ����� (���������� �� ���� �������� ���������, �� ���
						// �������� ��� ������������� ������� �������� ������� (�� ����� ������������ ���� ������
						// �� ������� ��������, �.�. �� �������� ���������� � ��������)
						// � �������� ��������� ������� ������ � ������ ��������)
	uint256 public type_of_advertising; // ��� ������� (�� ������������, ��� ������ ��� ���� ����������� � Google AdScense)
	bool public workIsReady; // �������� �� �������
	
	 // �����������
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
    
	// ���������� ������� �������������, ����� ����� ���������� ��������
    function workDone() public {
        workIsReady = true;
    }
    
}

