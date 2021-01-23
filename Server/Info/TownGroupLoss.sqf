// args: [ti, si]

_ti = _this select 0;
_si = _this select 1;

_value = [mtTownGroupLoss,_ti,_si];

_value execVM "Server\Info\SendInfoMsg.sqf";
