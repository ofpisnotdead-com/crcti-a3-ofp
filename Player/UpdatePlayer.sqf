// args: [unit, si, gi]
_isCommander = false;
_mhqAlive = false;
_lastlock = -1;
_posRespawn = [];

_oldplace = -1;
_rankHintTime = -1;

_fpscount = [];
_lastFPSSent = time;
_lastDiagFps = -10000;

waitUntil {!isNil "mhqWest" && !isNil "mhqEast" && !isNil "mhq"};
waituntil {!isNull mhqWest && !isNull mhqEast && !isNull mhq};

player setDamage 0;
player addAction ["Options", "Player\ActionOptions.sqf", [], 4, false, false];

if ( AceWoundingEnabled > 0 ) then
{
	_nul = player execVM "x\ace\addons\sys_wounds\fnc_unitinit.sqf"
};

//inline functions#######
FWaitUntilAlive
= {
	playSound "fail";
	_cam = "camera" camCreate (position player);

	_hndl = ppEffectCreate ["colorCorrections", 1501];
	_hndl ppEffectEnable true;
	_hndl ppEffectAdjust [1, 0.9, -0.002, [0.0, 0.0, 0.0, 0.0], [0, 0, 0, 50.0], [0.0, 0.0, 0.0, 0.0]]; // Weiss
	//_hndl ppEffectAdjust [1, 0.9, -0.002, [20.0, 0.0, 0.0, 1.0], [20.0, 0, 0, 1.0], [20.0, 0.0, 0.0, 1.0]]; // Rot
	_hndl ppEffectCommit 10;

	_cam camSetTarget player;
	_cam camSetRelPos [2,2,50];
	_cam camCommit 60;

	_cam cameraEffect ["internal","back"];
	_cam camSetFOV 1;

	showCinemaBorder true;

	closeDialog 0;
	sleep 1;
	[] Exec "Player\OpenRespawnMenu.sqs";

	for [ {_index=0}, {_index<10}, {_index=_index+1}] do
	{
		player removeAction _index;
	};

	waituntil {(alive player) or (count(pvGameOver) > 0)};

	forceMap false;

	_cam cameraEffect["terminate","back"];
	camDestroy _cam;
	ppEffectDestroy _hndl;

	player addAction ["Options", "Player\ActionOptions.sqf", [], 4, false, false];
};
FCommanderInit
= {
	_nul = [mhq, false] execVM "Player\SetMHQActions.sqf";
	_mhqAlive = alive mhq;
	_lastlock = lockMHQ select playerSideIndex;
};

//Main loop####### - i know
while {true}do
{
	if ( (leader group player != ((units group player) select 0)) && (rating ((units group player) select 0) >= -2000)) then
	{
		[group player, ((units group player) select 0)] remoteExec ["selectLeader", groupOwner (group player)];
	};

	if(count(pvGameOver) > 0)exitwith {_nul = [] execVM "Player\PlayGameOverSequence.sqf"};

	if(not(alive player))then {call FWaitUntilAlive};

	if (((lockMHQ select siWest) > 0) && !(mhqWest call funcLocked)) then {mhqWest lock true;};
	if (((lockMHQ select siWest) == 0) && (mhqWest call funcLocked)) then {mhqWest lock false;};
	if (((lockMHQ select siEast) > 0) && !(mhqEast call funcLocked)) then {mhqEast lock true;};
	if (((lockMHQ select siEast) == 0) && (mhqEast call funcLocked)) then {mhqEast lock false;};

	if ((playerGroup == (groupCommander select playerSideIndex)) && !_isCommander) then
	{
		_isCommander = true;
		call FCommanderInit;
		player setUnitRank "MAJOR";
	};

	if ((playerGroup != (groupCommander select playerSideIndex)) && _isCommander) then
	{
		_isCommander = false;
		call FCommanderInit;
		player setUnitRank "CAPTAIN";
	};

	if ((_mhqAlive && !(alive mhq)) || (!_mhqAlive && (alive mhq)) || (_lastLock != (lockMHQ select playerSideIndex))) then
	{
		_nul = [mhq, _lastLock != (lockMHQ select playerSideIndex)] execVM "Player\SetMHQActions.sqf";
		_lastlock = lockMHQ select playerSideIndex;
		_mhqAlive = alive mhq;
	};

	if ( playerViewDistance > serverViewDistance ) then
	{
		setViewDistance serverViewDistance;
	}
	else
	{
		setViewDistance playerViewDistance;
	};

	_objVD = viewDistance;
	if ( _objVD > maxObjectViewDistance ) then {_objVD = maxObjectViewDistance;};
	setObjectViewDistance _objVD;

// SCORE
	_score = [playerSideIndex, playerGroupIndex] call funcCalcScore;
	_groupCount = count (groupMatrix select siWest) + count (groupMatrix select siEast);
	_rank = [playerSideIndex, playerGroupIndex] call funcCalcRank;
	_place = _rank select 0;

	if ( _place != _oldplace && _score > 0) then
	{
		_oldplace = _place;
		_rankHintTime = time;
	};

	if ( time - _rankHintTime > 60 && _rankHintTime != -1 ) then
	{
		[format["New rank:\n%1 of %2\n(Score: %3)", _place, _rank select 1, _score], false, true, htRank, true] call funcHint;
		_rankHintTime = -1;
	};

	if ( time < 600 && !isNil "pvServerVersion" ) then
	{
		if ( (productVersion select 3) < pvServerVersion ) then
		{
			[format["Version mismatch!\n\nClient: %1\nServer: %2\n\nUpdate your client!", (productVersion select 3), pvServerVersion], true, true, htVersionMismatch, true] call funcHint;
		};
		if ( (productVersion select 3) > pvServerVersion ) then
		{
			[format["Version mismatch!\n\nClient: %1\nServer: %2\n\nUpdate your Server!", (productVersion select 3), pvServerVersion], true, true, htVersionMismatch, true] call funcHint;
		};
	};

	_nul = [group player] call funcLimitGroupFatigue;

	if (serverCommandAvailable "#logout" && AdminFunctionsAvailable > 0) then
	{
		IAMADMIN = true;
	}
	else
	{
		IAMADMIN = false;
	};

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

	if ( time > _lastFPSSent + 60 ) then
	{
		_lastFPSSent = time;
		player setVariable ["FPS", round(_avgfps), true];
	};

	if ( playerBAC != playerBACPending ) then {playerBAC = playerBAC + (playerBACPending - playerBAC)*0.01;};

	if ( playerBACPending > 0 ) then {playerBACPending = playerBACPending - 0.0001;}
	else {playerBACPending = 0;};

	if ( playerBAC > 0.5) then
	{
		playerBACPending = 0;
		playerBAC = 0;
		player setDamage 1;
	};

	if ( round(playerBAC*100.0)/100 >= 0.01 ) then
	{
		[format["BAC: %1%2", round(playerBAC*100.0)/100, "%"], false, true, htBAC, true] call funcHint;
	};

	if ( (rating player) < -2000) then
	{	
		player addRating renegadeRatingAdd;
		_renegadeTimeout = (-2000 - rating player) / renegadeRatingAdd;
		_text = format["You are a renegade!\n(Friendly Fire!)\n%1 seconds remaining.", _renegadeTimeout];
		[_text, false, true, htRenegade, true] call funcHint;		
	};

	sleep 1;
};
