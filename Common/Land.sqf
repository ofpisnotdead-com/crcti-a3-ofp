private ["_unit", "_land"];

_unit = _this select 0;
_land = _this select 1;

if ( !local _unit ) then
{
	[_this, "funcLand", _unit, false, true] call BIS_fnc_MP;
}
else
{
	_unit land _land;
};