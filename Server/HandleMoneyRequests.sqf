// args: [si, gi]
private["_si", "_gi", "_to", "_from", "_amount", "_money"];

_si = _this select 0;
_gi = _this select 1;

{
	_to = _x select 0;
	_from = _x select 1;
	_amount = _x select 2;
	if ( _from == _gi && _amount > 0 ) exitWith
	{
		_money = (groupMoneyMatrix select _si) select _gi;
		if ( _money >= _amount ) then
		{
			[_si, _gi, _to, _amount] call funcMoneyTransfer;
		}
		else
		{
			(moneyRequestsPending select _si) set [_forEachIndex, [_to,_from,0, _x select 3, _x select 4]];
		};
	};
}forEach (moneyRequestsPending select _si);