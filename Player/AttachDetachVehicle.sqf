// args: [tug, slot, type, idAction]

_tug = _this select 0;
_slot = _this select 1;
_type = _this select 2;
_actionID = _this select 3;

if ( alive _tug ) then
{

// check if attach possible
	_canAttach = true;
	{
		_tugged = _x select tsTugged;
		if (_tug in _tugged) then
		{
			["Cannot attach a vehicle to a vehicle being towed.", true, false, htGeneral, false] call funcHint;
			_canAttach = false;
		};
	}foreach vehicleAttached;
	
// check if attach or detach should be performed
	if ( _canAttach ) then
	{
		_index = 0;
		_count = count vehicleAttached;
		_used = false;
		while {_index < _count && !_used}do
		{
			_tug2 = ((vehicleAttached select _index) select tsTug);
			_tugged = ((vehicleAttached select _index) select tsTugged);

			if (_tug == _tug2 && !isNull(_tugged select _slot)) then
			{
				_used = true;
			}
			else
			{
				_index = _index + 1;
			};
		};
		if (_used) then
		{
			_nul = [_tug, _slot] execVM "Common\SendDetachVehicle.sqf";
		}
		else
		{
			[_tug, _slot, _type] exec "Player\OpenAttachVehicleDialog.sqs";
		};
	};
}
else
{
	["Attach Failed (vehicle destroyed)", true, false, htGeneral, false] call funcHint;
	_tug removeAction _actionID;
};
