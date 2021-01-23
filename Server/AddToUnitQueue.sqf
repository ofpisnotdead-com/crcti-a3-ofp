// args: [_factory, _type, _driver, _gunner, _commander, _si, _giJoin, _giBuyer]

private["_factory", "_type", "_driver", "_gunner", "_commander", "_si", "_giJoin", 
        "_giBuyer", "_queues", "_queue", "_model", "_bVehicle", "_unitsToBuild", 
        "_weptmp", "_gunners", "_commanders"];

_factory = _this select 0;
_type = _this select 1;
_driver = _this select 2;
_gunner = _this select 3;
_commander = _this select 4;
_si = _this select 5;
_giJoin = _this select 6;
_giBuyer = _this select 7;

queueEntryIdx = queueEntryIdx + 1;
_queues = factoryQueues select _si;
_queue = [];

{
	if ( (count _x > 0) && (_x select 0) == _factory ) exitWith
	{

		(_x select 2) set [count (_x select 2), [_type, _driver, _gunner, _commander, _giJoin, _giBuyer, false, queueEntryIdx]];
		publicVariable "factoryQueues";

		_model = (unitDefs select _type) select udModel;

		_bVehicle = false;
		if (!(_model isKindOf "Man")) then
		{
			_bVehicle = true;
		};

		_unitsToBuild = 1;
		if ( _bVehicle ) then
		{
			_weptmp = (_model call funcGetVehicleWeapons);
			_gunners = _weptmp select 3;
			_commanders = _weptmp select 4;

			_unitsToBuild = _driver;
			_unitsToBuild = _unitsToBuild + _gunner*count(_gunners);
			_unitsToBuild = _unitsToBuild + _commander*count(_commanders);
		};

		(groupUnitsBuildingMatrix select _si) set [_giJoin, ((groupUnitsBuildingMatrix select _si) select _giJoin) + _unitsToBuild];

		if (_factory in buildingsInUse) then
		{
			[_type, _si, _giBuyer, _giJoin] execVM "Server\Info\UnitQueued.sqf";
		};
	};

}forEach _queues;