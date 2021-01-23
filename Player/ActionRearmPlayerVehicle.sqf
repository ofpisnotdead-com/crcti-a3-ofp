// args: [vehicle, unit, idAction]

_vehicle = _this select 0;
_unit = _this select 1;

if (_unit == player) then
{
	_support = typesRearm select playerSideIndex;
	_found = [getPos _vehicle, [playerSideIndex], _support, [_vehicle]] call funcGetClosestVehicle;
	_dist = _found select 1;

	if (_dist > rearmRange) then
	{
		["No support vehicle in range", true, false, htGeneral, false] call funcHint;
	}
	else
	{
		[_unit, _found select 0] spawn funcRearm;
	};
};
