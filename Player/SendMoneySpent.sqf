// args: [amount]

_amount = _this select 0;

if (_amount >= 0) then
{	
	pvMoneySpent = [_amount, playerGroupIndex, playerSideIndex];
	_nul = [pvMoneySpent] execVM "Server\MsgMoneySpent.sqf";
	publicVariable "pvMoneySpent";
};
