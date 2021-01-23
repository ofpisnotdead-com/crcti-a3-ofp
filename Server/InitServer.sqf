logicGroup = createGroup sideLogic;
tempGroupWest = createGroup West;
tempGroupEast = createGroup East;
tempGroupCiv = createGroup Civilian;
tempGroupRes = createGroup Resistance;
workerGroupWest = createGroup West;
workerGroupEast = createGroup East;

_allTowns = + towns;
_nul = _allTowns execVM "Server\CivilianTraffic.sqf";
_nul = [] execVM "Server\UpdateCivVehicles.sqf";

_handle_InitTowns = [] execVM "Server\InitTowns.sqf";
waitUntil {scriptDone _handle_InitTowns};

_nul = [] execVM "Server\UpdateTownStates.sqf";

funcBuildStruct = compile preProcessFileLineNumbers "Server\BuildStruct.sqf";
funcRepairStructure = compile preProcessFileLineNumbers "Server\RepairStructure.sqf";
funcCalcStructurePosDir = compile preProcessFileLineNumbers "Server\CalcStructurePosDir.sqf";
funcCalcBuilderPosDir = compile preProcessFileLineNumbers "Server\CalcBuilderPosDir.sqf";
funcGetIdleFactory = compile preProcessFileLineNumbers "Server\GetIdleFactory.sqf";
funcGetFactoryWithEmptyQueue = compile preProcessFileLineNumbers "Server\GetFactoryWithEmptyQueue.sqf";
funcGetSmallestAiGroup = compile preProcessFileLineNumbers "Server\GetSmallestAiGroup.sqf";
funcMoneyAdd = compile preProcessFileLineNumbers "Server\MoneyAdd.sqf";
funcMoneySpend = compile preProcessFileLineNumbers "Server\MoneySpend.sqf";
funcMoneyTransfer = compile preProcessFileLineNumbers "Server\MoneyTransfer.sqf";
funcMoveAIGroup = compile preProcessFileLineNumbers "Server\MoveAIGroup.sqf";
funcCalcStartDist = compile preProcessFileLineNumbers "server\CalcStartDist.sqf";
funcAiHeal = compile preProcessFileLineNumbers "Server\AiHeal.sqf";
funcAiRearm = compile preProcessFileLineNumbers "Server\AiRearm.sqf";
funcAiCheckSupport = compile preProcessFileLineNumbers "Server\AiCheckSupport.sqf";
funcAiCheckBuyUnit = compile preProcessFileLineNumbers "Server\AiCheckBuyUnit.sqf";
funcAiMoveToRallyPoint = compile preProcessFileLineNumbers "Server\AiMoveToRallyPoint.sqf";
funcAiPlaceSupportVehicle = compile preProcessFileLineNumbers "Server\AiPlaceSupportVehicle.sqf";
funcAddToUnitQueue = compile preProcessFileLineNumbers "Server\AddToUnitQueue.sqf";
funcSendMoneyStatus = compile preProcessFileLineNumbers "Server\SendMoneyStatus.sqf";
funcSendTownSideChange = compile preProcessFileLineNumbers "Server\SendTownSideChange.sqf";
funcSendMoneySideTotal = compile preProcessFileLineNumbers "Server\SendMoneySideTotal.sqf";
funcSendMoneySideSpent = compile preProcessFileLineNumbers "Server\SendMoneySideSpent.sqf";
funcHandleMoneyRequests = compile preProcessFileLineNumbers "Server\HandleMoneyRequests.sqf";

scriptUpdateResTownGroup = compile preProcessFileLineNumbers "Server\UpdateResTownGroup.sqf";
scriptUpdateTownGroup = compile preProcessFileLineNumbers "Server\UpdateTownGroup.sqf";
scriptUpdateCivTownGroup = compile preProcessFileLineNumbers "Server\UpdateCivTownGroup.sqf";
scriptAiUpdateLeader = compile preProcessFileLineNumbers "Server\AiUpdateLeader.sqf";
scriptAiStart = compile preProcessFileLineNumbers "Server\AiStart.sqf";
scriptAiCheckBoardTransport = compile preProcessFileLineNumbers "Server\AiCheckBoardTransport.sqf";
scriptAiUpdateCommander = compile preProcessFileLineNumbers "Server\AiUpdateCommander.sqf";
scriptInitLeaderAi = compile preProcessFileLineNumbers "Server\InitLeaderAI.sqf";
scriptAddWorker = compile preProcessFileLineNumbers "Server\AddWorker.sqf";
scriptCheckWinDestruction = compile preProcessFileLineNumbers "Server\CheckWinDestruction.sqf";
scriptCheckWinTowns = compile preProcessFileLineNumbers "Server\CheckWinTowns.sqf";
scriptSetWeather = compile preProcessFileLineNumbers "Server\SetWeather.sqf";
scriptCheckTargets = compile preProcessFileLineNumbers "Server\CheckTargets.sqf";

EventStructHit = compile preProcessFileLineNumbers "Server\EventStructHit.sqf";
EventStructPrimDestroyed = compile preProcessFileLineNumbers "Server\EventStructPrimDestroyed.sqf";
EventStructSecDestroyed = compile preProcessFileLineNumbers "Server\EventStructSecDestroyed.sqf";

supportVehiclesPlaced = [[],[]];
repairableStructureMatrix = [ [], [] ];
structuresServer = [];
SQHoldProdution = false;
gunMatrix = [ [], [] ];

cleanTime = time;
killTime = time;
averageServerFPS = 50;
averageFPS = 50;

moneyRequestsPending = [[],[]];
moneySpent = [0, 0];
indexMoneyMsg = 0;
countMoneyMsg = 10;
indexInfoMsg = 0;
countInfoMsg = 4;

primStructsPlaced = [];
WorkerHangout = [[],[]];

timeCheckSupport = 120;

// Assign ACRE Frequencies
if ( AcreAllowed ) then
{
	_freqs = [];
	for[ {_freq=0}, {_freq < 5000}, {_freq=_freq+1}] do
	{
		_freqs set [_freq, 40 + _freq * 0.025];
	};

	{
		_si = _x;
		_channels = [];
		_lastfreq = -1;

		for[ {_ch=1}, {_ch<100}, {_ch=_ch+1}] do
		{
			_trys = 0;
			while {true}do
			{
				_freqidx = floor(random(count _freqs));
				_freq = _freqs select _freqidx;

				if ( _trys > 100 || _lastfreq == -1 || abs(_lastfreq - _freq) > 1.0 ) exitWith
				{
					_freqs = _freqs - [_freq];
					_channels = _channels + [_freq];
					_lastfreq = _freq;
				};

				_trys = _trys + 1;
			};
		};

		_channels set [99, 122.8];
		pvAcreFreq set [_si, _channels];
	}forEach [siWest, siEast];

	publicVariable "pvAcreFreq";
};

// MESSAGE HANDLERS (SERVER ONLY)
MsgBuildStructure = compile preProcessFileLineNumbers "Server\MsgBuildStructure.sqf";
MsgUndo = compile preProcessFileLineNumbers "Server\MsgUndo.sqf";
MsgAddWorker = compile preProcessFileLineNumbers "Server\MsgAddWorker.sqf";
MsgBuyUnit = compile preProcessFileLineNumbers "Server\MsgBuyUnit.sqf";
MsgMoneySpent = compile preProcessFileLineNumbers "Server\MsgMoneySpent.sqf";
MsgGiveMoney = compile preProcessFileLineNumbers "Server\MsgGiveMoney.sqf";
MsgRequestMoney = compile preProcessFileLineNumbers "Server\MsgRequestMoney.sqf";
MsgUpgrade = compile preProcessFileLineNumbers "Server\MsgUpgrade.sqf";
MsgTransferCommand = compile preProcessFileLineNumbers "Server\MsgTransferCommand.sqf";
MsgRepairMHQ = compile preProcessFileLineNumbers "Server\RepairMHQ.sqf";
MsgCancelQueueEntry = compile preProcessFileLineNumbers "Server\MsgCancelQueueEntry.sqf";

"pvBuildStruct" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgBuildStructure;};
"pvUndo" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgUndo;};
"pvAddWorker" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgAddWorker;};
"pvBuyUnit" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgBuyUnit;};
"pvMoneySpent" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgMoneySpent;};
"pvMoneyGive" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgGiveMoney;};
"pvMoneyRequest" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgRequestMoney;};
"pvUpgrade" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgUpgrade;};
"pvCO" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgTransferCommand;};
"pvRepairMHQ" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgRepairMHQ;};
"pvCancelQueueEntry" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgCancelQueueEntry;};
"pvSendDebugStats" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgSendDebugStats;};

_handle_PlaceSides = [] execVM "Server\PlaceSides.sqf";
waitUntil {scriptDone _handle_PlaceSides};

// Duh.
{
	_si = _x;
	_groups = groupMatrix select _si;
	_groupsAI = [];
	_count = count _groups;

	for "_index" from 0 to (_count-1) do
	{
		_leader = leader (_groups select _index);
		if (!isPlayer _leader)then
		{
			_groupsAI set [count _groupsAI, group _leader];
			_nul = [_leader, _si, _index] spawn scriptInitLeaderAi;
		}
		else
		{
			HumanIDs set[_si, (HumanIDs select _si) + [getPlayerUID _leader]];
		};
		(scoreMoney select _si) set [_index, 0];
	};

	groupAiMatrix set [_si, _groupsAI];
}forEach [siWest, siEast];

publicVariable "groupAiMatrix";

_nul = [pvDate] spawn MsgSetDate;
publicVariable "pvDate";

_handle_SendStartMoney = [] execVM "Server\SendStartMoney.sqf";
waitUntil {scriptDone _handle_SendStartMoney};

_nul = [] execVM "Common\AdvanceTime.sqf";
_nul = [] execVM "Server\SendWeather.sqf";
_nul = [siWest] execVM "Server\UpdateRespawnAI.sqf";
_nul = [siEast] execVM "Server\UpdateRespawnAI.sqf";
_nul = [] execVM "Server\UpdateIncome.sqf";
_nul = [] execVM "Server\UpdateServer.sqf";
_nul = [] execVM "Server\CleanupVehicles.sqf";
_nul = [] execVM "Server\UpdateLeaderDest.sqf";

// Garbage Collector
MsgGarbage = compile preProcessFileLineNumbers "Server\MsgGarbage.sqf";
"pvGarbage" addPublicVariableEventHandler {_nul = [_this select 1] spawn MsgGarbage;};
_nul = [] execVM "Server\GarbageCollector.sqf";

if ( MovieColorsEnabled > 0 ) then
{
	_nul = [MovieColorsEnabled] execVM "Server\MovieColors.sqf";
};

if ( ParticlesManager > 0 ) then
{
	_nul = logicGroup createUnit ["WeatherParticlesManager",[2,2,2], [], 0, "NONE"];
};

if ( PostprocessManager > 0 ) then
{
	_nul = logicGroup createUnit ["WeatherPostprocessManager",[2,2,2], [], 0, "NONE"];
};

if ( WeatherModule > 0 ) then
{
	_nul = logicGroup createUnit ["BIS_clouds_Logic",[2,2,2], [], 0, "NONE"];
};

if ( AceWoundingEnabled > 0 ) then
{
	_nul = logicGroup createUnit ["ACE_Wounds_Logic",[2,2,2], [], 0, "NONE"];

	ace_sys_wounds_enabled = true;
	ace_wounds_prevtime = 0;
	ace_sys_wounds_no_rpunish = true;
	ace_sys_wounds_auto_assist = true;
	ace_sys_wounds_auto_assist_any = true;

	if ( AceWoundsAIEnabled == 0 ) then
	{
		ace_sys_wounds_noai = true;
		publicVariable "ace_sys_wounds_noai";
	};

	publicVariable "ace_sys_wounds_enabled";
	publicVariable "ace_wounds_prevtime";
	publicVariable "ace_sys_wounds_no_rpunish";
	publicVariable "ace_sys_wounds_auto_assist";
	publicVariable "ace_sys_wounds_auto_assist_any";
};

if ( AceDamageEnabled == 0 ) then
{
	ace_sys_vehicledamage_enabled = false;
	publicVariable "ace_sys_vehicledamage_enabled";
};

_nul = [] execVM "Server\UpdateHeadLessClients.sqf";

crcti_kb_initServerDone = true;
publicVariable "crcti_kb_initServerDone";

pvServerInfo = format["Server is ready."];
_nul = [pvServerInfo] execVM "Player\MsgServerInfo.sqf";
publicVariable "pvServerInfo";

endLoadingScreen;