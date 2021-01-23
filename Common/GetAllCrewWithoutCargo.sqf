private ["_crew", "_veh"];

_veh = _this select 0;
_crew = [driver _veh, commander _veh] + ([_veh] call funcGetAllGunners);

_crew = _crew - [objNull];

_crew
