pvScore = [];

pvbase1W = false;
pvbase1E = false;
pvbase2W = false;
pvbase2E = false;

if ( isNil "InsertionState" ) then {InsertionState = [0,0];};
if ( isNil "InsertionChoppers" ) then {InsertionChoppers = [[],[]];};
if ( isNil "pvPlayerIncomeRatioWest" ) then {pvPlayerIncomeRatioWest = 0.2;};
if ( isNil "pvPlayerIncomeRatioEast" ) then {pvPlayerIncomeRatioEast = 0.2;};
if ( isNil "groupAiMatrix") then {groupAiMatrix = [[], []];};

if ( isNil "factoryQueues" ) then
{
	factoryQueues = [ [], [] ];
	queueEntryIdx = 0;
};

if ( isNil "groupCommander") then
{
	groupCommander = [grpNull, grpNull];
	if ( CommSlotsLocked == 0 ) then
	{
		groupCommander set [siWest, (groupMatrix select siWest) select 0];
		groupCommander set [siEast, (groupMatrix select siEast) select 0];
	}
	else
	{
		groupCommander set [siWest, (groupMatrix select siWest) select (count(groupMatrix select siWest)-1)];
		groupCommander set [siEast, (groupMatrix select siEast) select (count(groupMatrix select siEast)-1)];
	};
};

if ( isNil "giCO") then
{
	if ( CommSlotsLocked == 0 ) then
	{
		giCO = [0, 0];
	}
	else
	{
		giCO = [count(groupMatrix select siWest)-1,count(groupMatrix select siEast)-1];
	};
};

if ( isNil "pvRespawnObjectAiWest" ) then {pvRespawnObjectAiWest = objNull;};
if ( isNil "pvRespawnObjectAiEast" ) then {pvRespawnObjectAiEast = objNull;};

pvLock = objNull;
pvUnlock = objNull;
pvEjectUnit = objNull;
pvObjectRepaired = [];

// VARIABLES SENT BY SERVER

pvWorkersWest = 0;
pvWorkersEast = 0;

pvTownSide = [];

pvMoney = [];
pvMoneyTransfer = [];
pvMoneySideTotal = [];
pvMoneySideSpent = [];

pvInfo = [];

if ( isNil "BuildingsInUse" ) then {BuildingsInUse = [];};

// pvGameOver [type, siWinner]
// type: 0 time, 1 destruction, 2 townwin
if ( isNil "pvGameOver") then {pvGameOver = [];};

// VARIABLES SENT BY PLAYERS

if ( isNil "pvAcreFreq") then {pvAcreFreq = [[40],[50]];};
if ( isNil "pvAcreRelays") then
{
	pvAcreRelays = [[],[]];
	for[ {_i=0}, {_i<maxRelays}, {_i=_i+1}] do
	{
		(pvAcreRelays select siWest) set[_i, objNull];
		(pvAcreRelays select siEast) set[_i, objNull];
	};
};

if ( isNil "pvExtension" ) then {pvExtension = [[0,0],[0,0]];};

if ( isNil "lockMHQ" ) then {lockMHQ = [1, 1];};

pvAddWorker = -1;
pvCancelQueueEntry = -1;

pvBuildStruct = [];
pvStructBuilt = [];
if ( isNil "StructInitList" ) then {StructInitList = [];};

pvUnitBuilt = [];
if ( isNil "UnitInitList" ) then {UnitInitList = [];};

if ( isNil "pvFactionsSelected" ) then {pvFactionsSelected = false;};
if ( isNil "pvServerFactions") then {pvServerFactions = [];};
if ( isNil "pvServerFactionsResult") then {pvServerFactionsResult = [];};

pvUndo = [];

pvBuyUnit = [];

pvMoneyGive = [];
pvMoneyRequest = [];
pvMoneySpent = [];

pvUpgrade = -1;

pvWPCO = [];

pvArt = [];
pvPlayerKilled = [];
pvPlayerRespawn = [];

pvOrder = [];
pvSetting = [];

pvVehicleAttached = [];
pvDetachVehicle = [];
pvVehicleDetached = [];

pvRepairMHQ = [];

pvCO = [];

pvGarbage = [];
pvAddUnit = [];

pvSitrep = [];
pvAllowDamage = [];

pvFPS = 50;
pvSFPS = 50;

pvCleanKill = 0;
pvSendDebugStats = 0;
pvDebugStats = [];

InitPublicVariablesDone = true;
