// args: [params]

_minutes = _this select 1;

[format["Town Win in\n%1 minutes.", _minutes], true, false, htTownWin, true] call funcHint;
