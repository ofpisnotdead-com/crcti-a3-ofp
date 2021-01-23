// args: [siMHQ, siKiller, giKiller]

_siMHQ = _this select 0;
_siKiller = _this select 1;
_giKiller = _this select 2;

pvInfo = [mtMHQDestroyed, _siMHQ, _siKiller, _giKiller];
_nul = [pvInfo] execVM "Player\MsgInfo.sqf";
publicVariable "pvInfo";