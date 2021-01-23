// args: [vehicle, unit, idAction [slot, type]

_vehicle = _this select 0;
_unit = _this select 1;
_idaction = _this select 2;

_args = _this select 3;
_center = _args select 0;
_type = _args select 1;

if (_vehicle distance _unit > 20) then
{
	["Vehicle out of range", true, false, htGeneral, false] call funcHint;
}
else
{
	_nul = [_vehicle, _center, _type, _idaction] execVM "Player\AttachDetachVehicle.sqf";
};