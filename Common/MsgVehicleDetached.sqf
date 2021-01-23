_value = _this select 0;
_vehicle = _value select 0;
_gi = _value select 1;
_si = _value select 2;

if ( !(isNull _vehicle) ) then
{
	_index = 0;
	_count = count vehicleAttached;
	_found = false;

	while {_index < _count && !_found}do
	{
		_tugged = ((vehicleAttached select _index) select tsTugged);
		_slot = [_vehicle, _tugged] call funcGetIndex;

		if (_slot != -1) then
		{
			_tugged set [_slot, objNull];
			_found = true;
		}
		else
		{
			_index = _index + 1;
		};
	};

	if ( !isNull player ) then
	{
		if (playerSideIndex == _si && playerGroupIndex == _gi) then
		{
			["Vehicle Detached", true, false, htGeneral, false] call funcHint;
		};
	};

};