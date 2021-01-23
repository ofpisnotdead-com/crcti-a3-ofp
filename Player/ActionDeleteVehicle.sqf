_veh = _this select 0;
_sigi = _veh getVariable "SQU_SI_GI";
_gi = _sigi select 1;
_objects = _this select 3;

if ( playerGroup == (groupCommander select playerSideIndex) || _gi == playerGroupIndex ) then
{
	{
		_object = _x;
		{	unassignVehicle _x}forEach (crew _object);
		deleteVehicle _object;
	}forEach _objects;
}
else
{
	["Commander only!", true, false, htGeneral, false] call funcHint;
};

