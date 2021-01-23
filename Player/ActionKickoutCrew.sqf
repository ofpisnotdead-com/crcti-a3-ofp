_veh = _this select 0;
{
	[_x] call funcEjectUnit;
	sleep 2;
}forEach (crew _veh);

