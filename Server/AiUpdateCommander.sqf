if ( isServer ) then
{

	_unit = _this select 0;
	_si = _this select 1;
	_gi = _this select 2;

	_SiGi = [_si,_gi,-2];

	_group = (groupMatrix select _si) select _gi;

	waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
	waitUntil {!(isNull mhqWest) && !(isNull mhqEast)};

	_nextBuildingTime = time;
	_saveMoney = false;
	_lastMoneyTransfer = time;

	_base = baseDefs select ((random (count baseDefs)) - 0.5);
	_baseprims = + _base select 0;
	_basesecs = + _base select 1;

	_timeCheckNextUpgrade = (2*60);
	_timeCheckSupport = time + timeCheckSupport + random(timeCheckSupport);
	_timeCheckOrders = 30;
	_timeCheckTpWaypoint = 0;

	_attackStart = time;
	_attackStartTowns = {(_x select tdSide) == _si}count towns;
	_bestTarget = objNull;

	_money = (groupMoneyMatrix select _si) select _gi;
	_currentOrder = "TakeFirstTown";
	if ( ( {	(_x select tdSide) == _si}count towns > 1) || _money > 50000 ) then {_currentOrder = "InitOrders";};

	_mhq = [mhqWest, mhqEast] select (_si == siEast);

	_posStart = getPos _mhq;
	_dirBase = getDir _mhq;

	if ( count(BaseMatrix select _si) == 0 ) then {[0, getPos _mhq, _si, _gi] call funcSetWaypointCO;}
	else {[0, (BaseMatrix select _si) select 0, _si, _gi] call funcSetWaypointCO;};

	_playerGroups = [];

	_transport = "None";
	_transportGI = -1;
	_checkClass = "";

	_townsTotal = count towns;

	if ( _si == siWest ) then {pvPlayerIncomeRatioWest = 0.2; publicVariable "pvPlayerIncomeRatioWest";};
	if ( _si == siEast ) then {pvPlayerIncomeRatioEast = 0.2; publicVariable "pvPlayerIncomeRatioEast";};

// special case when an ai group leader becomes co
	_unitsStarted = (units _group) - [_unit];
	_idOrder = ((orderMatrix select _si) select _gi) select 0;

	_mhq = [mhqWest, mhqEast] select (_si == siEast);

	_lastStructs = (structMatrix select _si);

	_lastBarracksCount = count ([_si, stBarracks] call funcGetWorkingStructures);
	_lastLightCount = count ([_si, stLight] call funcGetWorkingStructures);
	_lastHeavyCount = count ([_si, stHeavy] call funcGetWorkingStructures);
	_lastAirCount = count ([_si, stAir] call funcGetWorkingStructures);

	_avgCarPrice = (unitsAvgPrice select _si) select utbCars;
	_avgLightPrice = (unitsAvgPrice select _si) select utbTanksLight;
	_avgHeavyPrice = (unitsAvgPrice select _si) select utbTanksHeavy;
	_avgChopperPrice = (unitsAvgPrice select _si) select utbAttackHeli;

// dont build factories with no units in them
	{
		_factype = (_x select 0);
		if ( _factype in structsFactory ) then
		{
			_unitcount = {((_x select udSide) == _si) && ((_x select udFactoryType) == _factype)}count unitDefs;
			if (_unitcount == 0 ) then
			{
				_baseprims set [_forEachIndex, 0];
			};
		};
	}forEach _baseprims;
	_baseprims = _baseprims - [0];

// Main loop
	while {true}do
	{
		sleep 1;

		if ( (pvExtension select (siEnemy select _si) select 0) != 0 ) then
		{
			pvExtension set [_si, [time,(pvExtension select (siEnemy select _si) select 1)]];
			publicVariable "pvExtension";
		};

		_barracksCount = count ([_si, stBarracks] call funcGetWorkingStructures);
		_lightCount = count ([_si, stLight] call funcGetWorkingStructures);
		_heavyCount = count ([_si, stHeavy] call funcGetWorkingStructures);
		_airCount = count ([_si, stAir] call funcGetWorkingStructures);

		if ( _barracksCount != _lastBarracksCount && _timeCheckOrders - time > 240) then {_lastBarracksCount = _barracksCount; _timeCheckOrders = time;};
		if ( _lightCount != _lastLightCount && _timeCheckOrders - time > 240) then {_lastLightCount = _lightCount; _timeCheckOrders = time;};
		if ( _heavyCount != _lastHeavyCount && _timeCheckOrders - time > 240) then {_lastHeavyCount = _heavyCount; _timeCheckOrders = time;};
		if ( _airCount != _lastAirCount && _timeCheckOrders - time > 240) then {_lastAirCount = _airCount; _timeCheckOrders = time;};

		if ( leader _group != ((units _group) select 0)) then {_group selectLeader ((units _group) select 0);};
		_unit = leader _group;

		_income = 0;

		{
			_townSide = (_x select tdSide);
			_val = round((_x select tdValue)*TownIncomeFactor);

			if (_townSide == _si) then
			{
				_income = _income + _val;
			}
		}forEach towns;

		if ( isPlayer _unit || _group != (groupCommander select _si)) exitWith
		{
			_unit = leader _group;
			_vehicle = vehicle _unit;

			[_unit] call funcEjectUnit;

			_money = (groupMoneyMatrix select _si) select _gi;
			_newCOGI = giCO select _si;
			[_si, _gi, _newCOGI, _money] call funcMoneyTransfer;

			if ( _group in (groupAiMatrix select _si) ) then
			{
				_nul = [_unit, _si, _gi] spawn scriptAiUpdateLeader;
			};
		};

		if ( _idOrder != ((orderMatrix select _si) select _gi) select 0 ) then
		{
			_idOrder = ((orderMatrix select _si) select _gi) select 0;
			_unitsStarted = [];
		};

		_unitsStarted = _unitsStarted - [objNull];
		_unitsStart = (units _group) - _unitsStarted;

		{
			_nul = [_x, _si, _gi] spawn scriptAiStart;
			_unitsStarted set [count _unitsStarted, _x];
		}foreach _unitsStart;

		_nul = [_group] call funcLimitGroupFatigue;

		_totalMoney = 0;
		{
			_totalMoney = _totalMoney + _x;
		}forEach (groupMoneyMatrix select _si);

		_money = (groupMoneyMatrix select _si) select _gi;

		if ( !_saveMoney && time > 120 ) then
		{
			if ( _si == siWest && pvPlayerIncomeRatioWest != 0.2) then {pvPlayerIncomeRatioWest = 0.2; publicVariable "pvPlayerIncomeRatioWest";};
			if ( _si == siEast && pvPlayerIncomeRatioEast != 0.2) then {pvPlayerIncomeRatioEast = 0.2; publicVariable "pvPlayerIncomeRatioEast";};

			_c = count (groupMatrix select _si);
			_avgmoney = floor(_money / _c);
			_spend = floor(_avgmoney / 2.0);

			if ( time > _lastMoneyTransfer ) then
			{
				_lastMoneyTransfer = time + 30 + random(30);
				for [ {_i=0}, {_i<_c}, {_i=_i+1}] do
				{
					_givegroup = ((groupMatrix select _si) select _i);
					_keepmoney = 100*(2^(((aiSetting select _si) select _i) select aisKeep));

					if ( isPlayer (leader _givegroup) ) then
					{
						_keepmoney = _avgmoney;
					}
					else
					{
						if ( count(units _givegroup) >= maxGroupSize ) then
						{
							_keepmoney = _keepmoney / 2;
						};
					};

					_recmoney = (groupMoneyMatrix select _si) select _i;
					if ( _i != _gi && _recmoney < _keepmoney && _spend > 0 ) then
					{
						[_si, _gi, _i, _spend] call funcMoneyTransfer;
					};
				};
			};

			/*supportVehiclesPlaced set [_si,(supportVehiclesPlaced select _si) - [ObjNull]];
			 _tc = floor(( {	(_x select tdSide) == _si}count towns) / 2);
			 _sc = count (supportVehiclesPlaced select _si);

			 _slots = maxGroupSize - (count units ((groupMatrix select _si) select _gi) + ((groupUnitsBuildingMatrix select _si) select _gi));

			 if ( (_tc > _sc) && (count((unitsBuyAi select _si) select utbSupport) > 0)) then
			 {
			 ((aiSetting select _si) select _gi) set [aisBuy, utbSupport];
			 }
			 else
			 {
			 ((aiSetting select _si) select _gi) set [aisBuy, utbInfMixed];
			 };

			 if ( _slots > 1 || _tc > _sc ) then
			 {*/
			((aiSetting select _si) select _gi) set [aisBuy, utbInfMixed];
			_handle = [_unit, _si, _gi] spawn funcAiCheckBuyUnit;
			waitUntil {sleep 1 ; scriptDone _handle};
			//};

			// Update TPDuty Buyat
			if ( _transportGI > -1 ) then
			{
				_bat = utbMixed;
				if ( _transport == "Air") then
				{
					_bat = utbTransportAir;
				};

				if ( _transport == "Ground") then
				{
					_tpvehs = [];
					_tpg = ((groupMatrix select _si) select _transportGI);

					{
						_tpveh = vehicle _x;
						if ( (_tpveh isKindof _checkClass) && !(_tpveh in _tpvehs) ) then
						{
							_tpvehs = _tpvehs + [_tpveh];
						};
					}forEach (units _tpg);

					if ( count(_tpvehs) < AiCommTpDutyGndLimit ) then
					{
						_bat = utbTransport;
					}
					else
					{
						_bat = utbNone;
					};

				};

				if ( ((aiSetting select _si) select _transportGI) select aisBuy != _bat ) then
				{
					[_si, _transportGI, aisBuy, _bat] call funcSendAIGroupSetting;
				};

			};
		}
		else
		{
			if ( _si == siWest && pvPlayerIncomeRatioWest != 0.8) then {pvPlayerIncomeRatioWest = 0.8; publicVariable "pvPlayerIncomeRatioWest";};
			if ( _si == siEast && pvPlayerIncomeRatioEast != 0.8) then {pvPlayerIncomeRatioEast = 0.8; publicVariable "pvPlayerIncomeRatioEast";};
		};

		if ( time > _timeCheckTpWaypoint && _currentOrder == "InitOrders" ) then
		{
			_timeCheckTpWaypoint = time + 2*60;
			_transport = "None";
			if ( {	(_x select tdSide) == _si}count towns > 0 && (count towns) > 2 ) then
			{
				_fartown = (([getPos _mhq, [_si], []] call funcGetFarthestTown) select 0) select tdFlag;
				_eti = ([getPos _fartown, _si, []] call funcGetClosestEnemyTown) select 0;

				if ( _eti != -1 ) then
				{
					_enemytown = (towns select _eti) select tdFlag;
					_ot = ([getPos _enemytown, [_si], []] call funcGetClosestTown);

					if ( (_ot select 2) != -1 ) then
					{
						_ourtown = (_ot select 0) select tdFlag;

						_pos0 = getPos _enemytown;
						_pos1 = getPos _ourtown;
						_np = _pos1;

						_dp = [_pos1, _pos0] call fVectorSubstract;
						_d = sqrt([_dp,_dp] call fVectorDot);
						_dp = [_dp, 1500.0 / _d] call fVectorScale;
						_np = [_pos0, _dp] call fVectorAdd;

						_tpos = _np findEmptyPosition [20,500];

						if ( count(_tpos) == 0 ) then
						{
							_tpos = _np;
						};

						[1, _tpos, _si, _gi] call funcSetWaypointCO;

						if ( ((getPos _mhq) distance _tpos > 500) && (_lightCount > 0 || _heavyCount > 0)) then
						{
							_transport = "Ground";
						};
						if ( ((getPos _mhq) distance _tpos > 3000) && (_airCount > 0)) then
						{
							_transport = "Air";
						};
					};
				};
			};
		};

		if ( time > _timeCheckOrders ) then
		{

			if ( _currentOrder == "InitOrders") then
			{
				_currentOrder = "InitOrders";
				_timeCheckOrders = time + 20*60;

				if ( count(BaseMatrix select _si) == 0 ) then {[0, getPos _mhq, _si, _gi] call funcSetWaypointCO;}
				else {[0, (BaseMatrix select _si) select 0, _si, _gi] call funcSetWaypointCO;};

				[_si, _gi, orderPatrolArea, [0,2]] call funcSendAIGroupOrder;
				[_si, _gi, aisPickupWait, 0] call funcSendAIGroupSetting;
				[_si, _gi, aisBuy, utbMixed] call funcSendAIGroupSetting;
				[_si, _gi, aisKeep, 0] call funcSendAIGroupSetting;
				[_si, _gi, aisBuyBase, 0] call funcSendAIGroupSetting;
				[_si, _gi, aisSpeedMode, DefaultSpeedMode] call funcSendAIGroupSetting;
				[_si, _gi, aisFormation, DefaultFormation] call funcSendAIGroupSetting;

				_giList = _si call funcGetAiGroupIds;
				_giList = _giList - [_gi];
				_c = count _giList;

				for [ {_i=0}, {_i<_c}, {_i=_i+1}] do
				{
					_giSet = _giList select _i;
					_maxidx = _c - 1;

					// Force Formation if Player is not Groupleader
					_fgroup = (groupMatrix select _si) select _giSet;
					_forceFormation = false;

					if ( !isPlayer leader _fgroup ) then
					{
						{
							if ( isPlayer _x ) then
							{
								_forceFormation = true;
							};
						}forEach (units _fgroup);
					};

					if ( _forceFormation ) then
					{
						[_si, _giSet, aisSpeedMode, 1] call funcSendAIGroupSetting;
						[_si, _giSet, aisFormation, 10] call funcSendAIGroupSetting;
					}
					else
					{
						[_si, _giSet, aisSpeedMode, DefaultSpeedMode] call funcSendAIGroupSetting;
						[_si, _giSet, aisFormation, DefaultFormation] call funcSendAIGroupSetting;
					};

					[_si, _giSet, aisBuyBase, 0] call funcSendAIGroupSetting;

					if ( _i == _maxidx ) then
					{
						_transportGI = _giSet;
						if ( _transport != "None" ) then
						{
							_checkClass = "";
							if ( _transport == "Air" ) then
							{
								_checkClass = "Air";
							}
							else
							{
								_checkClass = "LandVehicle";
							};

							[_si, _giSet, aisBuy, utbNone] call funcSendAIGroupSetting;
							[_si, _giSet, aisKeep, 7] call funcSendAIGroupSetting;
							[_si, _giSet, orderTransportDuty, [0,1,2]] call funcSendAIGroupOrder;
							[_si, _giSet, aisBuyBase, 1] call funcSendAIGroupSetting;

							_tgroup = (groupMatrix select _si) select _giSet;
							_tpvehs = [];
							{
								_tveh = vehicle _x;
								if ( !(_tveh isKindOf _checkClass) ) then
								{
									_tpvehs = _tpvehs + [_tveh];
									_tgroup leaveVehicle _tveh;
									_nul = [_x] call funcEjectDisband;
								};
							}forEach units _tgroup;

							{
								_x setVariable ["isTpDuty", false, true];
								_x setVariable ["lastUsageTime", time - cleanUnitDelay + 60, false];
							}forEach _tpvehs;

						}
						else
						{
							[_si, _giSet, aisBuy, utbMixed] call funcSendAIGroupSetting;
							[_si, _giSet, aisKeep, 5] call funcSendAIGroupSetting;
							[_si, _giSet, orderTakeHoldTowns, [3,1]] call funcSendAIGroupOrder;
						};

						[_si, _giSet, aisPickupWait, 0] call funcSendAIGroupSetting;
					};

					if ( _i < _maxidx ) then
					{

						_buy = utbInfMixed + _i%5;

						if ( _buy == utbAttackHeli && ( AttackChoppersAllowed == 0 || _airCount == 0 || (_income < _avgChopperPrice*0.25 && _totalMoney < _avgChopperPrice*2) || (count((unitsBuyAI select _si) select _buy) == 0)) ) then
						{
							_buy = utbTanksHeavy;
						};
						if (_buy == utbTanksHeavy && ( HeavyArmorAllowed == 0 || _heavyCount == 0 || (_income < _avgHeavyPrice*0.25 && _totalMoney < _avgHeavyPrice*2)|| (count((unitsBuyAI select _si) select _buy) == 0)) ) then
						{
							_buy = utbTanksLight;
						};
						if ( _buy == utbTanksLight && ( LightArmorAllowed == 0 || _heavyCount == 0 || (_income < _avgLightPrice*0.25 && _totalMoney < _avgLightPrice*2)|| (count((unitsBuyAI select _si) select _buy) == 0)) ) then
						{
							_buy = utbCars;
						};
						if ( _buy == utbCars && ( CarsAllowed == 0 || _lightCount == 0 || (_income < _avgCarPrice*0.25 && _totalMoney < _avgCarPrice*2)|| (count((unitsBuyAI select _si) select _buy) == 0)) ) then
						{
							_buy = utbInfMixed;
						};

						_keep = ceil(log(((unitsMaxPrice select _si) select _buy) / 100) / log(2));

						_tgroup = (groupMatrix select _si) select _giSet;
						if ( _buy > utbInfMixed && _buy != utbAA && count(units _tgroup) >= (maxGroupSize*0.75)) then
						{
							{
								if ( _x == vehicle _x && _x != (leader group _x) && !(_x in playableUnits) && !(((_x getVariable "SQU_SI_GI")select 2) in typesSupport)) then
								{
									_nul = [_x] call funcEjectDisband;
								};
							}forEach units _tgroup;
						};

						[_si, _giSet, aisBuy, _buy] call funcSendAIGroupSetting;
						[_si, _giSet, aisKeep, _keep] call funcSendAIGroupSetting;
						[_si, _giSet, orderTakeHoldTowns, [3,1]] call funcSendAIGroupOrder;

						if ( _transport != "None" ) then {[_si, _giSet, aisPickupWait, 2] call funcSendAIGroupSetting;}
						else {[_si, _giSet, aisPickupWait, 0] call funcSendAIGroupSetting;};

					};

				};
			};

			if ( _currentOrder == "TakeFirstTown") then
			{
				_currentOrder = "CheckFirstTownTaken";
				_timeCheckOrders = time + 2*60;

				_res0 = [getPos _mhq, [siWest, siEast, siRes], []] call funcGetClosestTown;
				_res1 = [getPos _mhq, [siWest, siEast, siRes], [_res0 select 2]] call funcGetClosestTown;

				_ti = [_res0 select 2 ];
				if ( {	(_x select tdSide) == _si}count towns > 0 ) then
				{
					_ti = [_res0 select 2, _res1 select 2, _res1 select 2, _res1 select 2, _res1 select 2];
				};

				_playerGroups set [_si, (count (groupMatrix select _si)) - (count (groupAiMatrix select _si)) ];
				_giList = _si call funcGetAiGroupIds;
				_c = count _giList;

				for [ {_i=0}, {_i<_c}, {_i=_i+1}] do
				{
					_giSet = _giList select _i;
					_ti2 = _ti select (_i % count(_ti));
					_buy = utbMixed;

					if ( _ti2 != -1 ) then
					{
						[_si, _giSet, orderHoldTown, [_ti2,2,0]] call funcSendAIGroupOrder;
						[_si, _giSet, aisPickupWait, 0] call funcSendAIGroupSetting;
						[_si, _giSet, aisSpeedMode, DefaultSpeedMode] call funcSendAIGroupSetting;
						[_si, _giSet, aisFormation, DefaultFormation] call funcSendAIGroupSetting;
						[_si, _giSet, aisBuy, _buy] call funcSendAIGroupSetting;
						[_si, _giSet, aisKeep, 6] call funcSendAIGroupSetting;
						[_si, _giSet, aisBuyBase, 0] call funcSendAIGroupSetting;
					};
				};
			};
		};

		if ( _currentOrder == "CheckFirstTownTaken") then
		{
			_timeCheckOrders = time + 5*60;
			if ( ( {	(_x select tdSide) == _si}count towns > 1) || _money > 50000 ) then
			{
				_currentOrder = "InitOrders";
			}
			else
			{
				_currentOrder = "TakeFirstTown";
			};
		};

		if ( _currentOrder == "AttackBaseInit") then
		{
			_currentOrder = "AttackBase";
			_timeCheckOrders = time + 5*60;

			_bpos = getPos _bestTarget;

			[1, _bpos, _si, _gi] call funcSetWaypointCO;

			_v = [getPos _mhq, _bpos] call fVectorSubstract;
			_v = _v call fVectorNormalize;
			_np = [_bpos, _v, 1500] call fVectorAdd;
			_tpos = _np findEmptyPosition [20,500];
			if ( count(_tpos) == 0 ) then {_tpos = _np;};

			[2, _tpos, _si, _gi] call funcSetWaypointCO;

			_transport = "None";
			if ( ((getPos _mhq) distance _tpos > 500) && (_lightCount > 0 || _heavyCount > 0)) then
			{
				_transport = "Ground";
			};
			if ( ((getPos _mhq) distance _tpos > 3000) && (_airCount > 0)) then
			{
				_transport = "Air";
			};

			_playerGroups set [_si, (count (groupMatrix select _si)) - (count (groupAiMatrix select _si)) ];

			_giList = _si call funcGetAiGroupIds;
			_giList = _giList - [_gi];
			_c = count _giList;
			_maxidx = _c - 1;

			[_si, _gi, orderPatrolArea, [0,2]] call funcSendAIGroupOrder;
			[_si, _gi, aisPickupWait, 0] call funcSendAIGroupSetting;
			[_si, _gi, aisBuy, utbMixed] call funcSendAIGroupSetting;
			[_si, _gi, aisKeep, 0] call funcSendAIGroupSetting;
			[_si, _gi, aisBuyBase, 0] call funcSendAIGroupSetting;
			[_si, _gi, aisSpeedMode, DefaultSpeedMode] call funcSendAIGroupSetting;
			[_si, _gi, aisFormation, DefaultFormation] call funcSendAIGroupSetting;

			for [ {_i=0}, {_i<_c}, {_i=_i+1}] do
			{
				_giSet = _giList select _i;
				_tgroup = (groupMatrix select _si) select _giSet;

				if ( _i == _maxidx ) then
				{
					_transportGI = _giSet;
					if ( _transport != "None" ) then
					{
						_checkClass = "";
						if ( _transport == "Air" ) then
						{
							_checkClass = "Air";
						}
						else
						{
							_checkClass = "LandVehicle";
						};

						[_si, _giSet, aisBuy, utbNone] call funcSendAIGroupSetting;
						[_si, _giSet, aisKeep, 7] call funcSendAIGroupSetting;
						[_si, _giSet, orderTransportDuty, [0,2,2]] call funcSendAIGroupOrder;

						_tpvehs = [];
						{

							if ( !((vehicle _x) isKindOf _checkClass) ) then
							{
								_tpvehs = _tpvehs + [vehicle _x];
								_nul = [_x] call funcEjectDisband;
							};
						}forEach units _tgroup;

						{
							_x setVariable ["isTpDuty", false, true];
							_x setVariable ["lastUsageTime", time - cleanUnitDelay + 60, false];
						}forEach _tpvehs;

					};

					[_si, _giSet, aisPickupWait, 0] call funcSendAIGroupSetting;
					[_si, _giSet, aisSpeedMode, DefaultSpeedMode] call funcSendAIGroupSetting;
					[_si, _giSet, aisFormation, DefaultFormation] call funcSendAIGroupSetting;
					[_si, _giSet, aisBuyBase, 0] call funcSendAIGroupSetting;
				}
				else
				{
					[_si, _giSet, orderPatrolArea, [1,2]] call funcSendAIGroupOrder;
					//[_si, _giSet, orderAdvance, [1]] call funcSendAIGroupOrder;
					[_si, _giSet, aisPickupWait, 5] call funcSendAIGroupSetting;
					[_si, _giSet, aisSpeedMode, DefaultSpeedMode] call funcSendAIGroupSetting;
					[_si, _giSet, aisFormation, DefaultFormation] call funcSendAIGroupSetting;
					[_si, _giSet, aisBuyBase, 0] call funcSendAIGroupSetting;

					{
						if ( (vehicle _x) isKindOf "Man" ) then
						{
							_nul = [_x] call funcEjectDisband;
						};
					}forEach units _tgroup;
				};

			};
		};

		_mhq = [mhqWest, mhqEast] select (_si == siEast);

		_costWorker = costWorker;

		if (alive _mhq && _si == siWest && pvWorkersWest < floor(MaxWorkers*0.5) && _money >= _costWorker) then
		{
			[_si] spawn scriptAddWorker;
			sleep 5;
		};

		if (alive _mhq && _si == siEast && pvWorkersEast < floor(MaxWorkers*0.5) && _money >= _costWorker) then
		{
			[_si] spawn scriptAddWorker;
			sleep 5;
		};

		if ( time > _nextBuildingTime && alive _mhq ) then
		{
			_objectRespawn = [_unit, _si] call funcGetNearestRespawnObject;
			if ( call compile format["_objectRespawn != pvRespawnObjectAi%1",sideNames select _si] ) then
			{
				call compile format["pvRespawnObjectAi%1 = _objectRespawn; PublicVariable ""pvRespawnObjectAi%1""",sideNames select _si];
			};

			_nextBuildingTime = time + 5;

			_prims = + _baseprims;
			_secs = + _basesecs;

			_prims = _prims - [objNull];
			_secs = _secs - [objNull];

			{
				_buildidx = _forEachIndex;
				_x = _x - [objNull];
				{
					// Find built primary
					for [ {_i=0}, {_i<count(_prims)}, {_i=_i+1}] do
					{
						_st = _prims select _i;
						if ( (_st select 0) == _buildidx ) exitWith
						{
							_prims set [_i, objNull];
						};
					};
					_prims = _prims - [objNull];

					// Find built secondary
					for [ {_i=0}, {_i<count(_secs)}, {_i=_i+1}] do
					{
						_st = _secs select _i;

						if ( (_st select 0) == _buildidx ) exitWith
						{
							_secs set [_i, objNull];
						};

					};
					_secs = _secs - [objNull];
				}forEach _x;
			}forEach (structMatrix select _si);

			// Purge structs that have bdNightOnly flag set
			{
				if ( _x select bdNightOnly && dayTime > 6 && dayTime < 18 ) then
				{
					_prims set [_forEachIndex, objNull];
				};
			}forEach _prims;
			{
				if ( _x select bdNightOnly && dayTime > 6 && dayTime < 18 ) then
				{
					_secs set [_forEachIndex, objNull];
				};
			}forEach _secs;

			_prims = _prims - [objNull];
			_secs = _secs - [objNull];

			_buildlistPrims = [bdTime, true, _prims] call funcSort;
			_buildlistSecs = [bdTime, true, _secs] call funcSort;
			_buildlist = _prims + _secs;

			_saveMoney = false;
			{
				_buildDesc = _x;
				_structType = _buildDesc select bdType;
				_structPosRel = [_buildDesc select bdPos, _dirBase] call fVectorRot;
				_structDir = (_buildDesc select bdDir) + _dirBase;
				_timeNextPrim = _buildDesc select bdTime;
				_costNextPrim = (structDefs select _structType) select sdCost;
				_findEmpty = _buildDesc select bdFindEmpty;

				if ( _timeNextPrim < 0 && _structType in structsFactory ) then
				{
					_avgFacPrice = ((factoryAvgPrice select _si) select _structType) * abs(_timeNextPrim);
					_timeNextPrim = time + 1000;

					if ( _income > _avgFacPrice*0.25 || ((_totalMoney - _costNextPrim) > _avgFacPrice*10 && _money > _costNextPrim)) then
					{
						_timeNextPrim = 0;
					};
				};

				if ( time > _timeNextPrim && _money < _costNextPrim ) then
				{
					_saveMoney = true;
				};

				if ( !_saveMoney || (_structType in structsCritical) ) then
				{
					if ( ((time > _timeNextPrim && _money > _costNextPrim)) ) exitWith
					{
						_posStructO = [(_posStart select 0) + (_structPosRel select 0), (_posStart select 1) + (_structPosRel select 1) ];
						_posStruct = _posStructO;

						if ( _findEmpty ) then
						{
							_found = false;
							_trys = 0;

							while {!_found && _trys < 100}do
							{
								_posStruct = [_posStructO, 150] call funcFindFlatEmptyPos;
								_nstruct = [_posStruct] call funcGetNearestStructure;
								_dist = 10000;
								if ( count(_nstruct) > 2 ) then {_dist = _nstruct select 2;};

								if ( _dist < 10 || count(_posStruct nearRoads 15) > 0 || isOnRoad _posStruct ) then
								{
									_posStructO = [_posStruct, 10, 50, true, objNull] call funcGetRandomPos;
								}
								else
								{
									_found = true;
								};
								_trys = _trys + 1;
							};
						};

						_money = (groupMoneyMatrix select _si) select _gi;
						if ( _money >= _costNextPrim && (alive _mhq) ) then
						{
							if ( _structType in structsCritical ) then
							{
								_structDir = [_posStruct, getPos _mhq] call funcCalcAzimuth;
								if((count (BaseMatrix select _si))== 0 && (_si == siWest))then {pvbase1W = true;publicVariable "pvbase1W";};
								if((count (BaseMatrix select _si))== 0 && (_si == siEast))then {pvbase1E = true;publicVariable "pvbase1E";};
								_nextBuildingTime = time + 30;
							}
							else
							{
								_nextBuildingTime = time;
							};

							[_structType, _si, _gi, _posStruct, _structDir] call funcBuildStruct;
						};
					};
				};
			}forEach _buildlist;
		};

		// Enemy base found?		
		if ( _currentOrder != "AttackBase" && (_money > 50000 || {(_x select tdSide) == _si}count towns > 5) && ( {(_x select tdSide) == _si}count towns > 2 || count towns < 3) ) then
		{
			_units = [];
			{
				_units = _units + [leader _x];
			}forEach (groupMatrix select _si);

			_targets = [];
			_tsi = -1;

			if ( _si == siWest ) then {_targets = [mhqEast]; _tsi = siEast};
			if ( _si == siEast ) then {_targets = [mhqWest]; _tsi = siWest};

			{
				_crittype = _x;
				{
					_targets = _targets + [_x];
				}forEach ([_tsi,_crittype] call funcGetWorkingStructures);
			}forEach structsCritical;

			{
				_bestTarget = [_x, _targets] call funcBestTarget;
				if ( !isNull _bestTarget ) exitWith
				{
					_currentOrder = "AttackBaseInit";
					_timeCheckOrders = time;
					_attackStart = time;
					_attackStartTowns = {(_x select tdSide) == _si}count towns;
				};
				sleep 0.01;
			}forEach _units;
		};

		if ( _currentOrder == "AttackBase" ) then
		{
			_tcount = {(_x select tdSide) == _si}count towns;
			if ( ((time - _attackStart) > 60*60) || (_attackStartTowns - _tcount) > 5 ) then
			{
				_currentOrder = "InitOrders";
				_timeCheckOrders = time;
			};
		};

		if (time > _timeCheckSupport) then
		{
			_nul = [_unit, _si, _gi] spawn funcAiCheckSupport;
			_timeCheckSupport = time + timeCheckSupport + random(timeCheckSupport);
		};

		if ( time > _timeCheckNextUpgrade && !_saveMoney ) then
		{
			_abort = true;
			_money = (groupMoneyMatrix select _si) select _gi;
			for [ {_i=0}, {_i<count (upgMatrix select _si)}, {_i=_i+1}] do
			{
				if ( _abort ) then
				{
					_upgprice = ((upgMatrix select _si) select _i) select 1;

					if ((((upgMatrix select _si) select _i) select 3) == 0 && (_upgprice*10 < _money || _income*5 > _upgprice) && _money >= _upgprice) then
					{

						_tgCount = 0;
						{
							if ( !(_forEachIndex in RegularUpgrades) && ((_x select 3) > 0 || (_x select 4) > 1)) then
							{
								_tgCount=_tgCount+1;
							};
						}forEach (upgMatrix select _si);

						if ( !(!(_i in RegularUpgrades) && (((upgMatrix select _si) select _i) select 4 <= 1 ) && _tgCount >= MaxTownGroups)) then
						{
							_nul = [_i, _si] execVM "Server\StartUpgrade.sqf";
							_abort = false;
						};
					};
				};
			};

			_timeCheckNextUpgrade = time + (2*60);
		};

		if ( !(alive _mhq) ) then
		{
			_saveMoney = true;
			if ( _money > costRepairMHQ ) then
			{
				_nul = [[_gi, _si]] execVM "Server\RepairMHQ.sqf";
			};
		};

		// Handle money requests
		if ( !_saveMoney) then
		{
			_nul = [_si,_gi] call funcHandleMoneyRequests;
		};

	};

};

