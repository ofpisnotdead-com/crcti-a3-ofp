if ( isServer ) then
{	
	_pvMoneyRequest = _this select 0;
	_si = _pvMoneyRequest select 0;
	_gi = _pvMoneyRequest select 1;
	_from = _pvMoneyRequest select 2;
	_amount = _pvMoneyRequest select 3;

	_currentMoney = (groupMoneyMatrix select _si) select _gi;
	
	_replaced = false;
	{
		if ( (_x select 0) == _gi && (_x select 1) == _from ) exitWith
		{
			_replaced = true;
			(moneyRequestsPending select _si) set [_forEachIndex, [_gi, _from, (_x select 2) + _amount, _currentMoney, time]];
		};
	}forEach (moneyRequestsPending select _si);

	if ( !_replaced ) then
	{
		(moneyRequestsPending select _si) set[count(moneyRequestsPending select _si),[_gi,_from,_amount,_currentMoney,time]];
	};
};