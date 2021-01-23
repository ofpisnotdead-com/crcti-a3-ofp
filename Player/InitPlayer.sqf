// args: [unit, si, gi]
//player_INIT_time2 = time;
_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;

playerGroup = group _unit;
playerGroupIndex = _gi;
playerSideIndex = _si;

playerBAC = 0;
playerBACPending = 0;

_SiGi = [_si,_gi,-2, false];
_unit setVariable["SQU_SI_GI", _SiGi,true];

detach player;
[[player, ""], "funcSwitchMove", true, false, true] call BIS_fnc_MP;

SQU_MouseClick = [];

_uid = getPlayerUID _unit;

diag_log format["InitPlayer.sqf Player %1", _uid];

titleText ["Receiving ...", "BLACK", 0.01];
endLoadingScreen;
call compile format["waitUntil {!isNil""JIPWaiting%1""};", _uid];
startLoadingScreen["Wait for JIP.","RscDisplayLoadMission"];
titleFadeOut 0.01;

diag_log format["InitPlayer.sqf Player %1 Waiting.", _uid];

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

diag_log format["InitPlayer.sqf Player %1 Finish.", _uid];

call compile format["JIPWaiting%1 = 2 ; publicVariable ""JIPWaiting%1""", _uid];

startLoadingScreen["Initializing Client.","RscDisplayLoadMission"];

_abort = false;

IAMADMIN = false;
if (serverCommandAvailable "#logout" && AdminFunctionsAvailable > 0) then {IAMADMIN = true;};

_funcAbortCam =
{
	_cam = "camera" camCreate [0, 0, 200];
	camUseNVG false;

	_cam cameraEffect ["internal","back"];
	_cam camSetFOV 1;
	_cam camSetDive 0;
	_cam camSetPos [0, 0, 200];
	_cam setDir 0;
	_cam camCommit 0;
	showCinemaBorder true;
};

if ( GameMode == 1 && _si == siEast && !IAMADMIN) then
{
	call _funcAbortCam;
	forceMap false;
	_abort = true;
	waitUntil {ReceivingScreenDone};
	endLoadingScreen;
	hintC "Game is COOP West.\nYou must join West!";
	endMission "END4";
};

if ( GameMode == 2 && _si == siWest && !IAMADMIN) then
{
	call _funcAbortCam;
	forceMap false;
	_abort = true;
	waitUntil {ReceivingScreenDone};
	endLoadingScreen;
	hintC "Game is COOP East.\nYou must join East!";
	endMission "END5";
};

if ( GameMode == 0 && TeamSwitchAllowed == 0 ) then
{
	if( (getPlayerUID _unit) in (HumanIDs select (siEnemy select _si))) then
	{
		call _funcAbortCam;
		forceMap false;
		_abort = true;
		waitUntil {ReceivingScreenDone};
		endLoadingScreen;
		if ( _si == siEast ) then
		{
			hintC "Side Switching Disabled.\nYou must join West!";
			endMission "END4";
		};
		if ( _si == siWest ) then
		{
			hintC "Side Switching Disabled.\nYou must join East!";
			endMission "END5";
		};
	};
};

if ( AceServer && !AceClient ) then
{
	call _funcAbortCam;
	forceMap false;
	_abort = true;
	waitUntil {ReceivingScreenDone};
	endLoadingScreen;
	hintC "Server is running the Advanced Combat Environment.\nClient side ACE mod is required to play on this server.\nhttp://wiki.ace-mod.net/Advanced_Combat_Environment";
	endMission "END6";
};

{
	_class = _x select udModel;
	if (!isClass (configFile >> "cfgVehicles" >> _class)) exitWith
	{
		call _funcAbortCam;
		forceMap false;
		_abort = true;
		waitUntil {ReceivingScreenDone};
		endLoadingScreen;
		_text = format["You are missing vehicle classes which are required by this server:\n%1", _class];
		hintC _text;
		endMission "END6";
	};
}forEach unitDefs;

_structClasses = [];
{
	_west = _x select sdObjectsWest;
	_east = _x select sdObjectsEast;
	{
		_structClasses = _structClasses + [_x select 0];
	}forEach (_west + _east);
}forEach structDefs;

{
	_class = _x;
	if (!isClass (configFile >> "cfgVehicles" >> _class)) exitWith
	{
		call _funcAbortCam;
		forceMap false;
		_abort = true;
		endLoadingScreen;
		_text = format["You are missing structure classes which are required by this server:\n%1", _class];
		hintC _text;
		endMission "END6";
	};
}forEach _structClasses;

{
	_class = _x select edObject;
	if (!isClass (configFile >> "cfgMagazines" >> _class) && !isClass (configFile >> "cfgWeapons" >> _class)) exitWith
	{
		call _funcAbortCam;
		forceMap false;
		_abort = true;
		endLoadingScreen;
		_text = format["You are missing equipment classes which are required by this server:\n%1", _class];
		hintC _text;
		endMission "END6";
	};
}forEach equipDefs;

{
	_class = _x select wdObject;
	if (!isClass (configFile >> "cfgMagazines" >> _class) && !isClass (configFile >> "cfgWeapons" >> _class)) exitWith
	{
		call _funcAbortCam;
		forceMap false;
		_abort = true;
		endLoadingScreen;
		_text = format["You are missing weapon classes which are required by this server:\n%1", _class];
		hintC _text;
		endMission "END6";
	};
}forEach weaponDefs;

if ( ! _abort ) then
{
	forcemap true;

	// Init Structures
	startLoadingScreen["Initializing Structures.","RscDisplayLoadMission"];
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
	startLoadingScreen["Initializing Vehicles.","RscDisplayLoadMission"];
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
	startLoadingScreen["Initializing.","RscDisplayLoadMission"];
	mhqActions = [];

	//init player functions		
	funcPanMap = compile preProcessFileLineNumbers "Player\PanMap.sqf";
	funcInitInfantry = compile preProcessFileLineNumbers "Player\InitInfantry.sqf";
	funcInitVehicle = compile preProcessFileLineNumbers "Player\InitVehicle.sqf";
	funcCalcMapPos = compile "mapGridPosition _this";
	funcCalcTownDirDistFromPos = compile preProcessFileLineNumbers "Player\CalcTownDirDistFromPos.sqf";
	funcCalcAlignPosDir = compile preProcessFileLineNumbers "Player\CalcAlignPosDir.sqf";
	funcCalcScore = compile preProcessFileLineNumbers "Player\CalcScore.sqf";
	funcCalcRank = compile preProcessFileLineNumbers "Player\CalcRank.sqf";
	funcMapClickPlayer = compile preProcessFileLineNumbers "Player\MapClickPlayer.sqf";
	funcMove = compile preProcessFileLineNumbers "Player\Move.sqf";
	funcRearm = compile preProcessFileLineNumbers "Player\Rearm.sqf";
	funcSetButtonText = compile preProcessFileLineNumbers "Player\SetButtonText.sqf";
	funcTrackShell = compile preProcessFileLineNumbers "Player\TrackShell.sqf";
	funcCheckUnitSwitch = compile preProcessFileLineNumbers "Player\CheckUnitSwitch.sqf";
	funcPadNumber = compile preProcessFileLineNumbers "Player\PadNumber.sqf";
	funcBuyUnit = compile preProcessFileLineNumbers "Player\BuyUnit.sqf";
	funcHandleKey = compile preProcessFileLineNumbers "Player\HandleKey.sqf";

	scriptOpenEquipmentMenu = compile preProcessFileLineNumbers "Player\OpenEquipmentMenu.sqf";
	scriptOpenBuyUnitsMenu = compile preProcessFileLineNumbers "Player\OpenBuyUnitsMenu.sqf";

	call compile preProcessFileLineNumbers "Player\CommsMenu.sqf";

	structAction = -1;
	lastSelectedStructType = -1;
	lastSelectedUnitType = -1;
	SQCharge = 0;
	aVehiclesWithRepairAction = [];
	vehiclesRearming = [];
	giMarkersAI = count (groupMatrix select _si);
	lastArtyMessage = 0;

	defaultEqTemplates = [["Empty", [],[],[],[],[],[],[], "","","","",""],
	["Empty", [],[],[],[],[],[],[], "","","","",""],
	["Empty", [],[],[],[],[],[],[], "","","","",""],
	["Empty", [],[],[],[],[],[],[], "","","","",""],
	["Empty", [],[],[],[],[],[],[], "","","","",""],
	["Empty", [],[],[],[],[],[],[], "","","","",""],
	["Empty", [],[],[],[],[],[],[], "","","","",""]];
	eqTemplates = + defaultEqTemplates;

	lastTemplate = -1;

	bShowGroups = false;
	bShowInfo = false;

	bMannedDriver = true;
	bMannedGunner = true;
	bMannedCommander = false;

	moneySideTotal = [0, 0];
	moneySideSpent = [0, 0];

	alignWalls = false;
	mhq = objNull;

	respawnType = 10;
	respawnObject = mhq;
	DestructObject = mhq;

	lastCamUnit = objNull;

	lastSitrep = -SitrepInterval;
	CurPictureTime = time;

	// MESSAGE HANDLERS (PLAYERS)

	MsgInfo = compile preProcessFileLineNumbers "Player\MsgInfo.sqf";
	MsgMoneyStatus = compile preProcessFileLineNumbers "Player\MsgMoneyStatus.sqf";
	MsgMoneyTransferred = compile preProcessFileLineNumbers "Player\MsgMoneyTransferred.sqf";
	MsgMoneySideTotal = compile preProcessFileLineNumbers "Player\MsgMoneySideTotal.sqf";
	MsgMoneySideSpent = compile preProcessFileLineNumbers "Player\MsgMoneySideSpent.sqf";
	MsgSetTownSide = compile preProcessFileLineNumbers "Player\MsgSetTownSide.sqf";
	MsgWeather = compile preProcessFileLineNumbers "Player\MsgWeather.sqf";
	MsgSitrep = compile preProcessFileLineNumbers "Player\MsgSitrep.sqf";
	MsgSay3D = compile preProcessFileLineNumbers "Player\MsgSay3D.sqf";
	MsgArtilleryShellDetected = compile preProcessFileLineNumbers "Player\MsgArtilleryShellDetected.sqf";
	MsgPlayerKilled = compile preProcessFileLineNumbers "Player\MsgPlayerKilled.sqf";
	MsgPlayerRespawn = compile preProcessFileLineNumbers "Player\MsgPlayerRespawn.sqf";

	"pvInfo" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgInfo;};
	"pvMoney" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgMoneyStatus;};
	"pvMoneyTransfer" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgMoneyTransferred;};
	"pvMoneySideTotal" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgMoneySideTotal;};
	"pvMoneySideSpent" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgMoneySideSpent;};
	"pvTownSide" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgSetTownSide;};
	"pvCurrentWeather" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgWeather;};
	"pvSitrep" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgSitrep;};
	"pvSay3D" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgSay3D;};
	"pvArt" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgArtilleryShellDetected;};
	"pvPlayerKilled" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgPlayerKilled;};
	"pvPlayerRespawn" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgPlayerRespawn;};

	[pvCurrentWeather] spawn MsgWeather;

	// wait for mission start
	endLoadingScreen;
	forceMap true;
	sleep 1;
	startLoadingScreen["Initializing.","RscDisplayLoadMission"];

	_handle_InitMarkers = [_si,_gi] execVM "Player\InitMarkers.sqf";
	waitUntil {scriptDone _handle_InitMarkers};

	_keyeh = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call funcHandleKey;"];

	crcti_kb_initPlayerDone = true;

	posRally = [-1, -1];
	onMapSingleClick "[_pos, _units, _alt, _shift] call funcMapClickPlayer";

	waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
	waituntil {!isNull mhqWest && !isNull mhqEast};

	if((not(isNull mhqWest)) and (_si == siwest))then {[mhqWest,utMHQWest,siWest]execVM "Player\InitMHQ.sqf"};
	if((not(isNull mhqEast)) and (_si == sieast))then {[mhqEast,utMHQEast,siEast]execVM "Player\InitMHQ.sqf"};

	startLoadingScreen["Wait for placement.","RscDisplayLoadMission"];
	_nul = [_si] execVM "Player\UpdateRespawn.sqf";
	_place_handle = [_unit, _si, _gi] execVM "Common\PlaceGroupLeader.sqf";
	waitUntil {scriptDone _place_handle;};
	startLoadingScreen["Initializing.","RscDisplayLoadMission"];

	_nul = [_unit, _si, _gi] execVM "Player\UpdatePlayer.sqf";

	if ( AceWoundingEnabled > 0 ) then
	{
		_nul = player execVM "x\ace\addons\sys_wounds\fnc_unitinit.sqf";
	};

	if ( FatigueEnabled > 1 ) then {player enableFatigue true;} else {player enableFatigue false;};

	_nul = [_si] execVM "Player\UpdateUnitMarkers.sqf";
	_nul = [] execVM "Player\UpdatePlayerFatigue.sqf";
	//_nul = [] execVM "Player\Music.sqf";

	endLoadingScreen;

	_playMapAnim = true;
	call compile format["if ( !isNil""MapAnimPlayed_%1_%2"" ) then { _playMapAnim = false; };", _uid, _si];

	if ( _playMapAnim ) then
	{
		waitUntil {ReceivingScreenDone};
		call compile format["MapAnimPlayed_%1_%2 = true; publicVariable ""MapAnimPlayed_%1_%2"";", _uid, _si];

		forceMap true;
		mapAnimClear;
		_panTime = 4.0;
		if(_si == siWest)then {MapAnimAdd [_panTime, 1.0, getPos mhqWest]};
		if(_si == siEast)then {MapAnimAdd [_panTime, 1.0, getPos mhqEast]};
		mapAnimCommit;
		waituntil {mapAnimDone};
	};

	sleep 1;
	forceMap false;

	[player, playerSideIndex] execVM "Player\EquipPlayerRespawn.sqf";

	if(!isServer)then {_nul = [] execVM "Common\advancetime.sqf"};
	setDate pvDate;

	_nul = [] execVM "Player\Acre.sqf";
	_nul = [] execVM "Player\PlayerGarbageCollector.sqf";

	forceMap false;

	if ( (InsertionState select playerSideIndex) < 2 ) then
	{
		playMusic "Track10_StageB_action";
		call compile format["IntroPlayed%1 = true; publicVariable ""IntroPlayed%1"";", getPlayerUID player];
	}
	else
	{
		if ( ! CRCTIDEBUG && IntroMode > 0) then
		{
			_introhandle = [] execVM "Player\Intro.sqf";
			waitUntil {scriptDone _introhandle};
		};
	};

	waitUntil {ReceivingScreenDone};
	_nul = [objNull, 1] spawn scriptOpenEquipmentMenu;
	_dt = time + 60;
	waituntil {dialog || time > _dt};
	waituntil {! dialog};

	if ( _playMapAnim ) then
	{
		_nul = [false] execVM "Player\DisplayGameInfo.sqf";
	};
	_nul = [] execVM "Player\DisplayHint.sqf";

	if ( playerGroup == (groupCommander select playerSideIndex)) then
	{
		sleep 30;
		["You are the Commander!", false, false, htGeneral, false] call funcHint;
	};

};

