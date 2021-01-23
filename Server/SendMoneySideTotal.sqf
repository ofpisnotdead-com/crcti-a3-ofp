// args: [si, amount]
private["_si", "_amount"];

_si = _this select 0;
_amount = _this select 1;

pvMoneySideTotal = [_si, _amount];
_nul = [pvMoneySideTotal] execVM "Player\MsgMoneySideTotal.sqf";
publicVariable "pvMoneySideTotal";

