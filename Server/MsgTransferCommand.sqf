if ( isServer ) then
{
	_value = _this select 0;

	_gi = _value select 0;
	_si = _value select 1;

	_group = (groupMatrix select _si) select _gi;

	groupCommander set [_si, _group];
	giCO set [_si, _gi];
	publicVariable "groupCommander";
	publicVariable "giCO";
	[_si, _gi] execVM "Server\Info\CommanderChange.sqf";
};