if ( isServer ) then
{
	waitUntil {(InsertionState select siWest > 1) && (InsertionState select siEast > 1)};

	_checkDist = spawnDistance * 1.1;

	while {true}do
	{
		sleep 5 + random(5);
		{
			_flagPos = getPos (_x select tdFlag);

			_nearEntities = _flagPos nearEntities ["All", _checkDist];

			_minDistWest = 10000000;
			_minDistEast = 10000000;
			if ( time > killTime ) then
			{
				{
					if ( side _x == west || side _x == sideEnemy ) then
					{
						_d = _x distance _flagPos;
						if ( _d < _minDistWest ) then
						{
							_minDistWest = _d;
						};
					};
					if ( side _x == east || side _x == sideEnemy ) then
					{
						_d = _x distance _flagPos;
						if ( _d < _minDistEast ) then
						{
							_minDistEast = _d;
						};
					};
				}forEach _nearEntities;
			};

			_x set [tdMinDist, [_minDistWest, _minDistEast]];

			//diag_log format["%1: %2 %3", _x select tdName, _x select tdState, _x select tdMinDist];

			if ( _minDistWest < spawnDistance || _minDistEast < spawnDistance) then
			{
				// Start ResTownGroup
				if ( (_x select tdState) == "init" ) then
				{
					_x set [tdState, "running"];
					[_flagPos, _x select tdInf, _x select tdVehicle] spawn scriptUpdateResTownGroup;
				};

				// Start Towngroups
				if ( TownGroupsEnabled >= 0 ) then
				{
					if ( !(_x select tdWestTownGroupStarted) && (_x select tdSide) == siWest ) then
					{
						_x set [tdWestTownGroupStarted, true];
						[_flagPos, _x select tdInf, _x select tdVehicle, siWest] spawn scriptUpdateTownGroup;
					};
					if ( !(_x select tdEastTownGroupStarted) && (_x select tdSide) == siEast ) then
					{
						_x set [tdEastTownGroupStarted, true];
						[_flagPos, _x select tdInf, _x select tdVehicle, siEast] spawn scriptUpdateTownGroup;
					};
				};

				// Add Civilians
				if ( CiviliansAmount > 0 && (_x select tdCivState) == "init" && averageFPS > 20 ) then
				{
					_x set [tdCivState, "running"];
					[_flagPos, _x] spawn scriptUpdateCivTownGroup;
				};

			};
		}forEach towns;
	};

};