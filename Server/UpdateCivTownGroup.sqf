// [pos, amount inf, amount vehicles]
if ( isServer ) then
{

	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};
	waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
	waitUntil {!(isNull mhqWest) && !(isNull mhqEast)};

	_si = siCiv;
	_group = grpNull;

	_inf = round(1 + random(5));
	_inf = _inf * CiviliansAmount;
	_posFlag = _this select 0;
	_town = _this select 1;

	_state = "checkspawn";

	_nextmove = time;

	while {_state != "finished"}do
	{
		sleep 10 + random(10);

		_groupdist = ((_town select tdMinDist) select siWest) min ((_town select tdMinDist) select siEast);

		if ( _state == "checkspawn") then
		{
			if (_groupdist < CivilianSpawnDist) then
			{
				_state = "spawn";
			};
		};

		if ( _state == "spawn") then
		{
			if ( isNull _group ) then {_group = createGroup Civilian; [_group, 0] setWaypointPosition [_posFlag, 20];};

			// spawn inf
			for[ {_i=0}, {_i<_inf}, {_i=_i+1}] do
			{
				_type = (infTown select _si) call funcGetRandomUnitType;
				if ( _type != -1 ) then
				{
					_pos = [_posFlag, 25, 300, true, objNull] call funcGetRandomPos;
					_res = [_type, 0, 0, 0, _pos, random 360, _si, -1, _group, "NONE", true, false] call funcAddUnit;
					{
						[_x,"TARGET"] call funcDisableAI;
						[_x,"AUTOTARGET"] call funcDisableAI;
						[_x,"FSM"] call funcDisableAI;
						_x setSpeedMode "FULL";
						_x setCombatMode "BLUE";
						_x setBehaviour "CARELESS";
						_x doFollow _x;
					}forEach _res;

				};
			};

			_state = "update";
		};

		if ( _state == "update") then
		{
			_aliveUnits = [];
			{	if ( alive _x ) then {_aliveUnits = _aliveUnits + [_x];};}forEach (units _group);

			//diag_log format["%1: %2 units", _name, count(units _group)];
			sleep (5 + random(10));

			// move
			if ( time > _nextmove && (count(_aliveUnits) > 0)) then
			{
				_nextmove = time + random(15);

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
					if ( unitReady _movee ) then
					{
						[_movee, _posFlag, 5, 400] call funcMoveAI;
						_movee setUnitPos "AUTO";
						_movee setSpeedMode "FULL";
						_movee setBehaviour "CARELESS";
					};
				}forEach _movees;
			};

			// finish
			if (count (_aliveUnits) == 0 ) then
			{
				_state = "finished";
				_town set [tdCivState, "finished"];
			};

			if (_groupdist > CivilianSpawnDist*1.1 || averageFPS < 15 ) then
			{
				{
					deleteVehicle _x;
				}forEach (units _group);

				_state = "finished";
				_town set [tdCivState, "init"];
			};
		};

	};

	[_group] call funcDeleteGroup;
};

