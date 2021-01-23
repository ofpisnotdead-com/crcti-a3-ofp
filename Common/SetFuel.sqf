private ["_vehicle", "_fuel"];

_vehicle = _this select 0;
_fuel = _this select 1;

if ( !local _vehicle ) then
{
	[_this, "funcSetFuel", _vehicle, false, true] call BIS_fnc_MP;
}
else
{
	_vehicle setFuel _fuel;
};