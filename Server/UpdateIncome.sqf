private ["_si", "_gi", "_x"];

_totalIncome = [startMoneyWest, startMoneyEast];

[siWest, _totalIncome select siWest] call funcSendMoneySideTotal;
[siEast, _totalIncome select siEast] call funcSendMoneySideTotal;
[siWest, moneySpent select siWest] call funcSendMoneySideSpent;
[siEast, moneySpent select siEast] call funcSendMoneySideSpent;

_countGroups = [count (groupMatrix select siWest), count (groupMatrix select siEast)];
_timeNext = 60;

while {(count(pvGameOver) == 0)}do
{

	sleep _timeNext;

	_incomeTowns = [0,0];

	{
		_si = (_x select tdSide);
		_val = round((_x select tdValue)*TownIncomeFactor);

		if (_si != siRes) then
		{
			_incomeTowns set [_si, (_incomeTowns select _si) + _val ];
		}
	}forEach towns;

	if ( IncomeLimit > 0 ) then
	{
		if ( (_incomeTowns select siWest) > IncomeLimit ) then {_incomeTowns set [siWest, IncomeLimit];};
		if ( (_incomeTowns select siEast) > IncomeLimit ) then {_incomeTowns set [siEast, IncomeLimit];};
	};

	_totalIncome set[siWest, (_totalIncome select siWest) + (_incomeTowns select siWest)];
	_totalIncome set[siEast, (_totalIncome select siEast) + (_incomeTowns select siEast)];

// West
	_si = siWest;
	_playerIncome = 0;
	_playerGroups = (groupMatrix select _si) - [groupCommander select _si];

	if ( (count _playerGroups) > 0 ) then
	{
		_playerIncome = (_incomeTowns select _si)* ((1 - pvPlayerIncomeRatioWest) / (count _playerGroups));
		_playerIncome = _playerIncome - (_playerIncome % 1);
	};

	_commanderIncome = (_incomeTowns select _si) - _playerIncome*(count _playerGroups);

	_gi = 0;
	for [ {_gi=0}, {_gi<count(groupMatrix select _si)}, {_gi=_gi+1}] do
	{
		_x = (groupMatrix select _si) select _gi;

		_bonus = round(MoneyPerScore*((scoreMoney select _si) select _gi));
		_totalIncome set[_si, (_totalIncome select _si) + _bonus];

		if (_x == (groupCommander select _si)) then
		{
			[_si, _gi, _commanderIncome + _bonus, 0] call funcMoneyAdd;
			[_bonus, _si, _gi] execVM "Server\Info\ScoreMoney.sqf";
		};

		if (_x in _playerGroups) then
		{
			[_si, _gi, _playerIncome + _bonus, 0] call funcMoneyAdd;
			[_bonus, _si, _gi] execVM "Server\Info\ScoreMoney.sqf";
		};

		(scoreMoney select _si) set [_gi, 0];
	};

// East
	_si = siEast;
	_playerIncome = 0;
	_playerGroups = (groupMatrix select _si) - [groupCommander select _si];

	if ( (count _playerGroups) > 0 ) then
	{
		_playerIncome = (_incomeTowns select _si)*((1 - pvPlayerIncomeRatioEast) / (count _playerGroups));
		_playerIncome = _playerIncome - (_playerIncome % 1);
	};

	_commanderIncome = (_incomeTowns select _si) - _playerIncome*(count _playerGroups);

	_gi = 0;
	for [ {_gi=0}, {_gi<count(groupMatrix select _si)}, {_gi=_gi+1}] do
	{
		_x = (groupMatrix select _si) select _gi;

		_bonus = round(MoneyPerScore*((scoreMoney select _si) select _gi));
		_totalIncome set[_si, (_totalIncome select _si) + _bonus];

		if (_x == (groupCommander select _si)) then
		{
			[_si, _gi, _commanderIncome + _bonus, 0] call funcMoneyAdd;
			[_bonus, _si, _gi] execVM "Server\Info\ScoreMoney.sqf";
		};

		if (_x in _playerGroups) then
		{
			[_si, _gi, _playerIncome + _bonus, 0] call funcMoneyAdd;
			[_bonus, _si, _gi] execVM "Server\Info\ScoreMoney.sqf";
		};

		(scoreMoney select _si) set [_gi, 0];
	};

	[siWest, _totalIncome select siWest] call funcSendMoneySideTotal;
	[siEast, _totalIncome select siEast] call funcSendMoneySideTotal;
	[siWest, moneySpent select siWest] call funcSendMoneySideSpent;
	[siEast, moneySpent select siEast] call funcSendMoneySideSpent;

};

