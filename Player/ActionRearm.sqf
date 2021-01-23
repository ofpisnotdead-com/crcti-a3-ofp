// args: [vehicle, unit, idAction]

_truck = _this select 0;
_unit = _this select 1;
_vehicle = vehicle _unit;

if (alive _truck) then
{
	if (_vehicle == _truck) then
	{
		_nul = [_truck, _unit] execVM "Player\OpenRearmVehicleDialog.sqf";
	}
	else
	{
		[_unit, _truck] spawn funcRearm;
	};
}
else
{
	["Rearm Failed (Support vehicle destroyed)", true, false, htGeneral, false] call funcHint;
	_truck removeAction (_this select 2);
};
