// args: _unit
private ["_unit", "_group", "_si", "_gi", "_sigi"];

_unit = _this;
_group = group _unit;

_si = -1;
_gi = [_group, groupMatrix select siWest] call funcGetIndex;

if (_gi != -1) then
{
	_si = siWest;
}
else
{
	_gi = [_group, groupMatrix select siEast] call funcGetIndex;
	if (_gi != -1) then
	{
		_si = siEast;
	}
	else
	{
		_sigi = _unit getVariable "SQU_SI_GI";

		if ( isNil "_sigi" ) then
		{
			_si = -1;
			_gi = -1;
		}
		else
		{
			_si = _sigi select 0;
			_gi = 0;
		};

		if ( _si == siWest || _si == siEast ) then
		{
			_si = -1;
			_gi = -1;
		};
	};
};

[_si, _gi]