private ["_unit"];

_unit = _this select 0;

pvEjectUnit = _unit;
_unit = [pvEjectUnit] spawn MsgEjectUnit;
publicVariable "pvEjectUnit";