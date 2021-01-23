// args: [vehicle, unit, idAction]

_vehicle = _this select 0;
_unit = _this select 1;
_id = _this select 2;

if (!alive _vehicle) then
{
	_vehicle removeAction _id;
};

if ( _unit != driver _vehicle ) then
{
	_unit groupchat "Eject Cargo Failed, unit must be driver of vehicle.";
}
else
{
	if ( (getPos _vehicle) select 2 < 5 ) then
	{
		[_vehicle, playerSideIndex, 0.25] spawn funcEjectCargo;
	}
	else
	{
		[_vehicle, playerSideIndex, 2] spawn funcEjectCargo;
	};
};
