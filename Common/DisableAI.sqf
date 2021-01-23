private ["_unit", "_section"];

_unit = _this select 0;
_section = _this select 1;

if ( !local _unit ) then
{
	[_this, "funcDisableAI", _unit, false, true] call BIS_fnc_MP;
}
else
{
	_unit disableAI _section;
};