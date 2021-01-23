if ( isServer ) then
{

	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};

	_triggerList = [];
	{
		_trigger = _x;

		// find closest flag and init stuff

		_pos = getPos _trigger;
		_res = [_pos, [siRes, siWest, siEast],[]] call funcGetClosestTown;
		_townDesc = _res select 0;
		_townName = _townDesc select tdName;

		_flag = _townDesc select tdFlag;
		_indexTown = _res select 2;
		_trigger setPos (getPos _flag);

		_lastSetSide = _townDesc select tdSide;
		_lastSide = _lastSetSide;
		_lastChange = -townScoreRebuildTime;

		_triggerList = _triggerList + [[_trigger, _indexTown, _lastSetSide, _lastSide, _lastChange, time, [0,0,0]]];

	}forEach _this;

	while {count(pvGameOver) == 0}do
	{
		{
			_trigger = _x select 0;
			_indexTown = _x select 1;
			_lastSetSide = _x select 2;
			_lastSide = _x select 3;
			_lastChange = _x select 4;
			_lastt = _x select 5;
			_holdTimes = _x select 6;

			_dt = time - _lastt;
			_x set [5, time];

			_thislist = + (list _trigger);
			if ( !isNil "_thislist" ) then
			{
				_unit = objNull;
				_units = [0,0,0];

				_groups = [[],[]];

				_count = count _thislist;

				if(_count > 0) then
				{
					for[ {_index=0}, {_index<_count}, {_index=_index+1}] do
					{
						_unit = _thislist select _index;
						if ( !isNil "_unit") then
						{
							_pos = getPos _unit;

							if(getNumber(configFile >> "CfgVehicles" >> typeof _unit >> "isUav")==0) then
							{
								if ( !isNull _unit && alive _unit && (_pos select 2) < 3 ) then
								{
									if ( (side _unit) == west ) then
									{
										_units set [siWest, (_units select siWest) + 1];
										_group = group _unit;
										if !(_group in (_groups select siWest)) then
										{
											(_groups select siWest) set [count (_groups select siWest), _group];
										};
									};

									if ( (side _unit) == east ) then
									{
										_units set [siEast, (_units select siEast) + 1];
										_group = group _unit;
										if !(_group in (_groups select siEast)) then
										{
											(_groups select siEast) set [count (_groups select siEast), _group];
										};
									};

									if ( (side _unit) == resistance ) then
									{
										_units set [siRes, (_units select siRes) + 1];
									};
								};
							};
						};
					};

					_si = -1;
					if ( ((_units select siRes) > (_units select siWest)) && ((_units select siRes) > (_units select siEast))) then
					{
						_si = siRes;
						_holdTimes set [siRes, (_holdTimes select siRes) + _dt];
						_holdTimes set [siWest, 0];
						_holdTimes set [siEast, 0];
					};
					if (((_units select siWest) > (_units select siEast)) && ((_units select siWest) > (_units select siRes))) then
					{
						_si = siWest;
						_holdTimes set [siWest, (_holdTimes select siWest) + _dt];
						_holdTimes set [siRes, 0];
						_holdTimes set [siEast, 0];
					};
					if( ((_units select siEast) > (_units select siWest)) && ((_units select siEast) > (_units select siRes))) then
					{
						_si = siEast;
						_holdTimes set [siEast, (_holdTimes select siEast) + _dt];
						_holdTimes set [siWest, 0];
						_holdTimes set [siRes, 0];
					};

					if (_si >= 0 ) then
					{
						if ( (_holdTimes select _si) > townCaptureTime && _si == _lastSide && _si != _lastSetSide) then
						{
							[_indexTown, _si, _lastSetSide] call funcSendTownSideChange;

							_x set [2, _si];
							_x set [3, _si];

							_timeFac = (time - _lastChange) / townScoreRebuildTime;
							if ( _timeFac < 0.0 ) then {_timeFac = 0.0;};
							if ( _timeFac > 1.0 ) then {_timeFac = 1.0;};
							_x set [4, time];

							if ( _si != siRes ) then
							{
								_score = ((towns select _indexTown) select tdValue) * townScoreFactor * _timeFac;
								_score = _score/(count (_groups select _si));
								_score = round(_score);

								if ( _score < 10 ) then
								{
									_score = 10;
								};

								{
									_gi = [_x, groupMatrix select _si] call funcGetIndex;

									if (_gi != -1) then
									{
										[_score, scTown, _si, _gi] spawn funcSendScore;
									};
								}foreach (_groups select _si);
							}
							else
							{
								_score = round(((towns select _indexTown) select tdValue) * townScoreFactor * _timeFac);

								if ( _score < 1 ) then
								{
									_score = 10;
								};

								[_score, scTown, _si, 0] spawn funcSendScore;
							};
						};
					}
					;
					_x set [3, _si];
				};
			};
			sleep 0.25 + random(0.25);
		}forEach _triggerList;
	};
};