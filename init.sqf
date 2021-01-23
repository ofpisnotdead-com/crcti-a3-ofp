startLoadingScreen["Initializing.","RscDisplayLoadMission"];

enableSaving [true, false];

TFRAllowed = false;
if ( isClass (configFile >> "CfgWeapons" >> "tf_anprc152") ) then
{
	TFRAllowed = true;
};

if ( ((productVersion select 1) == "ArmA2OA" && (productVersion select 2) >= 162 && (productVersion select 3) >= 97127)
		|| ((productVersion select 1) == "Arma3Alpha") || ((productVersion select 1) == "Arma3")) then
{
	profileAvailable = true;
	diag_log "profileNameSpace available.";
}
else
{
	profileAvailable = false;
};

if ((productVersion select 1) == "Arma3Alpha" || (productVersion select 1) == "Arma3") then
{
	THISISARMA3 = true;
}
else
{
	THISISARMA3 = false;
};

if ( isServer ) then
{
	pvServerVersion = productVersion select 3;
	publicVariable "pvServerVersion";
};

crCTImissionName = localize "STR_MISSION_NAME";

ReceivingScreenDone = true;
onPreloadStarted 'ReceivingScreenDone = false;';
onPreloadFinished 'ReceivingScreenDone = true;';

// Precompile common functions
funcMapFaction = compile preProcessFileLineNumbers "Common\MapFaction.sqf";
funcSort = compile preProcessFileLineNumbers "Common\Sort.sqf";
funcNormalRandom = compile preProcessFileLineNumbers "Common\NormalRandom.sqf";
funcGetGroupName = compile preProcessFileLineNumbers "Common\GetGroupName.sqf";
funcAddUnit = compile preProcessFileLineNumbers "Common\AddUnit.sqf";
funcGetFarthestTown = compile preProcessFileLineNumbers "Common\GetFarthestTown.sqf";
funcGetClosestTown = compile preProcessFileLineNumbers "Common\GetClosestTown.sqf";
funcGetClosestEnemyTown = compile preProcessFileLineNumbers "Common\GetClosestEnemyTown.sqf";
funcGetIndex = compile preProcessFileLineNumbers "Common\GetIndex.sqf";
funcGetStructures = compile preProcessFileLineNumbers "Common\GetStructures.sqf";
funcGetClosestStructure = compile preProcessFileLineNumbers "Common\GetClosestStructure.sqf";
funcGetWorkingStructures = compile preProcessFileLineNumbers "Common\GetWorkingStructures.sqf";
funcCalcUnitPlacementPosDir = compile preProcessFileLineNumbers "Common\CalcUnitPlacementPosDir.sqf";
funcSortStrings = compile preProcessFileLineNumbers "Common\SortStrings.sqf";
funcGetNearbyVehicles = compile preProcessFileLineNumbers "Common\GetNearbyVehicles.sqf";
funcGetClosestVehicle = compile preProcessFileLineNumbers "Common\GetClosestVehicle.sqf";
funcGetRandomPos = compile preProcessFileLineNumbers "Common\GetRandomPos.sqf";
funcGetRandomUnitType = compile preProcessFileLineNumbers "Common\GetRandomUnitType.sqf";
funcFixDialogTitleColor = {_Dlg_Color_RoyalBlue = [0.253906,0.410156,0.878906,1]; _Dlg_Color_DeepRed = [0.45,0.000000,0.000000,1]; if (playerSide == west) then {_display = findDisplay (_this select 0); _titleCtrl = _display displayCtrl IDC_TEXT_MENU_NAME; _titleCtrl ctrlSetBackgroundColor _Dlg_Color_RoyalBlue};};
funcGetGroupComposition = compile preProcessFileLineNumbers "Player\GetGroupComposition.sqf";
funcDrawMapLine = compile preProcessFileLineNumbers "Common\DrawMapLine.sqf";
funcCalcAzimuth = compile preProcessFileLineNumbers "Common\CalcAzimuth.sqf";
funcGetNearestStructure = compile preProcessFileLineNumbers "Common\GetNearestStructure.sqf";
funcDistH = compile preProcessFileLineNumbers "Common\DistH.sqf";
funcGetNearestRespawnObject = compile preProcessFileLineNumbers "Common\GetNearestRespawnObject.sqf";
funcGetDisplayName = compile preProcessFileLineNumbers "Common\GetDisplayName.sqf";
funcGetAllGunners = compile preProcessFileLineNumbers "Common\GetAllGunners.sqf";
funcGetAllCargo = compile preProcessFileLineNumbers "Common\GetAllCargo.sqf";
funcGetAllCrewWithoutCargo = compile preProcessFileLineNumbers "Common\GetAllCrewWithoutCargo.sqf";
funcEjectUnit = compile preProcessFileLineNumbers "Common\EjectUnit.sqf";
funcEjectCargo = compile preProcessFileLineNumbers "Common\EjectCargo.sqf";
funcSendScore = compile preProcessFileLineNumbers "Common\SendScore.sqf";
funcMoveToGarbage = compile preProcessFileLineNumbers "Common\MoveToGarbage.sqf";
funcRandomSkill = compile preProcessFileLineNumbers "Common\RandomSkill.sqf";
funcBestTarget = compile preProcessFileLineNumbers "Common\GetBestTarget.sqf";
funcGetAiGroupIds = compile preProcessFileLineNumbers "Common\GetAiGroupIds.sqf";
funcGetSideAndGroup = compile preProcessFileLineNumbers "Common\GetSideAndGroup.sqf";
funcSecondsToString = compile preProcessFileLineNumbers "Common\SecondsToString.sqf";
funcGetWeaponHitValue = compile preProcessFileLineNumbers "Common\GetWeaponHitValue.sqf";
funcGetTurrets = compile preProcessFileLineNumbers "Common\GetTurrets.sqf";
funcGetVehicleWeapons = compile preProcessFileLineNumbers "Common\GetVehicleWeapons.sqf";
funcGetRearmData = compile preProcessFileLineNumbers "Common\GetRearmData.sqf";
funcLockVehicle = compile preProcessFileLineNumbers "Common\LockVehicle.sqf";
funcStringHash = compile preProcessFileLineNumbers "Common\StringHash.sqf";
funcEquipCargoCar = compile preProcessFileLineNumbers "Common\EquipCargoCar.sqf";
funcEquipCargoTruck = compile preProcessFileLineNumbers "Common\EquipCargoTruck.sqf";
funcLocked = compile preProcessFileLineNumbers "Common\Locked.sqf";
funcInitGroupMember = compile preProcessFileLineNumbers "Common\InitGroupMember.sqf";
funcSetWaypointCO = compile preProcessFileLineNumbers "Common\SetWaypointCO.sqf";
funcSendAIGroupOrder = compile preProcessFileLineNumbers "Common\SendAIGroupOrder.sqf";
funcSendAIGroupSetting = compile preProcessFileLineNumbers "Common\SendAIGroupSetting.sqf";
funcGetClosestBase = compile preProcessFileLineNumbers "Common\GetClosestBase.sqf";
funcLimitGroupFatigue = compile preProcessFileLineNumbers "Common\LimitGroupFatigue.sqf";
funcFindFlatEmptyPos = compile preProcessFileLineNumbers "Common\FindFlatEmptyPos.sqf";
funcSetMass = compile "(_this select 0) setMass (_this select 1);";
funcDisableCollisionWith = compile "(_this select 0) disableCollisionWith (_this select 1);";
funcEnableCollisionWith = compile "(_this select 0) enableCollisionWith (_this select 1);";
funcEjectDisband = compile preProcessFileLineNumbers "Common\EjectDisband.sqf";
funcMoveAI = compile preProcessFileLineNumbers "Common\MoveAI.sqf";
funcFlyInHeight = compile preProcessFileLineNumbers "Common\FlyInHeight.sqf";
funcLand = compile preProcessFileLineNumbers "Common\Land.sqf";
funcAssignAsCargo = compile preProcessFileLineNumbers "Common\AssignAsCargo.sqf";
funcAssignAsGunner = compile preProcessFileLineNumbers "Common\AssignAsGunner.sqf";
funcDoStop = compile preProcessFileLineNumbers "Common\DoStop.sqf";
funcSetFuel = compile preProcessFileLineNumbers "Common\SetFuel.sqf";
funcTargetFire = compile preProcessFileLineNumbers "Common\TargetFire.sqf";
funcFireAt = compile preProcessFileLineNumbers "Common\FireAt.sqf";
funcDeleteGroup = compile preProcessFileLineNumbers "Common\DeleteGroup.sqf";
funcLightning = compile preProcessFileLineNumbers "Common\Lightning.sqf";
funcDisableAI = compile preProcessFileLineNumbers "Common\DisableAI.sqf";
funcEnableAI = compile preProcessFileLineNumbers "Common\EnableAI.sqf";
funcSwitchMove = compile preProcessFileLineNumbers "Common\SwitchMove.sqf";
funcSpawnUnitArray = compile preProcessFileLineNumbers "Common\SpawnUnitArray.sqf";
funcUpdateUnitArray = compile preProcessFileLineNumbers "Common\UpdateUnitArray.sqf";
funcDespawnUnitArray = compile preProcessFileLineNumbers "Common\DespawnUnitArray.sqf";
funcGetOrderDesc = compile preProcessFileLineNumbers "Common\GetOrderDesc.sqf";

funcNearestTerrainObjects = compile format["%1", ["[]", "nearestTerrainObjects _this"] select (THISISARMA3 && ((productVersion select 2) >= 154) && ((productVersion select 3) >= 132763)) ];
funcHideObjectGlobal = compile format["%1", ["", "(_this select 0) hideObjectGlobal (_this select 1);"] select (THISISARMA3 && ((productVersion select 2) >= 112)) ];

_handle_InitHintTypes = [] execVM "Common\InitHintTypes.sqf";
waitUntil {scriptDone _handle_InitHintTypes};
funcHint = compile preProcessFileLineNumbers "Common\Hint.sqf";

if ( !isServer && hasInterface ) then
{
	waitUntil {!isNull player && local player};
};

if ( !isNull player ) then
{
	crcti_kb_initPlayerDone=false;
	_nul = [] execVM "Player\InitGUIControlIDs.sqf";
	MsgServerInfo = compile preProcessFileLineNumbers "Player\MsgServerInfo.sqf";
	"pvServerInfo" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgServerInfo;};
};

if ( isServer ) then
{
	crcti_kb_initServerDone=false;
	publicVariable "crcti_kb_initServerDone";
	onPlayerConnected "nul=[_name, _uid] execVM ""JIP\onPlayerConnected.sqf""";
	onPlayerDisconnected "nul=[_name, _uid] execVM ""JIP\onPlayerDisConnected.sqf""";
};

if ( isClass (configFile >> "CfgSettings" >> "CBA") ) then
{
	startLoadingScreen["Initializing CBA.","RscDisplayLoadMission"];
	diag_log format["CBA detected, waiting for CBA INIT."];
	waituntil {!isNil "SLX_XEH_MACHINE"};
	waituntil {SLX_XEH_MACHINE select 8};
	diag_log format["CBA OK."];
};

startLoadingScreen["Initializing.","RscDisplayLoadMission"];

if ( isClass (configFile >> "CfgSettings" >> "ACE") ) then
{
	AceModelsAllowed = true;
	AceClient = true;
	if ( isServer ) then
	{
		AceServer = true;
		publicVariable "AceServer";
	};
}
else
{
	AceModelsAllowed = false;
	AceClient = false;
	if ( isServer ) then
	{
		AceServer = false;
		publicVariable "AceServer";
	};
};

AcreAllowed = false;
if ( isClass (configFile >> "CfgWeapons" >> "ACRE_PRC148") ) then
{
	AcreAllowed = true;
};

WEST setFriend [EAST,0];
WEST setFriend [WEST,1];
WEST setFriend [RESISTANCE,0];
WEST setFriend [CIVILIAN,1];

EAST setFriend [EAST,1];
EAST setFriend [WEST,0];
EAST setFriend [RESISTANCE,0];
EAST setFriend [CIVILIAN,1];

RESISTANCE setFriend [EAST,0];
RESISTANCE setFriend [WEST,0];
RESISTANCE setFriend [RESISTANCE,1];
RESISTANCE setFriend [CIVILIAN,1];

CIVILIAN setFriend [EAST,1];
CIVILIAN setFriend [WEST,1];
CIVILIAN setFriend [RESISTANCE,1];
CIVILIAN setFriend [CIVILIAN,1];

CRCTIDEBUG = false;

/*WEST setFriend [EAST,1];
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

 CRCTIDEBUG = true;*/

if ( isNil "CRCTICOOP" ) then {CRCTICOOP = false;};

ace_sys_tracking_markers_enabled = false;

mhqWest = objNull;
mhqEast = objNull;
BaseMatrix = [[], []];
pvCurrentWeather = [];
HumanIDs = [[],[]];

_nul = execVM "briefing.sqf";

pvRearmVehicle = [];

// CONSTANTS
siWest = 0;
siEast = 1;
siRes = 2;
siBoth = 3;
siCiv = 4;
siNone = 5;
siEnemy = [siEast, siWest];
sideNames = ["West", "East", "Resistance", "Both", "Civilian", "None"];
sideNamesAI = ["AI West", "AI East", "Resistance", "Both", "Civilian", "None"];
groupNames = ["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel",
"India", "Juliett", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa",
"Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "X-Ray","Yankee", "Zulu",
"Black", "White", "Red", "Green", "Blue", "Gold"];
sideColors = [ [0.5,0.5,.9,1], [.9,0.5,0.5,1], [.5,0.9,0.5,1], [.9,0.9,0.9,1], [.9,0.9,0.9,1], [.9,0.9,0.9,1] ];
DefaultFactions = ["BLU_F", "OPF_F", "IND_F", "CIV_F"];

playerSideIndex = -1;

costWorker = 200;
maxWorkers = 10;
repairRange = 50;
rearmRange = 50;
radarRange = 4000;
radarRangeLR = 10000;
radarHeight = 30;
deleteUnitDelay = 75;
deleteVehicleDelay = 10;
cleanUnitDelay = 1200;
disbandVehicleDist = 100;
deleteItemDelay = 120;
maxFlightAltitude = 1000;
stuckVehicleTimeout = 600;
maxGarbageCount = 100;
SQU_FloatObj = false;
disconnectTimeout = 300;
SitrepInterval = 600;
PictureTime = 120;
PicturePrice = 5000;
factorRepairTime = 1.0;
repairBlockTime = 90;
attackKnowsAbout = 1.0;
tradeInFactor = 1.0;
unlockMHQPrices = [0, 0, 1000, 2000];
townGroupPrices = [1000, 3000, 5000, 10000];
extensionTime = [15*60, 60*60];
extensionRequestTimeout = 5*60;
scoreFactor = 0.01;
townScoreFactor = 10.0;
townScoreRebuildTime = 600;
flagRadius = 20;
structScoreFactor = 1.0;
structTimeOut = 600;
maxRelays = 20;
AiCommTpDutyGndLimit = 4;
townCaptureTime = 10;
beerPrice = 10;
clearBaseRadius = 150;
townRadius = 300;
baseRadius = 200;
secondBaseDistance = baseRadius * 0.75;
renegadeRatingAdd = 10;
factionSelectionTimeout = 300;

startMoneyEastPlayer = 0;
startMoneyWestPlayer = 0;

GridSizeValues = [50, 25, 12.5, 6.25, 3.125];
GridSizeTexts = ["Very Low", "Low", "Normal", "High", "Very High"];

//game properties (see description.ext)
_pidx = 0;
GameMode = paramsArray select _pidx; _pidx=_pidx+1;
CommSlotsLocked = paramsArray select _pidx; _pidx=_pidx+1;
fixedStartPos = paramsArray select _pidx; _pidx=_pidx+1;
startMoneyWest = paramsArray select _pidx; _pidx=_pidx+1;
startMoneyEast = paramsArray select _pidx; _pidx=_pidx+1;
startMoneyWestPlayer = floor(startMoneyWest/20);
startMoneyEastPlayer = floor(startMoneyEast/20);

TownCount = paramsArray select _pidx; _pidx=_pidx+1;
if ( TownCount == -1 ) then {TownCount = count(towns);};

ClusterCount = paramsArray select _pidx; _pidx=_pidx+1;
AdaptiveTownValues = paramsArray select _pidx; _pidx=_pidx+1;
TownIncomeFactor = (paramsArray select _pidx)/100; _pidx=_pidx+1;
IncomeLimit = paramsArray select _pidx; _pidx=_pidx+1;

ScoreMoneyFactor = (paramsArray select _pidx)/100; _pidx=_pidx+1;
MoneyPerScore = ScoreMoneyFactor * 0.1;

DeathPenaltyFactor = (paramsArray select _pidx)/100; _pidx=_pidx+1;
RepairRearmCostFactor = (paramsArray select _pidx)/100; _pidx=_pidx+1;
UnitBuildTimeFactor = (paramsArray select _pidx)/100; _pidx=_pidx+1;
FactoryPrepareTimeFactor = (paramsArray select _pidx)/100; _pidx=_pidx+1;

_startMonth = paramsArray select _pidx; _pidx=_pidx+1;
_startHour = paramsArray select _pidx; _pidx=_pidx+1;

if ( _startMonth == -1 ) then {_startMonth = 1 + floor(random(12));};
if ( _startHour == -1 ) then {_startHour = floor(random(24));};

if ( isNil "pvDate" ) then
{
	pvDate = [2013,_startMonth,16,_startHour,0];
};
setDate pvDate;

SkipTimeFactor = paramsArray select _pidx; _pidx=_pidx+1;

_tl = paramsArray select _pidx; _pidx=_pidx+1;
if ( isNil "timeLimit") then {timeLimit = _tl};

WeatherSetting = paramsArray select _pidx; _pidx=_pidx+1;
FogFactor = (paramsArray select _pidx) / 100; _pidx=_pidx+1;
WeatherChangeTime = (paramsArray select _pidx) * 60; _pidx=_pidx+1;

weatherSyncDelay = 5;
weatherChangeDuration = [WeatherChangeTime, WeatherChangeTime + WeatherChangeTime*0.25];
weatherChangeInterval = [WeatherChangeTime + WeatherChangeTime * 0.25, WeatherChangeTime + WeatherChangeTime*0.5];

maxGroupSize = paramsArray select _pidx; _pidx=_pidx+1;
maxViewDistance = paramsArray select _pidx; _pidx=_pidx+1;
minViewDistance = paramsArray select _pidx; _pidx=_pidx+1;

if ( minViewDistance > maxViewDistance ) then {minViewDistance = maxViewDistance;};

setViewDistance maxViewDistance;
playerViewDistance = viewDistance;
if ( isNil "serverViewDistance") then {serverViewDistance = viewDistance;};

maxObjectViewDistance = paramsArray select _pidx; _pidx=_pidx+1;
if ( maxObjectViewDistance > maxViewDistance ) then {maxObjectViewDistance = maxViewDistance;};
setObjectViewDistance maxObjectViewDistance;

minTerrainGrid = paramsArray select _pidx; _pidx=_pidx+1;
TerrainGrid = minTerrainGrid;
setTerrainGrid (GridSizeValues select TerrainGrid);

DefaultFormation = paramsArray select _pidx; _pidx=_pidx+1;
DefaultSpeedMode = paramsArray select _pidx; _pidx=_pidx+1;
AiSkill = (paramsArray select _pidx)/100; _pidx=_pidx+1;
AiAccuracy = (paramsArray select _pidx)/100; _pidx=_pidx+1;
ResistanceAmountInf = (paramsArray select _pidx)/100;_pidx=_pidx+1;
ResistanceAmountCar = (paramsArray select _pidx)/100;_pidx=_pidx+1;
ResistanceAmountApc = (paramsArray select _pidx)/100;_pidx=_pidx+1;
ResistanceAmountTank = (paramsArray select _pidx)/100;_pidx=_pidx+1;
ResistanceAmountAir = (paramsArray select _pidx)/100;_pidx=_pidx+1;
ResistanceAmountStatic = (paramsArray select _pidx)/100;_pidx=_pidx+1;
resPatrolGroups = paramsArray select _pidx; _pidx=_pidx+1;
ResAmmoCratesEnabled = paramsArray select _pidx; _pidx=_pidx+1;
TownGroupsEnabled = (paramsArray select _pidx)/100; _pidx=_pidx+1;
MaxTownGroups = round(TownCount*TownGroupsEnabled);
CarsAllowed = (paramsArray select _pidx)/100; _pidx=_pidx+1;
LightArmorAllowed = (paramsArray select _pidx)/100; _pidx=_pidx+1;
HeavyArmorAllowed = (paramsArray select _pidx)/100; _pidx=_pidx+1;
AttackChoppersAllowed = (paramsArray select _pidx)/100; _pidx=_pidx+1;
AttackPlanesAllowed = (paramsArray select _pidx)/100; _pidx=_pidx+1;
AntiAirAllowed = (paramsArray select _pidx)/100; _pidx=_pidx+1;
ArtyAllowed = (paramsArray select _pidx)/100; _pidx=_pidx+1;
SatCamPrice = paramsArray select _pidx; _pidx=_pidx+1;
TIEEnabled = paramsArray select _pidx; _pidx=_pidx+1;
TeamSwitchAllowed = paramsArray select _pidx; _pidx=_pidx+1;
UnitSwitchAllowed = paramsArray select _pidx; _pidx=_pidx+1;
costRepairMHQ = paramsArray select _pidx; _pidx=_pidx+1;
CiviliansAmount = (paramsArray select _pidx)/100;_pidx=_pidx+1;
CivilianVehiclesAmount = (paramsArray select _pidx)/100;_pidx=_pidx+1;
CivilianTrafficAmount = (paramsArray select _pidx)/100;_pidx=_pidx+1;
MovieColorsEnabled = 0; //paramsArray select _pidx; _pidx=_pidx+1;
ParticlesManager = 0;//paramsArray select _pidx; _pidx=_pidx+1;
PostprocessManager = 0;//paramsArray select _pidx; _pidx=_pidx+1;
WeatherModule = 0;//paramsArray select _pidx; _pidx=_pidx+1;
MapMode = paramsArray select _pidx; _pidx=_pidx+1;
GPSAvailable = paramsArray select _pidx; _pidx=_pidx+1;
LeaderBoardAvailable = paramsArray select _pidx; _pidx=_pidx+1;
FatigueEnabled = paramsArray select _pidx; _pidx=_pidx+1;
FatigueLimit = (paramsArray select _pidx) / 100; _pidx=_pidx+1;
WeaponSwayFactor = (paramsArray select _pidx) / 100; _pidx=_pidx+1;
AceWoundingEnabled = 0;//paramsArray select _pidx; _pidx=_pidx+1;
AceWoundsAIEnabled = 0;//paramsArray select _pidx; _pidx=_pidx+1;
AceDamageEnabled = 0;//paramsArray select _pidx; _pidx=_pidx+1;
AcreChannelID = paramsArray select _pidx; _pidx=_pidx+1;
AcreLossModelScaleFactor = (paramsArray select _pidx)/100; _pidx=_pidx+1;
ClearBasesEnabled = paramsArray select _pidx; _pidx=_pidx+1;
BuildInTownsAllowed = paramsArray select _pidx; _pidx=_pidx+1;
IntroMode = paramsArray select _pidx; _pidx=_pidx+1;
NoPlayerTimeout = (paramsArray select _pidx)*60; _pidx=_pidx+1;
AdminFunctionsAvailable = paramsArray select _pidx; _pidx=_pidx+1;

if ( ! AceModelsAllowed ) then
{
	AceWoundingEnabled = 0;
	AceWoundsAIEnabled = 0;
};

if ( AcreAllowed ) then
{
	_nul = [AcreLossModelScaleFactor] call acre_api_fnc_setLossModelScale;
};

if ( TFRAllowed && isServer ) then
{
	_nul = [] call compile PreProcessFile "Server\InitTFAR.sqf";
};

AntiAirPodFactor = AttackChoppersAllowed;
if ( AttackPlanesAllowed > AttackChoppersAllowed ) then {AntiAirPodFactor = AttackPlanesAllowed;};
if ( AntiAirPodFactor == 0 ) then {AntiAirPodFactor = 1.0;};

AntiTankPodFactor = LightArmorAllowed;
if ( HeavyArmorAllowed > LightArmorAllowed ) then {AntiTankPodFactor = HeavyArmorAllowed;};
if ( AntiTankPodFactor == 0 ) then {AntiTankPodFactor = 1.0;};

spawnDistance = maxViewDistance;
if ( spawnDistance > 1500 ) then {spawnDistance = 1500;};

CivilianSpawnDist = 500;
GarbageDeleteDist = 500;

itemTrash = ["WeaponHolderSimulated", "GroundWeaponHolder", "WeaponHolder"];
specialTrash = ["CraterLong", "CraterLong_small", "Ruins"];
if ( AceModelsAllowed ) then
{
	specialTrash = specialTrash + ["ACE_Jerrycan","ACE_JerryCan_15","ACE_EjectionSeat", "ACE_Ka52_Blade", "ACE_Blooddrop_1", "ACE_Blooddrop_2", "ACE_HEShellCrater","ACE_T72WreckTurret"];
};

AutoEquipmentList = true;
AutoUnitList = true;

if ( CRCTICOOP ) then
{
	maxGroupSize = 10;
};

// UPGRADES
upgMatrix = [ [], [] ];
_type = 0;

upgUnitCam = _type;
(upgMatrix select siWest) set [_type, ["Unit Camera", 2000, 2, 0, 0]];
(upgMatrix select siEast) set [_type, ["Unit Camera", 2000, 2, 0, 0]];
_type=_type+1;

upgRadarAircraft = _type;
(upgMatrix select siWest) set [_type, ["Aircraft Radar", 10000, 2, 0, 0]];
(upgMatrix select siEast) set [_type, ["Aircraft Radar", 10000, 2, 0, 0]];
_type=_type+1;

upgRadarGround = _type;
(upgMatrix select siWest) set [_type, ["Ground Radar", 50000, 5, 0, 0]];
(upgMatrix select siEast) set [_type, ["Ground Radar", 50000, 5, 0, 0]];
_type=_type+1;

RegularUpgrades = [upgUnitCam, upgRadarAircraft, upgRadarGround];

if ( ArtyAllowed > 0 ) then
{
	upgRadarArtillery = _type;
	(upgMatrix select siWest) set [_type, ["Artillery Radar", 5000, 2, 0, 0]];
	(upgMatrix select siEast) set [_type, ["Artillery Radar", 5000, 2, 0, 0]];
	_type=_type+1;

	RegularUpgrades = RegularUpgrades + [upgRadarArtillery];
};

if ( SatCamPrice > -1 ) then
{
	upgSatCam = _type;
	(upgMatrix select siWest) set [_type, ["Satellite Camera", SatCamPrice, 5, 0, 0]];
	(upgMatrix select siEast) set [_type, ["Satellite Camera", SatCamPrice, 5, 0, 0]];
	_type=_type+1;

	RegularUpgrades = RegularUpgrades + [upgSatCam];
};

if ( UnitSwitchAllowed > 0 ) then
{
	upgSwitchBlock = _type;
	(upgMatrix select siWest) set [_type, ["Unitswitch Blocker (1km)", 2000, 2, 0, 0]];
	(upgMatrix select siEast) set [_type, ["Unitswitch Blocker (1km)", 2000, 2, 0, 0]];
	_type=_type+1;

	RegularUpgrades = RegularUpgrades + [upgSwitchBlock];
};

// SCORE
_type = 0;
scoreDefs = [];
scInfantry = _type; scoreDefs set [_type, ["Infantry",1]]; _type=_type+1;
scVehicle = _type; scoreDefs set [_type, ["Vehicle",2]]; _type=_type+1;
scMHQ = _type; scoreDefs set [_type, ["MHQ",10]]; _type=_type+1;
scStruct = _type; scoreDefs set [_type, ["Struct",4]]; _type=_type+1;
scTown = _type; scoreDefs set [_type, ["Town",4]]; _type=_type+1;
scBeer = _type; scoreDefs set [_type, ["Beer",4]]; _type=_type+1;

scoreMoney = [[],[]];

GroupAICommanderWest = grpNull;
GroupAICommanderEast = grpNull;

if ( isServer ) then
{

	groupMatrix = [[], [], [],[]];
	groupNameMatrix = [[], []];
	groupMoneyMatrix = [[], []];
	groupUnitsBuildingMatrix = [[], []];
	groupScoreMatrix = [];
	JIPUserID = [[],[]];
	undoList = [[],[]];
	groupBuyQueue = [[],[]];

	_groups = [];
	_groupNames = [];

	{
		_groups = _groups + [_x];
		_groupNames = _groupNames + [groupNames select _forEachIndex];
	}forEach GroupsWest;

	if ( CommSlotsLocked == 1 ) then
	{
		GroupAICommanderWest = createGroup West;
		GroupsWest = GroupsWest + [GroupAICommanderWest];
		_unit = GroupAICommanderWest createUnit ["B_Soldier_SL_F", position leader (GroupsWest select 0), [], 0, "NONE"];
		LeaderGroupAICommanderWest = _unit;
		_groups = _groups + [GroupAICommanderWest];
		_groupNames = _groupNames + ["Horst"];
	};

	groupMatrix set[siWest, _groups];
	groupNameMatrix set[siWest, _groupNames];

	for "_i" from 0 to (count _groups) do
	{
		(groupMoneyMatrix select siWest) set [_i, 0];
		(groupUnitsBuildingMatrix select siWest) set [_i, 0];
		(undoList select siWest) set [_i,[]];
		(groupBuyQueue select siWest) set [_i,[]];
		(JIPUserID select siWest) set [_i,"-1"];
	};

	_groups = [];
	_groupNames = [];

	{
		_groups = _groups + [_x];
		_groupNames = _groupNames + [groupNames select _forEachIndex];
	}forEach GroupsEast;

	if ( CommSlotsLocked == 1 ) then
	{
		GroupAICommanderEast = createGroup East;
		GroupsEast = GroupsEast + [GroupAICommanderEast];
		_unit = GroupAICommanderEast createUnit ["O_Soldier_SL_F", position leader (GroupsEast select 0), [], 0, "NONE"];
		LeaderGroupAICommanderEast = _unit;
		_groups = _groups + [GroupAICommanderEast];
		_groupNames = _groupNames + ["Mahmud"];
	};

	groupMatrix set[siEast, _groups];
	groupNameMatrix set[siEast, _groupNames];

	for "_i" from 0 to (count _groups) do
	{
		(groupMoneyMatrix select siEast) set [_i, 0];
		(groupUnitsBuildingMatrix select siEast) set [_i, 0];
		(undoList select siEast) set [_i,[]];
		(groupBuyQueue select siEast) set [_i,[]];
		(JIPUserID select siEast) set [_i,"-1"];
	};

	publicVariable "groupMatrix";
	publicVariable "groupNameMatrix";
	publicVariable "groupMoneyMatrix";
	publicVariable "groupUnitsBuildingMatrix";
	publicVariable "groupScoreMatrix";
};

if ( !isNull player ) then
{
	waitUntil {!isNil "groupMatrix"};
	waitUntil {!isNil "groupNameMatrix"};
	waitUntil {!isNil "groupMoneyMatrix"};
	waitUntil {!isNil "groupUnitsBuildingMatrix"};
	waitUntil {!isNil "groupScoreMatrix"};
};

// town descriptor indexes
tdFlag = 0;
tdName = 1;
tdValue = 2;
tdSide = 3;
tdInf = 4;
tdVehicle = 5;
tdState = 6;
tdMinDist = 7;
tdCivState = 8;
tdWestTownGroupStarted = 9;
tdEastTownGroupStarted = 10;
tdHash = 11;

_handle_InitPublicVariables = [] execVM "Common\InitPublicVariables.sqf";
waitUntil {scriptDone _handle_InitPublicVariables};
_handle_InitStructureTypes = [] execVM "Common\InitStructureTypes.sqf";
waitUntil {scriptDone _handle_InitStructureTypes};

titleText ["Receiving ...", "BLACK", 0.01];
endLoadingScreen;

if ( ! pvFactionsSelected ) then
{
	forcemap true;
	titleFadeOut 0.01;
	if ( isServer ) then {_nul = [] execVM "Server\SelectFactions.sqf";};
	if ( !isNull player ) then {waitUntil {time > 1}; _nul = [] execVM "Player\SelectFactions.sqf";};

	waitUntil {pvFactionsSelected;};
	titleText ["Receiving ...", "BLACK", 0.01];
	forcemap false;
};

_handle_InitUnitTypes = [] execVM "Common\InitUnitTypes.sqf";
waitUntil {scriptDone _handle_InitUnitTypes};
_handle_InitEquipmentTypes = [] execVM "Common\InitEquipmentTypes.sqf";
waitUntil {scriptDone _handle_InitEquipmentTypes};
startLoadingScreen["Initializing.","RscDisplayLoadMission"];
titleFadeOut 0.01;

_handle_InitInfoMsgTypes = [] execVM "Common\InitInfoMsgTypes.sqf";
waitUntil {scriptDone _handle_InitInfoMsgTypes};
_handle_Vectors = [] execVM "Common\Vectors.sqf";
waitUntil {scriptDone _handle_Vectors};

// AI GROUP SETTINGS
// setting definition entry format: [ name, [s0, s1, ...], default ]
aiSettingDefs = [];
_type = 0;

aisRallyPoint = _type;
aiSettingDefs set [_type, ["Rally Point", ["none", "co0", "co1", "co2", "co3", "co4","co5","co6","co7","co8","co9"], 0] ];
_type = _type + 1;

aisPickupWait = _type;
aiSettingDefs set [_type, ["Pickup Wait", ["On foot", "1min", "2min", "3min", "4min", "5min", "6min", "7min", "8min", "9min"], 3] ];
_type = _type + 1;

aisRespawn = _type;
aiSettingDefs set [_type, ["Respawn", ["Default", "Base 1", "Base 2"], 0] ];
_type = _type + 1;

aisBuy = _type;
aiSettingDefs set [_type, ["Buy", ["none", "Mixed", "Infantry Mixed", "Cars", "Armor Light", "Armor Heavy", "Attack Choppers", "AntiAir", "Artillery", "Transport", "Transport Air","Support", "Divers"], 0] ];
_type = _type + 1;

aisKeep = _type;
aiSettingDefs set [_type, ["Keep", ["$100", "$200", "$400", "$800", "$1600", "$3200", "$6400", "$12800", "$25600", "$51200","$102400", "$204800", "$409600", "$819200", "$1638400"], 0] ];
_type = _type + 1;

aisBuyBase = _type;
aiSettingDefs set [_type, ["Buy in Base", ["Both", "Base 1 only", "Base 2 only"], 0] ];
_type = _type + 1;

aisSpeedmode = _type;
aisSpeedModes = ["LIMITED", "NORMAL", "FULL"];
aiSettingDefs set [_type, ["Speedmode", aisSpeedModes, DefaultSpeedMode] ];
_type = _type + 1;

aisFormation = _type;
aisFormations = ["NONE","COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND", "STAG COLUMN / LINE"];
aiSettingDefs set [_type, ["Formation", aisFormations, DefaultFormation] ];
_type = _type + 1;

_default = [];
{	_default set [count _default, _x select 2]}foreach aiSettingDefs;

// current setting entry format: [orderID, orderType, [param0, param1, ...]]
aiSetting = [ [], [] ];
_si = siwest; _list = aiSetting select _si;
{	_list set [ count _list, +_default ]}foreach (groupMatrix select _si);
_si = sieast; _list = aiSetting select _si;
{	_list set [ count _list, +_default ]}foreach (groupMatrix select _si);

// AI GROUP ORDERS
// order def entry format: [name, params, script]
// order def param format: [name, countFunc, toTextFunc]
funcDirIndexToText = "[""All"", ""N"", ""NE"", ""E"", ""SE"", ""S"", ""SW"", ""W"", ""NW""] select _this";
orderDefs = [];
_type = 0;

orderTakeHoldTowns = _type;
_param0 = ["Hold Distance", "10", "format [""<%1m"", 50*(_this+1)]"];
_param1 = ["Hold Time", "10", "format [""%1min"", 5*(_this)]"];
orderDefs set [_type, ["Take Hold Towns", [_param0, _param1], "OrderTakeHoldTowns.sqf"] ];
_type = _type + 1;

orderHoldTown = _type;
_param0 = [ "Town", "count towns", "(towns select _this) select 1" ];
_param1 = [ "Defend Distance", "10", "format [""<%1m"", 50*(_this+1)]" ];
orderDefs set [_type, ["Hold Town", [_param0, _param1], "OrderHoldTown.sqf"] ];
_type = _type + 1;

orderPatrolArea = _type;
_param0 = [ "Waypoint", "count (wpCO select playerSideIndex)", "_posRelTown = ((wpCO select playerSideIndex) select _this) call funcCalcTownDirDistFromPos; format[""co%1 %2"", _this, [_posRelTown, """"] select ((((wpCO select playerSideIndex) select _this) select 0) == 1)]" ];
_param1 = [ "Patrol Radius", "10", "format [""%1m"", 50*(_this+1)]" ];
orderDefs set [_type, ["Patrol Area", [_param0, _param1], "OrderPatrolArea.sqf"] ];
_type = _type + 1;

orderPatrolLine = _type;
_param0 = [ "Waypoint", "count (wpCO select playerSideIndex)", "_posRelTown = ((wpCO select playerSideIndex) select _this) call funcCalcTownDirDistFromPos; format[""co%1 %2"", _this, [_posRelTown, """"] select ((((wpCO select playerSideIndex) select _this) select 0) == 1)]" ];
_param1 = [ "Waypoint", "count (wpCO select playerSideIndex)", "_posRelTown = ((wpCO select playerSideIndex) select _this) call funcCalcTownDirDistFromPos; format[""co%1 %2"", _this, [_posRelTown, """"] select ((((wpCO select playerSideIndex) select _this) select 0) == 1)]" ];
orderDefs set [_type, ["Patrol Line", [_param0, _param1], "OrderPatrolLine.sqf"] ];
_type = _type + 1;

orderAdvance = _type;
_param0 = [ "Waypoint", "count (wpCO select playerSideIndex)", "_posRelTown = ((wpCO select playerSideIndex) select _this) call funcCalcTownDirDistFromPos; format[""co%1 %2"", _this, [_posRelTown, """"] select ((((wpCO select playerSideIndex) select _this) select 0) == 1)]" ];
orderDefs set [_type, ["Advance", [_param0], "OrderAdvance.sqf"] ];
_type = _type + 1;

orderTransportDuty = _type;
_param0 = [ "Pickup Pos", "count (wpCO select playerSideIndex)", "_posRelTown = ((wpCO select playerSideIndex) select _this) call funcCalcTownDirDistFromPos; format[""co%1 %2"", _this, [_posRelTown, """"] select ((((wpCO select playerSideIndex) select _this) select 0) == 1)]" ];
_param1 = [ "Eject Pos", "count (wpCO select playerSideIndex)", "_posRelTown = ((wpCO select playerSideIndex) select _this) call funcCalcTownDirDistFromPos; format[""co%1 %2"", _this, [_posRelTown, """"] select ((((wpCO select playerSideIndex) select _this) select 0) == 1)]" ];
_param2 = [ "Eject Distance", "5", "format [""%1m"", 200*(_this+1)]" ];
orderDefs set [_type, ["Transport Duty", [_param0, _param1, _param2], "OrderTransportDuty.sqf"] ];
_type = _type + 1;

// Compile orders
{
	_script = _x select 2;
	_x set [2, compile preProcessFileLineNumbers format["Server\%1",_script]];
}forEach orderDefs;

// order entry format: [orderID, orderType, [param0, param1, ...]]
orderMatrix = [ [], [] ];
_si = siwest; _gi = 0;
{	(orderMatrix select _si) set [ _gi, [0, orderTakeHoldTowns, [3, 1]] ]; _gi = _gi + 1}foreach (groupMatrix select _si);
_si = sieast; _gi = 0;
{	(orderMatrix select _si) set [ _gi, [0, orderTakeHoldTowns, [3, 1]] ]; _gi = _gi + 1}foreach (groupMatrix select _si);

// WAYPOINTS
wpCO = [[],[]];
wpPlayer = [];

countWP = 10;
for [ {_i=0}, {_i<countWP}, {_i=_i+1}] do
{
	wpPlayer set [_i, [-1,-1]];
	(wpCO select siWest) set [_i, [-1,-1]];
	(wpCO select siEast) set [_i, [-1,-1]];
};

// vehicleAttached format: [ [tug, [vehicleCenter, vehicleRight, vehicleLeft]], ...]
tsTug = 0;
tsTugged = 1;
tsCenter = 0;
tsRight = 1;
tsLeft = 2;
vehicleAttached = [];
ttHeli = 0;
ttBoat = 1;
ttTruck = 2;
ttAPC = 3;

// MESSAGE HANDLERS (SERVER AND CLIENTS)
MsgScore = compile preProcessFileLineNumbers "Common\MsgScore.sqf";
MsgAIGroupOrder = compile preProcessFileLineNumbers "Common\MsgAIGroupOrder.sqf";
MsgAIGroupSetting = compile preProcessFileLineNumbers "Common\MsgAIGroupSetting.sqf";
MsgWayPoint = compile preProcessFileLineNumbers "Common\MsgWaypoint.sqf";
MsgVehicleAttached = compile preProcessFileLineNumbers "Common\MsgVehicleAttached.sqf";
MsgDetachVehicle = compile preProcessFileLineNumbers "Common\MsgDetachVehicle.sqf";
MsgVehicleDetached = compile preProcessFileLineNumbers "Common\MsgVehicleDetached.sqf";
MsgLock = compile preProcessFileLineNumbers "Common\MsgLock.sqf";
MsgUnlock = compile preProcessFileLineNumbers "Common\MsgUnlock.sqf";
MsgEjectUnit = compile preProcessFileLineNumbers "Common\MsgEjectUnit.sqf";
MsgObjectRepaired = compile preProcessFileLineNumbers "Common\MsgObjectRepaired.sqf";
MsgAddUnit = compile preProcessFileLineNumbers "Common\MsgAddUnit.sqf";
MsgStructBuilt = compile preProcessFileLineNumbers "Common\MsgStructBuilt.sqf";
MsgUnitBuilt = compile preProcessFileLineNumbers "Common\MsgUnitBuilt.sqf";
MsgRearmVehicle = compile preProcessFileLineNumbers "Common\MsgRearmVehicle.sqf";
MsgAllowDamage = compile preProcessFileLineNumbers "Common\MsgAllowDamage.sqf";
MsgSetDate = compile preProcessFileLineNumbers "Common\MsgSetDate.sqf";
MsgSendDebugStats = compile preProcessFileLineNumbers "Common\MsgSendDebugStats.sqf";

"pvScore" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgScore;};
"pvOrder" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgAIGroupOrder;};
"pvSetting" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgAIGroupSetting;};
"pvWPCO" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgWayPoint;};
"pvVehicleAttached" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgVehicleAttached;};
"pvDetachVehicle" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgDetachVehicle;};
"pvVehicleDetached" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgVehicleDetached;};
"pvLock" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgLock;};
"pvUnlock" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgUnlock;};
"pvEjectUnit" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgEjectUnit;};
"pvObjectRepaired" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgObjectRepaired;};
"pvAddUnit" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgAddUnit;};
"pvStructBuilt" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgStructBuilt;};
"pvUnitBuilt" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgUnitBuilt;};
"pvRearmVehicle" addPublicVariableEventHandler {[_this select 1] spawn MsgRearmVehicle};
"pvAllowDamage" addPublicVariableEventHandler {[_this select 1] spawn MsgAllowDamage};
"pvDate" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgSetDate;};

EventVehicleHit = compile preProcessFileLineNumbers "Common\EventVehicleHit.sqf";
EventInfantryKilled = compile preProcessFileLineNumbers "Common\EventInfantryKilled.sqf";
EventRespawn = compile preProcessFileLineNumbers "Common\EventRespawn.sqf";

{
	_side = _x;
	{
		_group = _x;
		_groupId = _forEachIndex;
		{
			if ( _x in playableUnits ) then
			{
				_nul = [_x, _side, _groupId, 2000] call funcInitGroupMember;
			};
		}forEach (units _group);

		_group setGroupId [(groupNameMatrix select _side) select _forEachIndex, "GroupColor1"];
	}forEach (groupMatrix select _side);
}forEach [siWest, siEast];

if(isServer)then
{
	_nul = [] execVM "Server\InitServer.sqf";
};

if(!isNull player)then
{
	titleText ["Receiving ...", "BLACK", 0.01];
	endLoadingScreen;
	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};
	titleFadeOut 0.01;
	_nul = [] execVM "Player\InitClient.sqf";
};

if(!hasInterface && !isDedicated) then
{
	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};
	_nul = [] execVM "Headless\InitHeadlessClient.sqf";
};

while {true}do
{
	diag_log format["%1 %2 %3 %4", str(diag_fps), {local _x}count allUnits, {local _x}count vehicles, {local _x}count allGroups];
	/*{
	 diag_log format["%1 %2", str(_x), count(units _x)];
	 }forEach allGroups;*/
	sleep 60;
};