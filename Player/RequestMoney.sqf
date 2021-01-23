// args: [from, amount]

_si = playerSideIndex;
_gi = playerGroupIndex;
_from = _this select 0;
_amount = _this select 1;

if ( _gi != _from ) then
{
	_groupCommander = (groupCommander select _si);
	_fromGroup = ((groupMatrix select _si) select _from);
	_fromLeader = leader _fromGroup;
	if ( _groupCommander != playerGroup && !(isPlayer _fromLeader) && _fromGroup != _groupCommander) then
	{
		["Can only request from Players or Commander!", true, false, htMoneyRequestFail, true] call funcHint;
	}
	else
	{
		pvMoneyRequest = [_si,_gi,_from,_amount];
		if ( isServer ) then
		{
			_nul = [pvMoneyRequest] spawn MsgRequestMoney;
		}
		else
		{
			publicVariable "pvMoneyRequest";
		};
	};

};