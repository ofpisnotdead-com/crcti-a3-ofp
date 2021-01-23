_value = _this select 0;
_vehicle = _value select 0;
_tug = _value select 1;

if ( !isNull _vehicle && !isNull _tug) then
{

	_slot = _value select 2;
	_type = _value select 3;

	_gi = _value select 4;
	_si = _value select 5;

	_index = 0;
	_count = count vehicleAttached;
	_found = false;

	while {_index < _count && !_found}do
	{
		_tug2 = ((vehicleAttached select _index) select tsTug);

		if (_tug2 == _tug) then
		{
			_found = true;
		}
		else
		{
			_index = _index + 1;
		};
	};

	if ( !_found ) then
	{
		_index = count vehicleAttached;
		vehicleAttached set [_index, [_tug, [objNull,objNull,objNull]]];
	};

	((vehicleAttached select _index) select tsTugged) set [_slot, _vehicle];

	if ( !isNull player ) then
	{
		if (playerSideIndex == _si && playerGroupIndex == _gi) then
		{
			["Vehicle Attached", false, false, htGeneral, false] call funcHint;
		};
	};

	if (local _vehicle) then
	{
		if (_type == ttHeli) then {_nul = [_vehicle, _tug, _index, _slot, _gi, _si] execVM "Common\UpdateAttachedVehicleToHeli.sqf";};
		if (_type == ttBoat) then {_nul = [_vehicle, _tug, _index, _slot, _gi, _si] execVM "Common\UpdateAttachedVehicleToBoat.sqf";};
		if (_type == ttTruck || _type == ttAPC) then {_nul = [_vehicle, _tug, _index, _slot, _gi, _si] execVM "Common\UpdateAttachedVehicleToTruckAPC.sqf";};
	};

};