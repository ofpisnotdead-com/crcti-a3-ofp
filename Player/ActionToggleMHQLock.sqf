// args: [vehicle, unit, idAction]

_mhq = _this Select 0;
_unit = _this Select 1;
_action = _this Select 2;
_si = playerSideIndex;
_lock = lockMHQ select _si;
_price = unlockMHQPrices select _lock;

if (_lock > 0) then
{
	_money = (groupMoneyMatrix select playersideIndex) select playerGroupIndex;
	if (_money < _price) then
	{
		["Not enough money to unlock MHQ.", true, false, htUnlockFail, false] call funcHint;
	}
	else
	{
		[_price] execVM "Player\SendMoneySpent.sqf";
		_lock = 0;
		_mhq lock false;

		_mhq removeAction _action;
		mhqActions = mhqActions - [_action];
		_newaction = _mhq AddAction ["Lock MHQ","Player\ActionToggleMHQLock.sqf", [], 2, false, false];
		mhqActions = mhqActions + [_newaction];

		pvSay3D = [_mhq, getPos _mhq, "open", 150];
		publicVariable "pvSay3D";
		_nul = [pvSay3D] execVM "Player\MsgSay3D.sqf";
	};
}
else
{
	_lock = 1;
	_mhq lock true;

	_mhq removeAction _action;
	mhqActions = mhqActions - [_action];
	_newaction = _mhq AddAction ["Unlock MHQ","Player\ActionToggleMHQLock.sqf", [], 2, false, false];
	mhqActions = mhqActions + [_newaction];

	pvSay3D = [_mhq, getPos _mhq, "close", 150];
	publicVariable "pvSay3D";
	_nul = [pvSay3D] execVM "Player\MsgSay3D.sqf";
};

lockMHQ set [_si, _lock];
publicVariable "lockMHQ";

