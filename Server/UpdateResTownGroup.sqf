// [pos, amount inf, amount vehicles]
if ( isServer ) then
{

	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};
	waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
	waitUntil {!isNull mhqWest && !isNull mhqEast};

	_si = siRes;
	_group = grpNull;

	_infParm = (_this select 1);
	_tanksParm = (_this select 2);

	_inf = round((_infParm*0.25) + random(_infParm*0.75));
	_cars = round((_infParm*0.1) + random(_infParm*0.15));
	_static = round(random(_infParm * 0.25));

	_air = round(random(_tanksParm*0.5));

	_tanks = round((_tanksParm*0.25) + random(_tanksParm*0.75));
	_apcs = round(random(_tanks));
	_tanks = round(_tanks - _apcs);

	_lights = ceil(random(4));

	_veh = [];
	_tanksInGroup = [];

	_res = [_this select 0, [siRes, siWest, siEast], []] call funcGetClosestTown;
	_flag = (_res select 0) select tdFlag;
	_name = (_res select 0) select tdName;
	_posFlag = getPos _flag;

	_ti = _res select 2;
	_town = towns select _ti;

	_inf = round(_inf * ResistanceAmountInf);
	_cars = round(_cars * ResistanceAmountCar);
	_apcs = round(_apcs * ResistanceAmountApc);
	_tanks = round(_tanks * ResistanceAmountTank);
	_air = round(_air * ResistanceAmountAir);
	_static = round(_static * ResistanceAmountStatic);

	_hiblastt = time;

	_behaviour = "CARELESS";
	_alert = false;
	_lastalert = time;

	if ( AttackChoppersAllowed == 0 ) then
	{
		_tanks = _tanks + _air;
		_air = 0;
	};
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

	_infArray = [];
	_carArray = [];
	_apcArray = [];
	_tankArray = [];
	_airArray = [];
	_staticArray = [];
	_lightArray = [];

	// Throw the dice	
	for[ {_i=0}, {_i<_inf}, {_i=_i+1}] do
	{
		_type = (infTown select _si) call funcGetRandomUnitType;
		if ( _type != -1 ) then
		{
			_pos = [_posFlag, 25, townRadius, true, objNull] call funcGetRandomPos;
			_new = [objNull, 1, 1, 1, _type, _pos, random 360, "NONE", false, false];
			_infArray = _infArray + [_new];
		};
	};

	for[ {_i=0}, {_i<_cars}, {_i=_i+1}] do
	{
		_type = (carTown select _si) call funcGetRandomUnitType;
		if ( _type != -1 ) then
		{
			_pos = [_posFlag, 25, townRadius, true, objNull] call funcGetRandomPos;
			_new = [objNull, 1, 1, 1, _type, _pos, random 360, "NONE", false, false];
			_carArray = _carArray + [_new];
		};
	};

	for[ {_i=0}, {_i<_apcs}, {_i=_i+1}] do
	{
		_type = (apcTown select _si) call funcGetRandomUnitType;
		if ( _type != -1 ) then
		{
			_pos = [_posFlag, 25, townRadius, true, objNull] call funcGetRandomPos;
			_new = [objNull, 1, 1, 1, _type, _pos, random 360, "NONE", false, false];
			_apcArray = _apcArray + [_new];
		};
	};

	for[ {_i=0}, {_i<_tanks}, {_i=_i+1}] do
	{
		_type = (armorTown select _si) call funcGetRandomUnitType;
		if ( _type != -1 ) then
		{
			_pos = [_posFlag, 25, townRadius, true, objNull] call funcGetRandomPos;
			_new = [objNull, 1, 1, 1, _type, _pos, random 360, "NONE", false, false];
			_tankArray = _tankArray + [_new];
		};
	};

	for[ {_i=0}, {_i<_air}, {_i=_i+1}] do
	{
		_type = (airTown select _si) call funcGetRandomUnitType;
		if ( _type != -1 ) then
		{
			_pos = [_posFlag, 50, townRadius, true, objNull] call funcGetRandomPos;
			_new = [objNull, 1, 1, 1, _type, _pos, random 360, "FLY", false, false];
			_airArray = _airArray + [_new];
		};
	};

	for[ {_i=0}, {_i<_static}, {_i=_i+1}] do
	{
		_type = (staticTown select _si) call funcGetRandomUnitType;
		if ( _type != -1 ) then
		{
			_pos = [_posFlag, 50, townRadius, true, objNull] call funcGetRandomPos;
			_azimuth = [_posFlag, _pos] call funcCalcAzimuth;
			_new = [objNull, 0, 1, 1, _type, _pos, _azimuth, "NONE", false, false];
			_staticArray = _staticArray + [_new];
		};
	};

	if ((dayTime < 6) || (dayTime > 18)) then
	{
		for[ {_i=0}, {_i<_lights}, {_i=_i+1}] do
		{
			_type = (lightsTown select _si) call funcGetRandomUnitType;
			if ( _type != -1 ) then
			{
				_pos = [_posFlag, 50, townRadius, true, objNull] call funcGetRandomPos;
				_new = [objNull, 0, 1, 0, _type, _pos, random 360, "NONE", false, false];
				_lightArray = _lightArray + [_new];
			};
		};
	};

	if ( AdaptiveTownValues == 1 ) then
	{
		_value = 0;
		{
			_type = _x select 4;
			_value = _value + ((unitDefs select _type) select udCost);
		}forEach _infArray + _carArray + _apcArray + _tankArray + _airArray + _staticArray;

		_value = round(_value / 1000.0) * 50.0;

		if ( _value < 400 ) then {_value = 400;};

		_town set [tdValue, _value];
		publicVariable "towns";
	};

	// Place Sirens
	_sirens = [];
	_alc = round(1+random(3));

	for [ {_al=0}, {_al<_alc}, {_al=_al+1}] do
	{
		_sirenpos = [_posFlag, 25, 250, false, objNull] call funcGetRandomPos;
		_no = nearestObjects [_sirenpos, ["House"],100];

		if ( count(_no) > 0 ) then
		{
			_building = _no select floor(random(count(_no)));
			_sirenpos = position _building;
		};

		_siren = "Land_Loudspeakers_F" createVehicle _sirenpos;
		_siren setVectorUp [0,0,1];
		_sirens = _sirens + [_siren];
	};

	//diag_log format["%1: i:%2 c:%3 l:%4 h:%5 a:%6 s:%7, pos: %8, value: %9", _name, _inf,_cars,_apcs,_tanks,_air,_static, _posflag, (towns select _ti) select tdValue];

	_state = "checkspawn";

	if ( count(_infArray +_carArray + _apcArray +_tankArray +_airArray +_staticArray) == 0 ) then {_state = "finished";};

	_nextmove = time;
	while {_state != "finished"}do
	{
		sleep 10 + random(10);

		_groupdist = ((_town select tdMinDist) select siWest) min ((_town select tdMinDist) select siEast);

		if ( _state == "checkspawn") then
		{
			if (_groupdist < spawnDistance || (_town select tdSide) != siRes) then
			{
				_state = "spawn";
			};
		};

		/*diag_log format["%1 State: %2, %3, %4, active: %5, dist: %6, %7", _name, _state, count(units _group), _hiblastt, _active, _groupdist, str(waypoints _group)];

		 {
		 diag_log format["%1: %2 %3 %4 %5", _name, str(_x), str(vehicle(_x)), str(position _x), _x distance _posflag];
		 }forEach (units _group);*/

		if ( _state == "spawn") then
		{

			if (isNull _group) then {_group = createGroup Resistance; [_group, 0] setWaypointPosition [_posFlag, 20];};

			[_infArray, _si, -1, _group] call funcSpawnUnitArray;
			[_carArray, _si, -1, _group] call funcSpawnUnitArray;
			[_apcArray, _si, -1, _group] call funcSpawnUnitArray;
			[_tankArray, _si, -1, _group] call funcSpawnUnitArray;
			[_airArray, _si, -1, _group] call funcSpawnUnitArray;
			[_staticArray, _si, -1, _group] call funcSpawnUnitArray;
			[_lightArray, _si, -1, _group] call funcSpawnUnitArray;

			if ( AceWoundingEnabled > 0 ) then
			{
				{
					_x setVariable ["ace_w_ismedic", true];
				}forEach(units _group);
			};

			_group setBehaviour "AWARE";
			_group setCombatMode "RED";
			_group setSpeedMode "FULL";

			_state = "update";
		};

		if ( _state == "update" ) then
		{

			sleep (5 + random(5));

			_infArray = _infArray call funcUpdateUnitArray;
			_carArray = _carArray call funcUpdateUnitArray;
			_apcArray = _apcArray call funcUpdateUnitArray;
			_tankArray = _tankArray call funcUpdateUnitArray;
			_airArray = _airArray call funcUpdateUnitArray;
			_staticArray = _staticArray call funcUpdateUnitArray;
			_lightArray = _lightArray call funcUpdateUnitArray;
			
			_behaviour = "CARELESS";

			_aliveUnits = [];
			{	if ( alive _x ) then {_aliveUnits = _aliveUnits + [_x];};}forEach (units _group);

			_staticlist = [];
			{
				_v = vehicle _x;
				if ( _v isKindOf "StaticWeapon" || _v isKindof "StaticSearchLight" || _v isKindOf "Air" ) then
				{
					_staticlist = _staticlist + [_v];
				};

				if ( _x knowsAbout mhqWest > attackKnowsAbout) then {[_x, mhqWest] call funcTargetFire;};
				if ( _x knowsAbout mhqEast > attackKnowsAbout ) then {[_x, mhqEast] call funcTargetFire;};

				if ( (behaviour _x) == "COMBAT" || (behaviour _x) == "STEALTH" ) then
				{
					_behaviour = "COMBAT";
				};
			}forEach _aliveUnits;

			if ( !_alert && _behaviour == "COMBAT") then
			{
				_alert = true;
				_lastalert = time;

				if ( random(1.0) > 0.33 ) then
				{
					{
						pvSay3D = [_x, getPos _x, "siren", townRadius*4];
						publicVariable "pvSay3D";
						_nul = [pvSay3D] execVM "Player\MsgSay3D.sqf";
						sleep 5 + random(5);
					}forEach _sirens;
				};
			};

			if ( _behaviour == "CARELESS" && (time - _lastalert) > 240) then
			{
				_alert = false;
			};

			// dismount static
			if ((count(_aliveUnits) > 0) && (count(_staticlist) >= count(_aliveUnits))) then
			{
				_s = _staticlist select 0;
				_staticlist set [0, objNull];
				_staticlist = _staticlist - [objNull];
				{
					if ( vehicle _x != _x ) then {[_x] call funcEjectUnit};
				}forEach crew _s;
				sleep 1;
			};

			// move
			if ( time > _nextmove && (count(_aliveUnits) > 0) ) then
			{
				_nextmove = time + random(15);

				_movees = [];
				{
					_veh = vehicle _x;
					_driver = driver _veh;

					if ( !(_veh in _staticlist) && !(_driver in _movees)) then
					{
						_movees = _movees + [_driver];
					};
				}forEach _aliveUnits;

				{
					_movee = _x;
					_movepos = [];

					// take flag
					if (((towns Select _ti) select tdSide) != siRes) then
					{
						[_movee, _posFlag, 0, 5] call funcMoveAI;
					}
					else
					{
						if ( unitReady _movee ) then
						{
							[_movee, _posFlag, 5, townRadius*1.5] call funcMoveAI;
						};
					};

				}forEach _movees;
			};

			// finish
			if (count (_aliveUnits) == 0 ) then
			{
				_state = "finished";
			};

			// hibernate
			if ( _groupdist <= spawnDistance*1.1 ) then
			{
				_hiblastt = time;
			};

			if ( (time-_hiblastt) > 60 && ((towns Select _ti) select tdSide) == siRes) then
			{
				_infArray call funcDespawnUnitArray;
				_carArray call funcDespawnUnitArray;
				_apcArray call funcDespawnUnitArray;
				_tankArray call funcDespawnUnitArray;
				_airArray call funcDespawnUnitArray;
				_staticArray call funcDespawnUnitArray;
				_lightArray call funcDespawnUnitArray;

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

				_state = "checkSpawn";

			};

		};

	};

	_town set [tdState, "finished"];
	{	[_x, 0] call funcMoveToGarbage;}forEach _sirens;
	[_group] call funcDeleteGroup;

};

