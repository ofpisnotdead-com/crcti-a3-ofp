// args: [vehicle, si, delay]
private ["_vehicle", "_si", "_delay", "_cargo"];

_vehicle = _this select 0;
_si = _this select 1;
_delay = _this select 2;

_cargo = [_vehicle] call funcGetAllCargo;

{
	[_x] call funcEjectUnit;
	sleep _delay;
}forEach _cargo;
