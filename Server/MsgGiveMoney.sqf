if ( isServer ) then
{
	_value = _this select 0;

	_amount = _value select 0;
	_giFrom = _value select 1;
	_giTo = _value select 2;
	_si = _value select 3;

	[_si, _giFrom, _giTo, _amount] call funcMoneyTransfer;

};