// NOTE: locality of players must be determined after game start on server
_name = _this select 0;
_uid = _this select 1;
_dir = 0;

if ( _name != "__SERVER__" ) then
{
	diag_log format["JIP: onPlayerConnected() %1 (%2).", _name, _uid];

	diag_log format["JIP: WaitUntil !isNil ""InitServerDone"" (%1)",_uid];
	waitUntil {!isNil "crcti_kb_initServerDone"};
	diag_log format["JIP: WaitUntil InitServerDone (%1)",_uid];
	waitUntil {crcti_kb_initServerDone};

	call compile format["JIPWaiting%1 = 0 ; publicVariable ""JIPWaiting%1""", _uid];
	diag_log format["JIP: Waiting for %1 (%2).", _name, _uid];
	_t = time + 240;
	call compile format["while { time < _t } do { sleep 0.5 ; if ( isNil ""JIPWaiting%1"" ) exitWith{}; if ( JIPWaiting%1 == 1 ) exitWith {}; };", _uid, _uid];
	diag_log format["JIP: %1 (%2) ready.", _name, _uid];

	{
		_si = _x;
		_groups = groupMatrix select _si;

		for [ {_index=0}, {_index<count _groups}, {_index=_index+1}] do
		{
			_leader = units(_groups select _index) select 0;
			_leaderuid = getPlayerUID _leader;

			if (_uid == _leaderuid) then
			{
				if( !(_uid in (HumanIDs select siWest)) && !(_uid in (HumanIDs select siEast))) then
				{
					HumanIDs set [_si, (HumanIDs select _si) + [_uid]];
					[_si, _index, startMoneyWestPlayer] call funcMoneyAdd;
				};
				
				(scoreMoney select _si) set [_index, 0];
				(JIPUserID select _si) set [_index, _uid];				
				groupAiMatrix set [_si, (groupAiMatrix select _si) - [group _leader]];
			};
		};
	}forEach [siWest, siEast];

	publicVariable "groupAiMatrix";

	call compile format["JIP%1_mhqWest = mhqWest;", _uid];
	call compile format["publicVariable ""JIP%1_mhqWest"";", _uid];
	call compile format["JIP%1_mhqEast = mhqEast;", _uid];
	call compile format["publicVariable ""JIP%1_mhqEast"";", _uid];
	call compile format["JIP%1_Towns = Towns;", _uid];
	call compile format["publicVariable ""JIP%1_Towns"";", _uid];
	call compile format["JIP%1_BaseMatrix = BaseMatrix;", _uid];
	call compile format["publicVariable ""JIP%1_BaseMatrix"";", _uid];
	call compile format["JIP%1_structMatrix = structMatrix;", _uid];
	call compile format["publicVariable ""JIP%1_structMatrix"";", _uid];
	call compile format["JIP%1_structTimes = structTimes;", _uid];
	call compile format["publicVariable ""JIP%1_structTimes"";", _uid];
	call compile format["JIP%1_pvRespawnObjectAiWest = pvRespawnObjectAiWest;", _uid];
	call compile format["publicVariable ""JIP%1_pvRespawnObjectAiWest"";", _uid];
	call compile format["JIP%1_pvRespawnObjectAiEast = pvRespawnObjectAiEast;", _uid];
	call compile format["publicVariable ""JIP%1_pvRespawnObjectAiEast"";", _uid];
	call compile format["JIP%1_upgMatrix = upgMatrix;", _uid];
	call compile format["publicVariable ""JIP%1_upgMatrix"";", _uid];
	call compile format["JIP%1_pvDate = pvDate;", _uid];
	call compile format["publicVariable ""JIP%1_pvDate"";", _uid];
	call compile format["JIP%1_groupMoneyMatrix = groupMoneyMatrix;", _uid];
	call compile format["publicVariable ""JIP%1_groupMoneyMatrix"";", _uid];
	call compile format["JIP%1_groupScoreMatrix = groupScoreMatrix;", _uid];
	call compile format["publicVariable ""JIP%1_groupScoreMatrix"";", _uid];
	call compile format["JIP%1_orderMatrix = orderMatrix;", _uid];
	call compile format["publicVariable ""JIP%1_orderMatrix"";", _uid];
	call compile format["JIP%1_aiSetting = aiSetting;", _uid];
	call compile format["publicVariable ""JIP%1_aiSetting"";", _uid];
	call compile format["JIP%1_pvWorkersWest = pvWorkersWest;", _uid];
	call compile format["publicVariable ""JIP%1_pvWorkersWest"";", _uid];
	call compile format["JIP%1_pvWorkersEast = pvWorkersEast;", _uid];
	call compile format["publicVariable ""JIP%1_pvWorkersEast"";", _uid];
	call compile format["JIP%1_wpCO = wpCO;", _uid];
	call compile format["publicVariable ""JIP%1_wpCO"";", _uid];
	call compile format["JIP%1_HumanIDs = HumanIDs;", _uid];
	call compile format["publicVariable ""JIP%1_HumanIDs"";", _uid];
	call compile format["JIP%1_StructInitList = StructInitList;", _uid];
	call compile format["publicVariable ""JIP%1_StructInitList"";", _uid];
	call compile format["JIP%1_UnitInitList = UnitInitList;", _uid];
	call compile format["publicVariable ""JIP%1_UnitInitList"";", _uid];

	_t = time + 240;
	call compile format["while { time < _t } do { sleep 0.5 ; if ( isNil ""JIPWaiting%1"" ) exitWith{}; if ( JIPWaiting%1 == 2 ) exitWith {}; };", _uid, _uid];
	diag_log format["JIP: %1 (%2) complete.", _name, _uid];

	call compile format["JIPWaiting%1 = nil ; publicVariable ""JIPWaiting%1""", _uid];

	call compile format["JIP%1_mhqWest = nil;", _uid];
	call compile format["publicVariable ""JIP%1_mhqWest"";", _uid];
	call compile format["JIP%1_mhqEast = nil;", _uid];
	call compile format["publicVariable ""JIP%1_mhqEast"";", _uid];
	call compile format["JIP%1_Towns = nil;", _uid];
	call compile format["publicVariable ""JIP%1_Towns"";", _uid];
	call compile format["JIP%1_BaseMatrix = nil;", _uid];
	call compile format["publicVariable ""JIP%1_BaseMatrix"";", _uid];
	call compile format["JIP%1_structMatrix = nil;", _uid];
	call compile format["publicVariable ""JIP%1_structMatrix"";", _uid];
	call compile format["JIP%1_structTimes = nil;", _uid];
	call compile format["publicVariable ""JIP%1_structTimes"";", _uid];
	call compile format["JIP%1_pvRespawnObjectAiWest = nil;", _uid];
	call compile format["publicVariable ""JIP%1_pvRespawnObjectAiWest"";", _uid];
	call compile format["JIP%1_pvRespawnObjectAiEast = nil;", _uid];
	call compile format["publicVariable ""JIP%1_pvRespawnObjectAiEast"";", _uid];
	call compile format["JIP%1_upgMatrix = nil;", _uid];
	call compile format["publicVariable ""JIP%1_upgMatrix"";", _uid];
	call compile format["JIP%1_pvDate = nil;", _uid];
	call compile format["publicVariable ""JIP%1_pvDate"";", _uid];
	call compile format["JIP%1_groupMoneyMatrix = nil;", _uid];
	call compile format["publicVariable ""JIP%1_groupMoneyMatrix"";", _uid];
	call compile format["JIP%1_groupScoreMatrix = nil;", _uid];
	call compile format["publicVariable ""JIP%1_groupScoreMatrix"";", _uid];
	call compile format["JIP%1_orderMatrix = nil;", _uid];
	call compile format["publicVariable ""JIP%1_orderMatrix"";", _uid];
	call compile format["JIP%1_aiSetting = nil;", _uid];
	call compile format["publicVariable ""JIP%1_aiSetting"";", _uid];
	call compile format["JIP%1_pvWorkersWest = nil;", _uid];
	call compile format["publicVariable ""JIP%1_pvWorkersWest"";", _uid];
	call compile format["JIP%1_pvWorkersEast = nil;", _uid];
	call compile format["publicVariable ""JIP%1_pvWorkersEast"";", _uid];
	call compile format["JIP%1_wpCO = nil;", _uid];
	call compile format["publicVariable ""JIP%1_wpCO"";", _uid];
	call compile format["JIP%1_HumanNamesWest = nil;", _uid];
	call compile format["publicVariable ""JIP%1_HumanNamesWest"";", _uid];
	call compile format["JIP%1_HumanNamesEast = nil;", _uid];
	call compile format["publicVariable ""JIP%1_HumanNamesEast"";", _uid];
	call compile format["JIP%1_StructInitList = nil;", _uid];
	call compile format["publicVariable ""JIP%1_StructInitList"";", _uid];
	call compile format["JIP%1_UnitInitList = nil;", _uid];
	call compile format["publicVariable ""JIP%1_UnitInitList"";", _uid];
};