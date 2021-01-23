// args: [unit, tanks, timePatrol]

if ( isServer ) then
{
	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};
	waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
	waitUntil {!isNull mhqWest && !isNull mhqEast};

	_vehicles = 3 + random(4);
	_timePatrol = 5 + random(15);
	_nextPatrol = time;

	_si = siRes;
	_group = createGroup Resistance;

	_typeList = (armorTown select _si) + (apcTown select _si) + (carTown select _si);

	if ( count _typeList > 0 ) then
	{
		// GenStartPos  
		_posStart = [posCenter, 0, townsRadius * 0.75, false, objNull] call funcGetRandomPos;
		while {(surfaceIsWater _posStart) || ([_posStart, getPos mhqwest] call funcDistH) < spawnDistance || ([_posStart, getPos mhqeast] call funcDistH) < spawnDistance}do
		{
			_posStart = [posCenter, 0, townsRadius * 0.75, false, objNull] call funcGetRandomPos;
		};

		[_group, 0] setWaypointPosition [_posStart, 20];
		
		for [ {_i=0}, {_i<_vehicles}, {_i=_i+1}] do
		{
			_type = _typeList call funcGetRandomUnitType;
			if ( _type != -1 ) then
			{
				_pos = [_posStart, 10, 20, true, objNull] call funcGetRandomPos;
				_nul = [_type, 1, 1, 1, _pos, random 360, _si, -1, _group, "NONE", true, false] spawn funcAddUnit;
				sleep 1;
			};
		};

		_state = "update";
		while {_state != "finished"}do
		{
			sleep 30 + random(30);
			_group setCombatMode "RED";
			_group setBehaviour "COMBAT";
			_group setSpeedMode "FULL";

			if ( ( {	alive _x}count (units _group)) == 0 ) then
			{
				_state = "finished";
			};

			if ( time > _nextPatrol ) then
			{
				_nextPatrol = time + _timePatrol;
				_posPatrol = [posCenter, 0, townsRadius*0.75, false, objNull] call funcGetRandomPos;

				{
					if (_x == driver vehicle _x) then
					{
						[_x, _posPatrol, 10, 50] call funcMoveAI;
					};
				}foreach (units _group);
			};

			_exclude = [];
			for [ {_i=0}, {_i<count(towns)}, {_i=_i+1}] do
			{
				PatrolTownsArray set [_i,(PatrolTownsArray select _i) - [_group]];
				if ( count(PatrolTownsArray select _i) > 0 && count(towns) > 1) then
				{
					_exclude = _exclude + [_i];
				};
			};

			_res = [getPos (leader _group), siRes, _exclude] call funcGetClosestEnemyTown;
			_ti = _res select 0;

			if ( _ti != -1 ) then
			{
				PatrolTownsArray set [_ti, (PatrolTownsArray select _ti) + [_group]];

				_flag = (towns select _ti) select tdFlag;
				_name = (towns select _ti) select tdName;

				{
					if (_x == driver vehicle _x) then
					{
						[_x, getPos _flag, 4, 4 ] call funcMoveAI;
					};
				}forEach (units _group);
			};

			{
				if ( _x knowsAbout mhqWest > 2 ) then {[_x, mhqWest] call funcTargetFire;};
				if ( _x knowsAbout mhqEast > 2 ) then {[_x, mhqEast] call funcTargetFire;};
			}forEach (units _group);

		};
	};

	[_group] call funcDeleteGroup;
};