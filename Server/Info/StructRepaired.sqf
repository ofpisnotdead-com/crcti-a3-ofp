// args: [damage, si, gi, type]

private ["_damage", "_si", "_gi", "_type"];

_damage = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_type = _this select 3;

_percent = (1 - _damage)*100;
_percent = _percent - (_percent % 1);

[mtStructRepaired, _percent, _gi, _type, _si] execVM "Server\Info\SendInfoMsg.sqf";
