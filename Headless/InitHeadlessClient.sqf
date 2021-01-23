diag_log "Initializing Headless Client.";

_myHC = objNull;
if ( !isNil "HeadLessClients") then
{
	{
		if ( !isNull (_x select 0) && local(_x select 0)) exitWith
		{
			_myHC = _x select 0;
		};
	}forEach HeadLessClients;
};

_myHC setVariable ["hcinit", false, true];

_uid = getPlayerUID _myHC;

playerSideIndex=siCiv;
playerGroupIndex=0;

call compile format["waitUntil {!isNil""JIPWaiting%1""};", _uid];
diag_log format["InitHeadlessClient.sqf %1 Waiting.", _uid];

call compile format["JIP%1_mhqWest = nil;", _uid];
call compile format["JIP%1_mhqEast = nil;", _uid];
call compile format["JIP%1_Towns = nil;", _uid];
call compile format["JIP%1_BaseMatrix = nil;", _uid];
call compile format["JIP%1_structMatrix = nil;", _uid];
call compile format["JIP%1_structTimes = nil;", _uid];
call compile format["JIP%1_pvRespawnObjectAiWest = nil;", _uid];
call compile format["JIP%1_pvRespawnObjectAiEast = nil;", _uid];
call compile format["JIP%1_upgMatrix = nil;", _uid];
call compile format["JIP%1_pvDate = nil;", _uid];
call compile format["JIP%1_groupMoneyMatrix = nil;", _uid];
call compile format["JIP%1_groupScoreMatrix = nil;", _uid];
call compile format["JIP%1_orderMatrix = nil;", _uid];
call compile format["JIP%1_aiSetting = nil;", _uid];
call compile format["JIP%1_pvWorkersWest = nil;", _uid];
call compile format["JIP%1_pvWorkersEast = nil;", _uid];
call compile format["JIP%1_wpCO = nil;", _uid];
call compile format["JIP%1_HumanIDs = nil;", _uid];
call compile format["JIP%1_StructInitList = nil;", _uid];
call compile format["JIP%1_UnitInitList = nil;", _uid];

call compile format["JIPWaiting%1 = 1 ; publicVariable ""JIPWaiting%1""", _uid];

call compile format["waitUntil { !(isNil ""JIP%1_mhqWest"") };", _uid];
call compile format["mhqWest = JIP%1_mhqWest;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_mhqEast"") };", _uid];
call compile format["mhqEast = JIP%1_mhqEast;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_Towns"") };", _uid];
call compile format["Towns = JIP%1_Towns;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_BaseMatrix"") };", _uid];
call compile format["BaseMatrix = JIP%1_BaseMatrix;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_structMatrix"") };", _uid];
call compile format["structMatrix = JIP%1_structMatrix;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_structTimes"") };", _uid];
call compile format["structTimes = JIP%1_structTimes;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_pvRespawnObjectAiWest"") };", _uid];
call compile format["pvRespawnObjectAiWest = JIP%1_pvRespawnObjectAiWest;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_pvRespawnObjectAiEast"") };", _uid];
call compile format["pvRespawnObjectAiEast = JIP%1_pvRespawnObjectAiEast;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_upgMatrix"") };", _uid];
call compile format["upgMatrix = JIP%1_upgMatrix;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_pvDate"") };", _uid];
call compile format["pvDate = JIP%1_pvDate;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_groupMoneyMatrix"") };", _uid];
call compile format["groupMoneyMatrix = JIP%1_groupMoneyMatrix;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_groupScoreMatrix"") };", _uid];
call compile format["groupScoreMatrix = JIP%1_groupScoreMatrix;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_orderMatrix"") };", _uid];
call compile format["orderMatrix = JIP%1_orderMatrix;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_aiSetting"") };", _uid];
call compile format["aiSetting = JIP%1_aiSetting;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_pvWorkersWest"") };", _uid];
call compile format["pvWorkersWest = JIP%1_pvWorkersWest;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_pvWorkersEast"") };", _uid];
call compile format["pvWorkersEast = JIP%1_pvWorkersEast;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_wpCO"") };", _uid];
call compile format["wpCO = JIP%1_wpCO;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_HumanIDs"") };", _uid];
call compile format["HumanIDs = JIP%1_HumanIDs;", _uid];

call compile format["waitUntil { !(isNil ""JIP%1_StructInitList"") };", _uid];
call compile format["StructInitList = JIP%1_StructInitList;", _uid];
call compile format["waitUntil { !(isNil ""JIP%1_UnitInitList"") };", _uid];
call compile format["UnitInitList = JIP%1_UnitInitList;", _uid];

diag_log format["InitHeadlessClient.sqf %1 Finish.", _uid];

call compile format["JIPWaiting%1 = 2 ; publicVariable ""JIPWaiting%1""", _uid];

// Init Structures
{
	if ( str(_x) != "0" ) then
	{
		if (count _x == 6) then
		{
			_init_struct = _x select 0;
			if ( !isNull _init_struct ) then
			{
				_nul = [_x] spawn MsgStructBuilt;
			};
		};
	};
}forEach StructInitList;

// Init Vehicles
{
	if ( str(_x) != "0" ) then
	{
		if (count _x == 4) then
		{
			_init_unit = _x select 3;
			if ( !isNull _init_unit ) then
			{
				_nul = [_x] spawn MsgUnitBuilt;
			};
		};
	};
}forEach UnitInitList;

MsgWeather = compile preProcessFileLineNumbers "Player\MsgWeather.sqf";
"pvCurrentWeather" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgWeather;};

[pvCurrentWeather] spawn MsgWeather;

_nul = [] execVM "Common\advancetime.sqf";
setDate pvDate;

_nul = execVM "Headless\UpdateRespawnAI.sqf";
_nul = [_myHC] execVM "Headless\UpdateHC.sqf";
_nul = [] execVM "Server\UpdateLeaderDest.sqf";

diag_log format["InitHeadlessClient.sqf %1 complete.", _uid];

_myHC setVariable ["hcinit", true, true];

crcti_kb_initPlayerDone = true;