// args: [mhq]

_si = playerSideIndex;
_mhq = _this select 0;
_lockOnly = _this select 1;

{
	_mhq removeAction _x;
}foreach mhqActions;

mhqActions = [];

if ( alive _mhq ) then
{
	if (playerGroup == (groupCommander select _si)) then
	{
		_action = _mhq addAction ["Unflip MHQ", "Player\UnflipVehicle.sqf", [], 2, false, false];
		mhqActions = mhqActions + [_action];

		_locked = lockMHQ select _si;
		_price = unlockMHQPrices select _locked;

		if (_locked > 0 ) then
		{
			_str = "Unlock MHQ";

			if ( _price > 0 ) then
			{
				_str = format["%1 %2$", _str, _price];
			};

			_action = _mhq addAction[_str,"Player\ActionToggleMHQLock.sqf", [], 2, false, false];
		}
		else
		{
			_action = _mhq addAction["Lock MHQ","Player\ActionToggleMHQLock.sqf", [], 2, false, false];

		};

		mhqActions = mhqActions + [_action];

		if ( !_lockOnly ) then
		{
			_type = [utMHQWest, utMHQEast] select _si;
			_nul = [[_mhq, _type, _si], ["MHQ Build Menu"], baseRadius, true] execVM "Player\UpdateFarUnitActions.sqf";
		};

	};
}
else
{
	_action = _mhq addAction["Repair MHQ","Player\ActionRepairMHQ.sqf", [], 2, false, false];
	mhqActions = mhqActions + [_action];
};