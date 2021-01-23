// args: [wp, pos, si, gi]
private ["_wp", "_pos", "_si", "_gi"];

_wp = _this select 0;
_pos = _this select 1;
_si = _this select 2;
_gi = _this select 3;

pvWPCO = [_wp, _gi, _si, _pos];
[pvWPCO] execVM "Common\MsgWaypoint.sqf"; 
publicVariable "pvWPCO";
