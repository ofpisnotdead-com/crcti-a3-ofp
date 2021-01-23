private ["_cargo", "_veh"];

_veh = _this select 0;
_cargo = (crew _veh) - ([_veh] call funcGetAllCrewWithoutCargo);

_cargo = _cargo - [objNull];

_cargo
