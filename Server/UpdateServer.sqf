waitUntil {!isNil "crcti_kb_initServerDone"};
waitUntil {crcti_kb_initServerDone};
waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
waitUntil {!isNull mhqWest && !isNull mhqEast};

_fpscount = [];
_fpswarnsent = 0;

_mhqWestAlive = true;
_mhqEastAlive = true;
_delay = 1;

_weathertime = time;
_lastHuman = time;
_weatherChangeDuration = [0,0];

_timeNextRemind = timeLimit - 120;

_lastFPSSent = time;
_lastVDChange = time;
_lastDiagFps = -10000;

while {count(pvGameOver) == 0}do
{
	if ( count(_fpscount) > 50 ) then
	{
		_fpscount set [0, -1];
		_fpscount = _fpscount - [-1];
	};

	if ( time > _lastDiagFps + 10 ) then
	{
		_fpscount = _fpscount + [diag_fps];
		_lastDiagFps = time;
	};

	_fpssum = 0;
	{
		_fpssum = _fpssum + _x;
	}forEach _fpscount;
	_avgfps = _fpssum / count(_fpscount);
	averageServerFPS = _avgfps;

	if ( !isNil "HeadLessClients") then
	{
		_hccount = 0;
		{
			if ( ! local (_x select 0)) then
			{
				_hcfps = (_x select 0) getVariable ["FPS", -1];

				if ( _hcfps > 0 ) then
				{
					_avgfps = _avgfps + _hcfps;
					_hccount = _hccount + 1;
				};
			};
		}forEach HeadLessClients;

		_avgfps = _avgfps / (_hccount + 1);
	};

	averageFPS = _avgfps;

	if ( _avgfps > 15 || _avgfps < 5 ) then
	{
		_fpswarnsent = 0;
	};

	if ( _fpswarnsent > 100 ) then
	{
		_fpswarnsent = 0;
	};

	if ( _avgfps > 15 && (time - _lastVDChange) > 60 && serverViewDistance < maxViewDistance ) then
	{
		serverViewDistance = serverViewDistance + 250;
		setViewDistance serverViewDistance;
		publicVariable "serverViewDistance";
		_lastVDChange = time;
	};

	if ( _avgfps < 10 && (time - _lastVDChange) > 60 && serverViewDistance > minViewDistance ) then
	{
		if ( serverViewDistance > 2000 ) then
		{
			serverViewDistance = 2000;
		}
		else
		{
			serverViewDistance = serverViewDistance - 250;
		};

		setViewDistance serverViewDistance - 100;
		sleep 1;
		setViewDistance serverViewDistance;
		publicVariable "serverViewDistance";
		_lastVDChange = time;
	};

	spawnDistance = serverViewDistance;
	if ( spawnDistance > 1500 ) then {spawnDistance = 1500;};

	_objVD = viewDistance;
	if ( _objVD > maxObjectViewDistance ) then {_objVD = maxObjectViewDistance;};
	setObjectViewDistance _objVD;

	if ( !isNull player && isServer && time < 300 ) then
	{
		["Hosting this mission on a client is not recommended! Use a dedicated server instead!", true, true, htDediWarn, true] call funcHint;
	};

	if ( _avgfps < 10 && _fpswarnsent < 10 && count(_fpscount) > 10) then
	{
		pvServerInfo = format["Warning!\nServer FPS low! (%1 FPS)\n\nTry fewer Cities, smaller Groupsize, lower Viewdistance or less Resistance/Civilians!\n(or get a faster Server)", round(_avgfps)];
		diag_log format["Low Server FPS! (%1 FPS)", round(_avgfps)];

		_nul = [pvServerInfo] execVM "Player\MsgServerInfo.sqf";
		publicVariable "pvServerInfo";

		_fpswarnsent = _fpswarnsent + 1;
	};

	if ( _avgfps < 5 ) then
	{
		pvServerInfo = format["Warning!\nServer FPS VERY LOW! (%1 FPS)\n\nTry fewer Cities, smaller Groupsize, lower Viewdistance or less Resistance/Civilians!\n(or get a faster Server)", round(_avgfps)];
		diag_log format["VERY LOW Server FPS! (%1 FPS)", round(_avgfps)];

		_nul = [pvServerInfo] execVM "Player\MsgServerInfo.sqf";
		publicVariable "pvServerInfo";
	};

	if ( time > _lastFPSSent + 60 ) then
	{
		_lastFPSSent = time;
		pvFPS = _avgfps;
		publicVariable "pvFPS";
		pvSFPS = averageServerFPS;
		publicVariable "pvSFPS";
	};

	//diag_log format["Groups: %1 Units: %2", count(allgroups), count(allunits)];

	if (pvbase1W && ((count(BaseMatrix select siWest))==0)) then
	{
		_flag = "FlagPole_F" createvehicle (getPos mhqWest);
		_flag SetFlagTexture "\a3\data_f\Flags\flag_blue_co.paa";
		_sign = "Land_Noticeboard_F" createvehicle (getPos _flag);
		_sign setDir (([getPos mhqWest, getPos _sign] call funcCalcAzimuth) + 180);
		_sign setObjectTextureGlobal [0, "Images\natobase1.paa"];
		(BaseMatrix select siWest) set [0,getPos _flag];
		publicVariable "BaseMatrix";
		pvbase1W = false;
		{	unassignVehicle _x; _x action ["EJECT", mhqWest];}foreach (crew mhqWest);
		lockMHQ set [siWest, 2];
		publicVariable "lockMHQ";
	};

	if (pvbase1E && ((count(BaseMatrix select siEast))==0)) then
	{
		_flag = "FlagPole_F" createvehicle (getPos mhqEast);
		_flag SetFlagTexture "\a3\data_f\Flags\flag_red_co.paa";
		_sign = "Land_Noticeboard_F" createvehicle (getPos _flag);
		_sign setDir (([getPos mhqEast, getPos _sign] call funcCalcAzimuth) + 180);
		_sign setObjectTextureGlobal [0, "Images\csatbase1.paa"];
		(BaseMatrix select siEast) set [0,getPos _flag];
		publicVariable "BaseMatrix";
		pvbase1E = false;
		{	unassignVehicle _x; _x action ["EJECT", mhqEast];}foreach (crew mhqEast);
		lockMHQ set [siEast, 2];
		publicVariable "lockMHQ";
	};

	if (pvbase2W && ((count(BaseMatrix select siWest))==1)) then
	{
		_flag = "FlagPole_F" createvehicle (getPos mhqWest);
		_flag SetFlagTexture "\a3\data_f\Flags\flag_blue_co.paa";
		_sign = "Land_Noticeboard_F" createvehicle (getPos _flag);
		_sign setDir (([getPos mhqWest, getPos _sign] call funcCalcAzimuth) + 180);
		_sign setObjectTextureGlobal [0, "Images\natobase2.paa"];
		(BaseMatrix select siWest) set [1,getPos _flag];
		publicVariable "BaseMatrix";
		pvbase2W = false;
		{	unassignVehicle _x; _x action ["EJECT", mhqWest];}foreach (crew mhqWest);
		lockMHQ set [siWest, 3];
		publicVariable "lockMHQ";
	};

	if (pvbase2E && ((count(BaseMatrix select siEast))==1)) then
	{
		_flag = "FlagPole_F" createvehicle (getPos mhqEast);
		_flag SetFlagTexture "\a3\data_f\Flags\flag_red_co.paa";
		_sign = "Land_Noticeboard_F" createvehicle (getPos _flag);
		_sign setDir (([getPos mhqEast, getPos _sign] call funcCalcAzimuth) + 180);
		_sign setObjectTextureGlobal [0, "Images\csatbase2.paa"];
		(BaseMatrix select siEast) set [1,getPos _flag];
		publicVariable "BaseMatrix";
		pvbase2E = false;
		{	unassignVehicle _x; _x action ["EJECT", mhqEast];}foreach (crew mhqEast);
		lockMHQ set [siEast, 3];
		publicVariable "lockMHQ";
	};

	if (((lockMHQ select siWest) > 0) && !(mhqWest call funcLocked)) then {mhqWest lock true;};
	if (((lockMHQ select siWest) == 0) && (mhqWest call funcLocked)) then {mhqWest lock false;};
	if (((lockMHQ select siEast) > 0) && !(mhqEast call funcLocked)) then {mhqEast lock true;};
	if (((lockMHQ select siEast) == 0) && (mhqEast call funcLocked)) then {mhqEast lock false;};

	{
		if ( isPlayer _x ) exitWith {_lastHuman = time;};
	}forEach playableUnits;

	if ((timeLimit > 0 && time > timeLimit) || (time > (_lastHuman + NoPlayerTimeout) && NoPlayerTimeout > 0)) then
	{
		pvGameOver = [0,0];
		publicVariable "pvGameOver";
	};

	if (_mhqWestAlive && !(alive mhqWest)) then
	{
		_mhqWestAlive = false;
		_nul = siWest spawn scriptCheckWinDestruction;
	};

	if (_mhqEastAlive && !(alive mhqEast)) then
	{
		_mhqEastAlive = false;
		_nul = siEast spawn scriptCheckWinDestruction;
	};

	if (!_mhqWestAlive && (alive mhqWest)) then {_mhqWestAlive = true;};
	if (!_mhqEastAlive && (alive mhqEast)) then {_mhqEastAlive = true;};

	if ( ((pvExtension select siWest) select 0) != 0 && ((pvExtension select siEast) select 0) != 0 ) then
	{
		_extent = (pvExtension select siWest) select 1;

		if ( (pvExtension select siEast) select 1 < _extent ) then
		{
			_extent = (pvExtension select siEast) select 1;
		};

		timeLimit = timeLimit + _extent;
		publicVariable "timeLimit";
		_timeNextRemind = (timeLimit - time) + 100;
		[_extent] execVM "Server\Info\TimeLimitExtension.sqf";
		pvExtension = [[0,0],[0,0]];
		publicVariable "pvExtension";
	};

	{
		_et_hint_si = _x;
		if ( ((pvExtension select _et_hint_si) select 0) > 0) then
		{
			[_et_hint_si,((pvExtension select _et_hint_si) select 1) ] execVM "Server\Info\ExtensionRequest.sqf";

			if ( time > (((pvExtension select _et_hint_si) select 0) + extensionRequestTimeout)) then
			{
				pvExtension set [_et_hint_si, [0,0]];
				publicVariable "pvExtension";
			};
		};
	}forEach [siWest, siEast];

	_remain = 3600*2;
	if ( timeLimit > 0 ) then
	{

		_remain = timeLimit - time;
		_intv = 0;

		if ( _remain >= 0 ) then {_intv = 1; _delay = 0.5;};
		if ( _remain >= 30 ) then {_intv = 30; _delay = 5;};
		if ( _remain >= 60 ) then {_intv = 60;};
		if ( _remain >= 300 ) then {_intv = 300;};
		if ( _remain >= 900 ) then {_intv = 900;};
		if ( _remain >= 3600 ) then {_intv = 3600;};

		_fac = floor(_remain/_intv);
		_fac = _fac * _intv;

		if ( (timeLimit-time) < _timeNextRemind ) then
		{
			[_remain] execVM "Server\Info\TimeLimitRemind.sqf";
			_timeNextRemind = _fac;
		};
	};

	if ( _remain > 3600*2 ) then
	{
		estimatedTimeLeft 7200;
	}
	else
	{
		estimatedTimeleft _remain;
	};

	if (time >= _weathertime) then
	{
		_badness = 0;
		_windy = 0;
		if (WeatherSetting == -1) then
		{
			_badness = [1.0, 4] call funcNormalRandom;
			_windy = [1.0, 4] call funcNormalRandom;
		};
		if (WeatherSetting == 0) then
		{
			_badness = 0;
			_windy = 0;
		};
		if (WeatherSetting == 1) then
		{
			_badness = [0.25, 4] call funcNormalRandom;
			_windy = [0.25, 4] call funcNormalRandom;
		};
		if (WeatherSetting == 2) then
		{
			_badness = 0.25 + ([0.25, 4] call funcNormalRandom);
			_windy = [0.5, 4] call funcNormalRandom;
		};
		if (WeatherSetting == 3) then
		{
			_badness = 0.5 + ([0.25, 4] call funcNormalRandom);
			_windy = [0.75, 4] call funcNormalRandom;
		};
		if (WeatherSetting == 4) then
		{
			_badness = 0.75 + ([0.25, 4] call funcNormalRandom);
			_windy = [1.0, 4] call funcNormalRandom;
		};
		if (WeatherSetting == 5) then
		{
			_badness = 1.0;
			_windy = [1.0, 4] call funcNormalRandom;
		};

		_wind = [(random(20) - 10)*_windy,(random(20) - 10)*_windy,true];

		_weather = [];

		if (_badness == 0) then {_weather = [0.0,0.0,0.0,0.0,_wind];};
		if (_badness > 0) then {_weather = [(_weatherChangeDuration select 0) + random(_weatherChangeDuration select 1),0.1+random(0.4),0.0,0.0,_wind];};
		if (_badness > 0.25) then {_weather = [(_weatherChangeDuration select 0) + random(_weatherChangeDuration select 1),0.2+random(0.4),random(0.25)*FogFactor,0.0,_wind];};
		if (_badness > 0.6) then {_weather = [(_weatherChangeDuration select 0) + random(_weatherChangeDuration select 1),0.5+random(0.5),(0.2+random(0.5))*FogFactor,random(0.75),_wind];};
		if (_badness > 0.8) then {_weather = [(_weatherChangeDuration select 0) + random(_weatherChangeDuration select 1),0.75+random(0.25),(0.75+random(0.25))*FogFactor,0.75+random(0.25),_wind];};
		if (_badness == 1.0) then {_weather = [(_weatherChangeDuration select 0) + random(_weatherChangeDuration select 1),0.95+random(0.05),(0.95+random(0.05))*FogFactor,0.95+random(0.05),_wind];};
		
		_nul = [_weather] spawn scriptSetWeather;

		if ( (_weatherChangeDuration select 0) == 0 ) then
		{
			_weathertime = time;
		}
		else
		{
			_weathertime = time + (weatherChangeInterval select 0) + random(weatherChangeInterval select 1);
		};

		_weatherChangeDuration = weatherChangeDuration;

	};

	// Clean Initlists
	{
		if ( isNull (_x select 3 )) then
		{
			UnitInitList set [_forEachIndex, 0];
		};
	}forEach UnitInitList;

	UnitInitList = UnitInitList - [0];

	{
		if ( isNull (_x select 0 )) then
		{
			StructInitList set [_forEachIndex, 0];
		};
	}forEach StructInitList;

	StructInitList = StructInitList - [0];

	// Respawn AI only Commander
	if ( CommSlotsLocked == 1 ) then
	{
		if ( !alive LeaderGroupAICommanderWest || isNull LeaderGroupAICommanderWest ) then
		{
			_ret = [utCrewW, 0, 0, 0, mhqWest, 0, siWest, -1, GroupAICommanderWest, "NONE", true, false] call funcAddUnit;
			LeaderGroupAICommanderWest = _ret select 0;
		};
		if ( !alive LeaderGroupAICommanderEast || isNull LeaderGroupAICommanderEast ) then
		{
			_ret = [utCrewE, 0, 0, 0, mhqEast, 0, siEast, -1, GroupAICommanderEast, "NONE", true, false] call funcAddUnit;
			LeaderGroupAICommanderEast = _ret select 0;
		};
	};

	// Update money requests
	{
		_si = _x;
		_msgs = [];
		{

			_to = _x select 0;
			_from = _x select 1;
			_amount = _x select 2;
			_lastMoney = _x select 3;
			_currentMoney = (groupMoneyMatrix select _si) select _to;
			_requestTime = _x select 4;

			if ( _amount > 0 ) then
			{
				if ( _currentMoney >= _lastMoney+_amount || time > _requestTime + 300) then
				{
					(moneyRequestsPending select _si) set [_forEachIndex, [_to,_from,0,0,0]];
				}
				else
				{
					_msgs = _msgs + [_x];
				};
			};
		}forEach (moneyRequestsPending select _si);

		if (count _msgs > 0 ) then
		{
			[_si, _msgs] execVM "Server\Info\MoneyRequest.sqf";
		};

	}forEach [siWest, siEast];

	if ( pvCleanKill == 1 ) then
	{
		cleanTime = time + 120;
		pvCleanKill = 0;
	};
	if ( pvCleanKill == 2 ) then
	{
		{
			_groups = groupMatrix select _x;
			{
				{
					if ( !(isPlayer _x)) then
					{
						_x setDamage 1;
					};
				}forEach (units _x);
			}forEach _groups;
		}forEach [siWest, siEast];
		cleanTime = time + 240;
		killTime = time + 240;
		pvCleanKill = 0;
	};

	sleep _delay;
};

diag_log "Game Ended.";

WEST setFriend [EAST,1];
WEST setFriend [WEST,1];
WEST setFriend [RESISTANCE,1];
WEST setFriend [CIVILIAN,1];

EAST setFriend [EAST,1];
EAST setFriend [WEST,1];
EAST setFriend [RESISTANCE,1];
EAST setFriend [CIVILIAN,1];

RESISTANCE setFriend [EAST,1];
RESISTANCE setFriend [WEST,1];
RESISTANCE setFriend [RESISTANCE,1];
RESISTANCE setFriend [CIVILIAN,1];

CIVILIAN setFriend [EAST,1];
CIVILIAN setFriend [WEST,1];
CIVILIAN setFriend [RESISTANCE,1];
CIVILIAN setFriend [CIVILIAN,1];

sleep 300;
endMission "END1";
forceEnd;