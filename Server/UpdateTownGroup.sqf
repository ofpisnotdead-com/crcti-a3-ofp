// [pos, amount inf, amount vehicles, side]
if ( isServer ) then
{
	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};
	waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
	waitUntil {!isNull mhqWest && !isNull mhqEast};

	_si = _this select 3;
	_group = grpNull;

	_infParm = _this select 1;
	_tanksParm = _this select 2;

	_inf = round((_infParm*0.2) + random(_infParm*0.2));
	_cars = ceil(random(_infParm * 0.2));

	_tanks = ceil((_tanksParm*0.2) + random(_tanksParm*0.2));
	_apcs = random(_tanks);
	_tanks = round(_tanks - _apcs);

	_cars = _cars + 1;
	_apcs = _apcs + 1;
	_tanks = _tanks + 1;

	_static = 1 + round(random(2));

	_support = 1;
	_supportType = (typesSupport select _si) select 0;

	if ( HeavyArmorAllowed == 0 ) then
	{
		_apcs = _apcs + _tanks;
		_tanks = 0;
	};
	if ( LightArmorAllowed == 0 ) then
	{
		_cars = _cars + _apcs;
		_tanks = 0;
	};
	if ( CarsAllowed == 0 ) then
	{
		_inf = _inf + _cars;
		_cars = 0;
	};

	_inf = round(_inf);
	_cars = round(_cars);
	_apcs = round(_apcs);
	_tanks = round(_tanks);
	_static = round(_static);
	_support = round(_support);

	_infArray = [];
	_carArray = [];
	_apcArray = [];
	_tankArray = [];
	_staticArray = [];
	_supportArray = [];

	_townAddDelay = 60;
	_supportAddDelay = 300;

	if ( CRCTIDEBUG ) then
	{
		_townAddDelay = 5;
		_supportAddDelay = 5;
	};

	_nextAdd = time;
	_nextSupportAdd = time + _supportAddDelay;
	_lastActive = time;

	_lastUnitCount = 0;

	_townEntry = [_this select 0, [siWest,siEast,siRes], []] call funcGetClosestTown;
	_town = _townEntry select 0;
	_ti = _townEntry select 2;
	_flag = _town select tdFlag;
	_name = _town select tdName;
	_posFlag = getPos _flag;

	_level = 0;
	_upgIdx = count (upgMatrix select _si);

	if ( MaxTownGroups > 0 ) then
	{
		_p = round(townGroupPrices select _level);
		_u = [format["%1 Towngroup", _name],_p,1,0,1];
		(upgMatrix select _si) set [_upgIdx, _u];
		publicVariable "upgMatrix";
	};

	//diag_log format["%1: i:%2 c:%3 l:%4 h:%5 s:%6, pos: %7, level: %8", _name, _inf,_cars,_apcs,_tanks,_static, _posflag, _level];

	_state = "update";

	_nextmove = time;
	while {_state != "finished"}do
	{
		//diag_log format["%1: i: %2 c:%3 l:%4 h:%5, entry: %6", _name, str(_infArray), str(_carArray), str(_apcArray), str(_tankArray), str(_townEntry)];

		if ( MaxTownGroups > 0 ) then
		{
			if ( _level == 0 && (((upgMatrix select _si) select _upgIdx) select 3) == 2 ) then
			{
				_level = _level + 1;
				_p = round((townGroupPrices select _level) * CarsAllowed);
				_u = [format["%1 Towngroup Cars", _name],_p,2,0,2];
				(upgMatrix select _si) set [_upgIdx, _u];
				publicVariable "upgMatrix";
			};
			if ( _level == 1 && (((upgMatrix select _si) select _upgIdx) select 3) == 2 ) then
			{
				_level = _level + 1;
				_p = round((townGroupPrices select _level) * LightArmorAllowed);
				_u = [format["%1 Towngroup Light Armor", _name],_p,5,0,3];
				(upgMatrix select _si) set [_upgIdx, _u];
				publicVariable "upgMatrix";

			};
			if ( _level == 2 && (((upgMatrix select _si) select _upgIdx) select 3) == 2 ) then
			{
				_level = _level + 1;
				_p = round((townGroupPrices select _level) * HeavyArmorAllowed);
				_u = [format["%1 Towngroup Heavy Armor", _name],_p,10,0,4];
				(upgMatrix select _si) set [_upgIdx, _u];
				publicVariable "upgMatrix";
			};

			if ( _level == 3 && (((upgMatrix select _si) select _upgIdx) select 3) == 2 ) then
			{
				_level = _level + 1;
			};
		};

		_aliveUnits = [];
		{	if ( alive _x ) then {_aliveUnits = _aliveUnits + [_x];};}forEach (units _group);

		// Town owner?
		_groupDist = ((_town select tdMinDist) select siWest) min ((_town select tdMinDist) select siEast);
		_groupDistEnemy = (_town select tdMinDist) select (siEnemy select _si);
		_townState = _town select tdState;
		_townSide = _town select tdSide;

		_infArray = _infArray call funcUpdateUnitArray;
		_carArray = _carArray call funcUpdateUnitArray;
		_apcArray = _apcArray call funcUpdateUnitArray;
		_tankArray = _tankArray call funcUpdateUnitArray;
		_staticArray = _staticArray call funcUpdateUnitArray;
		_supportArray = _supportArray call funcUpdateUnitArray;
		
		_unitArray = _infArray + _carArray +_apcArray +_tankArray + _staticArray + _supportArray;

		if ( count(_unitArray) < _lastUnitCount ) then
		{
			_nul = [_ti, _si] execVM "Server\Info\TownGroupLoss.sqf";
		};

		_lastUnitCount = count(_unitArray);

		if ( ! CRCTIDEBUG ) then
		{
			sleep 15 + random(15);
		}
		else
		{
			sleep 1;
		};

		if ( isNull _group ) then
		{
			if ( _si == siWest) then
			{
				_group = createGroup West;
			};
			if ( _si == siEast) then
			{
				_group = createGroup East;
			};
			[_group, 0] setWaypointPosition [_posFlag, 20];
		};

		// add support
		if ( _townSide == _si && time > _nextSupportAdd ) then
		{
			if ( (count _supportArray) < _support ) then
			{
				_type = _supportType;
				_pos = [_posFlag, 5, 25, true, objNull] call funcGetRandomPos;
				_new = [objNull, 0, 0, 0, _type, _pos, random 360, "NONE", false, false];
				_supportArray = _supportArray + [_new];
			};

			_nextSupportAdd = time + _supportAddDelay;
		};

		if ( _townSide == _si && time > _nextAdd ) then
		{
			_ex = false;
			// add inf
			if ( (count _infArray) < _inf && _level > 0) then
			{
				_type = (infTown select _si) call funcGetRandomUnitType;
				if ( _type != -1 ) then
				{
					_pos = [_posFlag, 25, 200, true, objNull] call funcGetRandomPos;
					_new = [objNull, 1, 1, 1, _type, _pos, random 360, "NONE", false, false];
					_infArray = _infArray + [_new];
					_ex = true;
				};
			};

			// add cars
			if ( CarsAllowed > 0 && _level > 1 ) then
			{
				if ( ((count _carArray) < _cars) && !_ex) then
				{
					_type = (carTown select _si) call funcGetRandomUnitType;
					if ( _type != -1 ) then
					{
						_pos = [_posFlag, 25, 200, true, objNull] call funcGetRandomPos;
						_new = [objNull, 1, 1, 1, _type, _pos, random 360, "NONE", false, true];
						_carArray = _carArray + [_new];
						_ex = true;
					};
				};
			};

			// add apcs
			if ( LightArmorAllowed > 0 && _level > 2) then
			{
				if ( ((count _apcArray) < _apcs) && !_ex) then
				{
					_type = (apcTown select _si) call funcGetRandomUnitType;
					if ( _type != -1 ) then
					{
						_pos = [_posFlag, 25, 200, true, objNull] call funcGetRandomPos;
						_new = [objNull, 1, 1, 1, _type, _pos, random 360, "NONE", false, true];
						_apcArray = _apcArray + [_new];
						_ex = true;
					};
				};
			};

			// add tanks
			if ( HeavyArmorAllowed > 0 && _level > 3) then
			{
				if ( ((count _tankArray) < _tanks) && !_ex) then
				{
					_type = (armorTown select _si) call funcGetRandomUnitType;
					if ( _type != -1 ) then
					{
						_pos = [_posFlag, 25, 200, true, objNull] call funcGetRandomPos;
						_new = [objNull, 1, 1, 1, _type, _pos, random 360, "NONE", false, true];
						_tankArray = _tankArray + [_new];
						_ex = true;
					};
				};
			};

			// add static
			if ( ((count _staticArray) < _static) && _level > 0 && !_ex) then
			{

				_type = (staticTown select _si) call funcGetRandomUnitType;
				if ( _type != -1 ) then
				{
					_pos = [_posFlag, 25, 100, true, objNull] call funcGetRandomPos;
					_azimuth = [_posFlag, _pos] call funcCalcAzimuth;
					_new = [objNull, 0, 1, 0, _type, _pos, random 360, "NONE", false, false];
					_staticArray = _staticArray + [_new];
					_ex = true;
				};
			};

			_nextAdd = time + _townAddDelay;
		};

		if ( _townSide != _si ) then
		{
			_nextAdd = time + _townAddDelay;
			_nextSupportAdd = time + _supportAddDelay;
		};

		if (_groupDistEnemy < spawnDistance || (_town select tdSide) != _si || _townState == "running" ) then
		{
			[_infArray, _si, -2, _group] call funcSpawnUnitArray;
			[_carArray, _si, -2, _group] call funcSpawnUnitArray;
			[_apcArray, _si, -2, _group] call funcSpawnUnitArray;
			[_tankArray, _si, -2, _group] call funcSpawnUnitArray;
			[_staticArray, _si, -2, _group] call funcSpawnUnitArray;
		};
		if (_groupDist < spawnDistance || (_town select tdSide) != _si || _townState == "running" ) then
		{
			[_supportArray, _si, -1, grpNull] call funcSpawnUnitArray;
		};

		// check if to despawn
		if ( _groupDistEnemy <= spawnDistance*1.1 ) then
		{
			_lastActive = time;
		};

		if ( (time-_lastActive) > 60 && (_town select tdSide) == _si && _townState != "running" ) then
		{
			_infArray call funcDespawnUnitArray;
			_carArray call funcDespawnUnitArray;
			_apcArray call funcDespawnUnitArray;
			_tankArray call funcDespawnUnitArray;
			_staticArray call funcDespawnUnitArray;

			_vlist = [];
			{
				if ( vehicle _x != _x ) then
				{
					_vlist = _vlist + [vehicle _x];
					[_x] call funcEjectUnit;
				};
				deleteVehicle _x;
			}forEach (units _group);

			{
				deleteVehicle _x;
			}forEach _vlist;
		};

		if ( _state == "update" && count(units _group) > 0 ) then
		{
			_t = objNull;
			if ( _si == siWest ) then {_t = mhqEast;};
			if ( _si == siEast ) then {_t = mhqWest;};

			{
				if ( _x knowsAbout _t > attackKnowsAbout ) then {[_x, _t] call funcTargetFire;};
			}forEach _aliveUnits;

			// move
			if ( time > _nextmove && (count(_aliveUnits) > 0) ) then
			{
				_nextmove = time + random(60);
				_movees = [];
				{
					_veh = vehicle _x;
					_driver = driver _veh;

					if ( !(_driver in _movees)) then
					{
						_movees = _movees + [_driver];
					};
				}forEach _aliveUnits;

				{
					_movee = _x;
					_movepos = [];

					// take flag
					if ((_town select tdSide) != _si) then
					{
						if ( (vehicle _movee) isKindOf "StaticWeapon" ) then {[_movee] call funcEjectUnit;};
						[_movee, _posFlag, 0, 5] call funcMoveAI;
					}
					else
					{
						_otherStatics = _posFlag nearEntities ["StaticWeapon", 500];

						_mountStatic = objNull;
						{
							if ( alive _x && someAmmo _x && isNull (assignedGunner _x) && isNull(gunner _x)) exitWith
							{
								_mountStatic = _x;
							};
						}forEach _otherStatics;

						if ( !isNull _mountStatic && ((vehicle _movee) isKindOf "Man") ) then
						{
							[_movee, _mountStatic] call funcAssignAsGunner;
						}
						else
						{
							[_movee, _posFlag,5, 500] call funcMoveAI;
						};
					};
				}forEach _movees;

			};
		};

	};
};