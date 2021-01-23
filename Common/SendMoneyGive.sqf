// args: [si, giFrom, giTo, amount]

_si = _this select 0;
_giFrom = _this select 1;
_giTo = _this select 2;
_amount = _this select 3;

if ( _amount > 0 ) then
{
	_money = (groupMoneyMatrix select _si) select _giFrom;
	if ( _money >= _amount ) then
	{		
		pvMoneyGive = [_amount, _giFrom, _giTo, _si];
		publicVariable "pvMoneyGive";
	};
};