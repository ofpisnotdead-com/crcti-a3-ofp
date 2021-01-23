// args: [si, giFrom, giTo, amount]
// return: none
private["_si", "_from", "_to", "_amount"];

_si = _this select 0;
_from = _this select 1;
_to = _this select 2;
_amount = _this select 3;

if (_amount <= (groupMoneyMatrix select _si) select _from) then
{
	[_si, _from, - _amount, 0] call funcMoneyAdd;
	[_si, _to, _amount, 0] call funcMoneyAdd;

	{
		if ( (_x select 0) == _to && (_x select 1) == _from ) exitWith
		{
			(moneyRequestsPending select _si) set [_forEachIndex, [_to, _from, (_x select 2) - _amount, _x select 3, _x select 4]];
		};
	}forEach (moneyRequestsPending select _si);

	[_si, _from, _to, _amount] execVM "Server\SendMoneyTransferred.sqf"
}