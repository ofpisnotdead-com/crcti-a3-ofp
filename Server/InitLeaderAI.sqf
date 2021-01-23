// args: [unit, si, gi]

if ( isServer ) then
{
	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};
	waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
	waitUntil {!isNull mhqWest && !isNull mhqEast};

	[_this select 0, _this select 1, _this select 2] execVM "Common\PlaceGroupLeader.sqf";
	[_this select 0, _this select 1] execVM "Server\EquipGroupLeaderAI.sqf";

	if ( AceWoundingEnabled > 0 ) then
	{
		_nul = (_this select 0) execVM "x\ace\addons\sys_wounds\fnc_unitinit.sqf";
	};

	_nul = _this spawn scriptAiUpdateLeader;
};