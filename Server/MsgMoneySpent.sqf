if ( isServer ) then
{
	_value = _this select 0;
	_amount = _value select 0;
	_gi = _value select 1;
	_si = _value select 2;

	[_si, _gi, _amount] call funcMoneySpend;
};
