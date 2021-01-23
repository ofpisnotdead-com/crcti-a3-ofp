_pvPlayerKilled = _this select 0;

_siUnit = _pvPlayerKilled select 0;
_unit = _pvPlayerKilled select 1;

if ( _siUnit == playerSideIndex && _unit != player ) then
{
	_name = name _unit;
	_text = format["%1 has respawned!", _name];
	[_text, false, true, htPlayerRespawn, false] call funcHint;
};