// args [[object, ...], si]

_object = (_this select 0) select 0;
_si = _this select 1;
_type = -1;
_timeDestroyed = time;

if ( !SQHoldProdution ) then
{
	_si spawn scriptCheckWinDestruction;
};

{
	_objects = _x select 0;
	_type = _x select 1;

	if (_object in _objects) exitWith
	{
		if (!(_object in primStructsPlaced)) then
		{
			[_si, _type] execVM "Server\Info\StructDestroyed.sqf";
		};
	};
}forEach structuresServer;

// AddToRepairList
_donotrepair = _object getVariable "donotRepair";

if ( isNil "_donotrepair" ) then
{
	_index = count (repairableStructureMatrix select _si);
	(repairableStructureMatrix select _si) set [_index, [_object, 1, _type] ];
		
	while {damage _object > 0 && (time-_timeDestroyed) < structTimeOut }do
	{
		sleep 10;
	};
};

// Delete Structure
if ( damage _object > 0.1 ) then
{
	{
		_objects = _x select 0;
		_type = _x select 1;

		if (_object in _objects) exitWith
		{
			structuresServer = structuresServer - [_x];
		};
	}forEach structuresServer;

	deleteVehicle _object;	
};
