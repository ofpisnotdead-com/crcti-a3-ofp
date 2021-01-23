private ["_vehicle", "_height"];

_vehicle = _this select 0;
_height = _this select 1;

if ( !local _vehicle ) then
{
	[_this, "funcFlyInHeight", _vehicle, false, true] call BIS_fnc_MP;
}
else
{
	_vehicle flyInHeight _height;
};