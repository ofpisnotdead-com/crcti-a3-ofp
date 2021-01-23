// args: [_type, _si, _objects]

_typeStructure = _this select 0;
_si = _this select 1;
_factory = (_this select 2) select 0;

_factory setVariable ["rbtime",["READY", 0],true];

_buildCycleTime = ((structDefs select _typeStructure) select sdBuildCycleTime) * UnitBuildTimeFactor;

if ( CRCTIDEBUG ) then {_buildCycleTime = 0;};

_notInUseSent = 0;
_InUseSent = 0;

_queues = factoryQueues select _si;
_qi = count _queues;
_queues set [_qi, [_factory, _typeStructure, []] ];
publicVariable "factoryQueues";

_state = "wait";

while {_state != "finshed"}do
{
	sleep 1;

	_queue = (_queues select _qi) select 2;

	if ( count _queue == 0 && _notInUseSent == 0 ) then
	{
		BuildingsInUse = BuildingsInUse - [objNull];
		BuildingsInUse = BuildingsInUse - [_factory];
		publicVariable "BuildingsInUse";

		_notInUseSent = 1;
		_InUseSent = 0;
	};

	if ((count(((factoryQueues select _si)select _qi) select 2))!= (count _queue)) then
	{
		_queues = factoryQueues select _si;
		_queues set [_qi, _factory, _typeStructure, [(((factoryQueues select _si)select _qi)select 2)]];
		_queue = (_queues select _qi) select 2;
		publicVariable "factoryQueues";
	};

	if (!alive _factory || isNull _factory) then
	{
		_notInUseSent == 0;
		while {count _queue > 0}do
		{

			_entry = _queue select 0;
			_type = _entry select 0;
			_driver = _entry select 1;
			_gunner = _entry select 2;
			_commander = _entry select 3;
			_giJoin = _entry select 4;
			_giBuyer = _entry select 5;

			_unitDesc = unitDefs select _type;
			_model = _unitDesc select udModel;

			_queue set [0, 0];
			_queue = _queue - [0];
			(_queues select _qi) set [2, _queue];
			_queue = (_queues select _qi) select 2;
			publicVariable "factoryQueues";

			_bVehicle = false;
			if ( !(_model isKindOf "Man")) then
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

			(groupUnitsBuildingMatrix select _si) set [_giJoin, ((groupUnitsBuildingMatrix select _si) select _giJoin) - _unitsToBuild];
		};

	};

	if (isNull _factory) exitWith
	{
		(_queues select _qi) set [2, []];
		_state = "finished";
		publicVariable "factoryQueues";
	};

	while {count _queue > 0}do
	{
		if ( _InUseSent == 0 ) then
		{
			BuildingsInUse = BuildingsInUse - [objNull];
			BuildingsInUse = BuildingsInUse + [_factory];
			publicVariable "BuildingsInUse";
			_notInUseSent = 0;
			_inUseSent = 1;
		};

		_entry = _queue select 0;
		_type = _entry select 0;
		_driver = _entry select 1;
		_gunner = _entry select 2;
		_commander = _entry select 3;
		_giJoin = _entry select 4;
		_giBuyer = _entry select 5;
		_cancelled = _entry select 6;

		_unitDesc = unitDefs select _type;
		_model = _unitDesc select udModel;
		_crew = _unitDesc select udCrew;

		_crewcost = 0;
		_crewbuildtime = 0;
		if ( count _crew > 0 ) then
		{
			_crewcost = (unitDefs select (_crew select 1)) select udCost;
			_crewbuildtime = (unitDefs select (_crew select 1)) select udBuildTime;
		};

		_cost = (_unitDesc select udCost);
		_buildTime = _unitDesc select udBuildTime;

		_bVehicle = false;
		if ( !(_model isKindOf "Man")) then
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

			_cost = _cost + _unitsToBuild*_crewcost;
			_buildTime = _buildTime + _unitsToBuild*_crewbuildtime;
		};

		_grpJoin = (groupMatrix select _si) select _giJoin;
		_grpSize = (count units _grpJoin);

		if ((_grpSize + _unitsToBuild) > maxGroupSize) then
		{
			_queue set [0, 0];
			_queue = _queue - [0];
			(_queues select _qi) set [2, _queue];
			_queue = (_queues select _qi) select 2;
			publicVariable "factoryQueues";

			(groupUnitsBuildingMatrix select _si) set [_giJoin, ((groupUnitsBuildingMatrix select _si) select _giJoin) - _unitsToBuild];

			if ( !_cancelled ) then
			{
				_nul = [_type, _si, _giBuyer, _giJoin] execVM "Server\Info\GroupFull.sqf";
			};

		}
		else
		{

			_money = (groupMoneyMatrix select _si) select _giBuyer;
			if (_money < _cost) then
			{
				_queue set [0, 0];
				_queue = _queue - [0];
				(_queues select _qi) set [2, _queue];
				_queue = (_queues select _qi) select 2;
				publicVariable "factoryQueues";

				(groupUnitsBuildingMatrix select _si) set [_giJoin, ((groupUnitsBuildingMatrix select _si) select _giJoin) - _unitsToBuild];

				if ( !_cancelled ) then
				{
					_nul = [_type, _si, _giBuyer, _giJoin] execVM "Server\Info\NoMoneyUnit.sqf";
				};

			}
			else
			{

				_queue set [0, 0];
				_queue = _queue - [0];
				(_queues select _qi) set [2, _queue];
				_queue = (_queues select _qi) select 2;
				publicVariable "factoryQueues";

				if ( !_cancelled ) then
				{

					[_si, _giBuyer, _cost] call funcMoneySpend;
					[_type, _si, _giBuyer, _giJoin] execVM "Server\Info\UnitBuilding.sqf";

					if ( _buildtime < 1 ) then
					{
						_buildtime = 1;
					};

					_st = time + _buildTime*UnitBuildTimeFactor;
					while {time < _st && alive _factory}do
					{
						_factory setVariable ["rbtime",["BUILDING", _st - time],true];
						sleep 1;
					};

					_grpJoin = (groupMatrix select _si) select _giJoin;
					_grpSize = (count units _grpJoin);

					if ((_grpSize + _unitsToBuild) > maxGroupSize) then
					{
						[_si, _giBuyer, -_cost] call funcMoneySpend;
						[_type, _si, _giBuyer, _giJoin] execVM "Server\Info\GroupFull.sqf";
						(groupUnitsBuildingMatrix select _si) set [_giJoin, ((groupUnitsBuildingMatrix select _si) select _giJoin) - _unitsToBuild];
					}
					else
					{
						if (alive _factory) then
						{
							_res = [_factory, _typeStructure, _si] call funcCalcUnitPlacementPosDir;
							_posUnit = _res select 0;
							_dirUnit = _res select 1;

							pvAddUnit = [_type, _driver, _gunner, _commander, _posUnit, _dirUnit, _si, _giJoin, [], "NONE", true, true];
							publicVariable "pvAddUnit";
							[pvAddUnit] spawn MsgAddUnit;

							[_type, _si, _giBuyer, _giJoin] execVM "Server\Info\UnitPlaced.sqf";

						};

						(groupUnitsBuildingMatrix select _si) set [_giJoin, ((groupUnitsBuildingMatrix select _si) select _giJoin) - _unitsToBuild];

						_st = time + _buildCycleTime*FactoryPrepareTimeFactor;
						while {time < _st && alive _factory}do
						{
							_factory setVariable ["rbtime",["CLEANUP",_st - time],true];
							sleep 1;
						};

					};
				};

			};

		};

	};
};

