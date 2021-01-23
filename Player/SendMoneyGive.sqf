// args: [amount, giTo]

_amount = _this select 0;
_giTo = _this select 1;

if (_amount >= 0) then
{
	_money = ((groupMoneyMatrix select playerSideIndex) select playerGroupIndex);

	if (_money < _amount) then
	{
		["Not Enough Cash", true, false, htGeneral, false] call funcHint;
	}
	else
	{		
		pvMoneyGive = [_amount, playerGroupIndex, _giTo, playerSideIndex];	
		_nul = [pvMoneyGive] execVM "Server\MsgGiveMoney.sqf";
		publicVariable "pvMoneyGive";
	};
};