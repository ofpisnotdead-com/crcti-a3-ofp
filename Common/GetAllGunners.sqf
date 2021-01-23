private ["_gunners", "_veh"];

_veh = _this select 0;

_gunners=[gunner _veh];

{
	if (((assignedVehicleRole _x) select 0 == "Turret")) then
	{
		if ( !(_x in _gunners)) then
		{
			_gunners=_gunners+[_x]
		};
	}
}forEach (crew _veh);

_gunners = _gunners - [objNull];

_gunners
