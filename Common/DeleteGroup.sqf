private ["_group"];

_group = _this select 0;

if ( (count _this) < 2 ) then
{	
	[[_group, true], "funcDeleteGroup", true, false, true] call BIS_fnc_MP;
}
else
{
	deleteGroup _group;
};