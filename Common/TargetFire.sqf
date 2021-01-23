private ["_unit", "_target"];

_unit = _this select 0;
_target = _this select 1;

if ( !local _unit ) then
{
	[_this, "funcTargetFire", _unit, false, true] call BIS_fnc_MP;
}
else
{
	_unit doWatch _target;
	_unit doTarget _target;
	_unit doFire _target;
};