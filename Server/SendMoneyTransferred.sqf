// args: [si, giFrom, giTo, amount]

_si = _this select 0;
_giFrom = _this select 1;
_giTo = _this select 2;
_amount = _this select 3;

pvMoneyTransfer = [_amount, _giFrom, _giTo, _si];
_nul = [pvMoneyTransfer] execVM "Player\MsgMoneyTransferred.sqf";
publicVariable "pvMoneyTransfer";


