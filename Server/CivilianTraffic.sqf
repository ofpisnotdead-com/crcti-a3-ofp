if ( CivilianTrafficAmount > 0 && isServer ) then
{
	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};
	waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
	waitUntil {!(isNull mhqWest) && !(isNull mhqEast)};

	_towns = _this;
	_si = siCiv;
	_group = grpNull;

	_vehicles = [];
	_c = count(_towns)*CivilianTrafficAmount*0.5;
	for [ {_i=0}, {_i<_c}, {_i=_i+1}] do
	{
		_town = _towns select floor(random(count(_towns)));
		_pos = position (_town select tdFlag);
		_vehicles = _vehicles + [[objNull, objNull, _pos, _pos, time, false]];
	};

	while {true}do
	{
		{
			_vehicle = _x select 0;
			_driver = _x select 1;
			_startPos = _x select 2;
			_endPos = _x select 3;
			_lastt = _x select 4;
			_spawned = _x select 5;

			// Spawn vehicles
			if ( !_spawned && averageFPS > 20 && time > cleanTime ) then
			{
				_type = (carTown select _si) call funcGetRandomUnitType;

				if ( _type != -1 ) then
				{
					if ( isNull _group ) then {_group = createGroup Civilian; [_group, 0] setWaypointPosition [posCenter, 20];};

					_pos = [_startPos, 20, 150, true, objNull] call funcGetRandomPos;
					_res = [_type, 1, 0, 0, _pos, random 360, _si, -1, _group, "NONE",true, false] call funcAddUnit;

					_x set [0, _res select 0];
					_x set [1, _res select 1];
					_x set [2, _pos];
					_x set [3, _pos];
					_x set [4, time];
					_x set [5, true];

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

			// Despawn if Server FPS low or kill triggered
			if ( _spawned && (averageFPS < 15 || time < cleanTime) ) then
			{
				_x set [2, getPos _vehicle];

				deleteVehicle _vehicle;
				deleteVehicle _driver;

				_x set [0, objNull];
				_x set [1, objNull];
				_x set [5, false];
			};

			if ( _driver != driver _vehicle ) then
			{
				[_driver] allowGetIn true;
				[_driver] orderGetIn true;				
				_driver assignAsDriver _vehicle;
			};

			// Go dude!
			if ( alive _vehicle && alive _driver && (_driver == driver _vehicle)) then
			{
				_x set [4, time];
				_lastt = time;

				_driver setDamage 0;
				_vehicle setDamage 0;
				[_vehicle, 1.0] call funcSetFuel;

				if ( (getPos _vehicle) distance (_endPos) < 200 ) then
				{
					_town = towns select floor(random(count(towns)));
					_endPos = [position (_town select tdFlag), 5, 250, true, _vehicle] call funcGetRandomPos;
					_x set [3, _endPos];
				};

				if ( unitReady _driver ) then
				{
					_driver doFollow _driver;

					[_driver, _endPos] call funcMoveAI;

					_driver setSpeedMode "FULL";
					_driver setCombatMode "BLUE";
				};
			};

			// Disband if not alive
			if ( (time - _lastt) > 300 ) then
			{
				_nul = [_driver] call funcEjectDisband;

				_x set [0, objNull];
				_x set [1, objNull];
				_x set [5, false];
			};

			sleep 2 + random(2);
		}forEach _vehicles;
	};
};