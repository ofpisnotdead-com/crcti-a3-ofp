private ["_unit", "_i", "_delay"];

if ( isServer ) then
{
	_unit = (_this select 0) select 0;
	_delay = (_this select 0) select 1;
	
	_isPending = false;
	{
		if ( (_x select 0) == _unit ) exitWith {_isPending = true;};
	}forEach GarbagePending;

	if ( !(isNull _unit) && !(_unit in GarbageList) && !_isPending ) then
	{
		_unit removeAllEventHandlers "killed";
		_unit removeAllEventHandlers "hit";
		_unit removeAllEventHandlers "getout";
		_unit removeAllEventHandlers "getin";
		_unit removeAllEventHandlers "fired";
		_unit setVariable ["trashed", true];

		for [ {_i=0}, {_i<16}, {_i=_i+1}] do
		{
			_unit removeAction _i;
		};

		if ( !(isNull _unit)) then
		{
			//diag_log format["TRASH: %1 (%2s)", str(_unit), _delay];
			GarbagePending = GarbagePending + [[_unit, time + _delay]];
		};
	};
};

