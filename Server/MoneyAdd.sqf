// args: [si, gi, amount]
// return: none

private ["_si", "_gi", "_amount"];

_si = _this select 0;
_gi = _this select 1;
_amount = _this select 2;

(groupMoneyMatrix select _si) set [_gi, ((groupMoneyMatrix select _si) select _gi) + _amount];
[_si, _gi] call funcSendMoneyStatus;
