_index = 0;
_groups = groupMatrix select siwest;
_count = count _groups;

if (_count != 0) then
{
	while {_index < _count} do
	{
		_group = _groups select _index;

		if (group player == _group) then
		{
			_nul = [player, siWest, _index] execVM "Player\InitPlayer.sqf";
		};
		_index = _index + 1;
	};
};

_index = 0;
_groups = groupMatrix select sieast;
_count = count _groups;

if (_count != 0) then
{
	while {_index < _count}do
	{
		_group = _groups select _index;

		if (group player == _group) then
		{
			_nul = [player, siEast, _index] execVM "Player\InitPlayer.sqf"
		};
		_index = _index + 1;
	};
};