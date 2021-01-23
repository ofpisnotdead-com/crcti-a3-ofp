private ["_unit"];

_unit = _this select 0;

if ( !local _unit ) then
{
	[_this, "funcDoStop", _unit, false, true] call BIS_fnc_MP;
}
else
{
	doStop _unit;
};