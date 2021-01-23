// args: [si, gi, sendRepeats]
private ["_si", "_gi", "_amount"];

_si = _this select 0;
_gi = _this select 1;

_amount = (groupMoneyMatrix select _si) select _gi;

pvMoney = [_si, _gi, _amount];
_nul = [pvMoney] execVM "Player\MsgMoneyStatus.sqf";     
publicVariable "pvMoney";

