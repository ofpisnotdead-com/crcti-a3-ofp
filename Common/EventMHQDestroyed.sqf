// args: [[unit, killer], si]

_mhq = (_this select 0) select 0;
_killer = (_this select 0) select 1;
_siMHQ = _this select 1;

_sigi = _killer call funcGetSideAndGroup;

_siKiller = _sigi select 0;
_giKiller = _sigi select 1;

[_siMHQ, _siKiller, _giKiller] execVM "Common\SendMHQDestroyed.sqf";
