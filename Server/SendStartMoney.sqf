_startMoneyWest = startMoneyWest;
_startMoneyWestPlayer = startMoneyWestPlayer;
_startMoneyEast = startMoneyEast;
_startMoneyEastPlayer = startMoneyEastPlayer;

_groups = groupMatrix select siWest;
_count = count _groups;
_commanderIndex = [];

for [ {_index=0}, {_index<_count}, {_index=_index+1}] do
{

	_group = _groups select _index;
	if (_group == (groupCommander select siWest)) then
	{
		_commanderIndex = _index;
	};

	if ( !(_group in (groupAiMatrix select siWest)) && (_group != (groupCommander select siWest))) then
	{
		_groupsMoney = groupMoneyMatrix select siWest;
		_money = _groupsMoney select _index;
		if (_money == 0) then
		{

			[siWest, _index, startMoneyWestPlayer, 1] call funcMoneyAdd;
			_startMoneyWest = _startMoneyWest - _startMoneyWestPlayer;
		};

	};
};

[siWest, _commanderIndex, _startMoneyWest, 1] call funcMoneyAdd;

_groups = groupMatrix select siEast;
_count = count _groups;
_commanderIndex = [];

for [ {_index=0}, {_index<_count}, {_index=_index+1}] do
{

	_group = _groups select _index;
	

	if (_group == (groupCommander select siEast)) then
	{
		_commanderIndex = _index;
	};

	if ( !(_group in (groupAiMatrix select siEast)) && (_group != (groupCommander select siEast))) then
	{
		_groupsMoney = groupMoneyMatrix select siEast;
		_money = _groupsMoney select _index;
		if (_money == 0) then
		{
			[siEast, _index, startMoneyEastPlayer, 1] call funcMoneyAdd;
			_startMoneyEast = _startMoneyEast - _startMoneyEastPlayer;
		};

	};
};

[siEast, _commanderIndex, _startMoneyEast, 1] call funcMoneyAdd;
