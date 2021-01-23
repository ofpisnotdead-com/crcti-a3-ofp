// args: [vehicle, unit, idAction]

_truck = _this select 0;
_unit = _this select 1;
_vehicle = vehicle _unit;

if (alive _truck) then
{

	if (_vehicle == _truck) then
	{
		[_truck, _unit] execVM "Player\OpenRepairVehicleDialog.sqf";
	}
	else
	{
		if (((_unit distance _truck) < repairRange)) then
		{
			[_unit, _truck] execVM "Player\HealRepair.sqf";
		};

	};
}
else
{
	player groupchat "Heal/Repair Failed (Support vehicle destroyed)";
	_truck removeAction (_this select 2);
};
