private ["_unit", "_vehicle"];

_unit = _this select 0;
_vehicle = _this select 1;

if ( !local _unit ) then
{
	[_this, "funcAssignAsGunner", _unit, false, true] call BIS_fnc_MP;
}
else
{
	[_unit] allowGetIn true;
	[_unit] orderGetIn true;
	_unit assignAsGunner _vehicle;
};