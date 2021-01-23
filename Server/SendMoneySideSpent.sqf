// args: [si, amount]
private["_si", "_amount"];

_si = _this select 0;
_amount = _this select 1;

pvMoneySideSpent = [_si, _amount];
_nul = [pvMoneySideSpent] execVM "Player\MsgMoneySideSpent.sqf";
publicVariable "pvMoneySideSpent";



