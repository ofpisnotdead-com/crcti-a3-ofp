if ( isServer ) then
{

	_leader = _this select 0;
	_si = _this select 1;
	_gi = _this select 2;

	waitUntil {(InsertionState select _si) > 1};

	_SiGi = [_si,_gi,-2, false];
	_leader setVariable["SQU_SI_GI", _SiGi,true];

	_group = (groupMatrix select _si) select _gi;
	_giList = [];

	_group setFormation "LINE";
	_leader call funcRandomSkill;

	_nextsitrep = time + 120 + random(60);

	unassignVehicle _leader;
	[_leader] orderGetIn false;
	[_leader] allowGetIn false;

	detach _leader;
	[[_leader, ""], "funcSwitchMove", true, false, true] call BIS_fnc_MP;

	if ( _group == (groupCommander select _si) ) then
	{
		_leader setUnitRank "MAJOR";
		_nul = [_leader, _si, _gi] spawn scriptAiUpdateCommander;
	}
	else
	{
		_leader setUnitRank "CAPTAIN";

		_idOrder = -1;
		_leadersStarted = [];
		_posSpawn = getPos _leader;

		while {true}do
		{
			_u0 = ((units _group) select 0);
			if ( rating _u0 < -2000 ) then {_u0 addRating (-2000 - (rating _u0));};
			if ( leader _group != _u0 ) then {_group selectLeader _u0;};
			_leader = _u0;

			if ( isPlayer _leader ) exitWith {};

			if ( _group == (groupCommander select _si) ) exitWith
			{
				_leader setUnitRank "MAJOR";
				_nul = [_leader, _si, _gi] spawn scriptAiUpdateCommander;
			};

			{
				if ( !(alive _x) ) then
				{
					_leadersStarted = _leadersStarted - [_x];
				};
			}forEach _leadersStarted;

			if ( _idOrder != ((orderMatrix select _si) select _gi) select 0 ) then
			{
				_idOrder = ((orderMatrix select _si) select _gi) select 0;
				_leadersStarted = [];
			};

			_leadersStarted = _leadersStarted - [objNull];
			_leadersStart = (units _group) - _leadersStarted;

			{
				if ( _x getVariable ["aist", -1] == -1 ) then {_x setVariable ["aist", time + 5 + random(5)];};
				_st = _x getVariable ["aist", -1];

				if (alive _x && (_x == (driver vehicle _x)) && time > _st ) then
				{
					_nul = [_x, _si, _gi] spawn scriptAiStart;
					_leadersStarted = _leadersStarted + [_x];
				};
			}foreach _leadersStart;

			_money = (groupMoneyMatrix select _si) select _gi;
			_keepmoney = (100*(2^(((aiSetting select _si) select _gi) select aisKeep)));

			if ( count(units _group) >= maxGroupSize ) then
			{
				_keepmoney = _keepmoney / 2;
			};

			if (_money > _keepmoney ) then
			{
				_givemoney = _money - _keepmoney;
				if (_givemoney < 0) then {_givemoney = 0;};
				[_si, _gi, giCO select _si, _giveMoney] call funcMoneyTransfer;
			};

			_nul = [_si,_gi] call funcHandleMoneyRequests;

			if ( (((aiSetting select _si) select _gi) select aisBuy) > 0 && _money > 0 && alive _leader && !isNull _leader) then
			{
				_handle = [_leader, _si, _gi] spawn funcAiCheckBuyUnit;
				waitUntil {scriptDone _handle};
			};

			if ( time > _nextSitrep && count ([_si, stComm] call funcGetWorkingStructures) > 0 && MapMode < 3) then
			{
				_nul = [_gi,_si] execVM "Common\SendSitrep.sqf";
				_nextSitrep = time + SitrepInterval + random(SitrepInterval);
			};

			_nul = [_group] call funcLimitGroupFatigue;
			_nul = [_group, _si] spawn scriptCheckTargets;

			sleep 2.5 + random(5);
		};

	};

};

