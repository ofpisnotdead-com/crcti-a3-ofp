// [[handlerargs], _si,_gi, isLeader?]

_unit = (_this select 0) select 0;
_si = _this select 1;
_gi = _this select 2;
_isLeader = _this select 3;

[_unit, "MOVE"] call funcEnableAI;
[_unit, "TARGET"] call funcEnableAI;
[_unit, "AUTOTARGET"] call funcEnableAI;
[_unit, "ANIM"] call funcEnableAI;
[_unit, "FSM"] call funcEnableAI;

_unit setDamage 0;
unassignVehicle _unit;
[_unit] orderGetIn false;
[_unit] allowGetIn false;

if ( AceWoundingEnabled > 0 ) then
{
	_nul = _unit execVM "x\ace\addons\sys_wounds\fnc_unitinit.sqf";
};

if ( (isPlayer _unit && FatigueEnabled > 1) || ((!isPlayer _unit) && (FatigueEnabled == 1 || FatigueEnabled == 3))) then
{
	_unit enableFatigue true;
}
else
{
	_unit enableFatigue false;
};

_SiGi = [_si,_gi,-2, false];
_unit setVariable["SQU_SI_GI", _SiGi,true];

_marker = "Respawn_West";
if (_si == siEast) then {_marker = "Respawn_East";};

_posRespawn = getMarkerPos _marker;

if ( !isPlayer _unit ) then
{
	_spawnSetting = (((aiSetting select _si) select _gi) select aisRespawn);
	if ( _spawnSetting > 0 && _spawnSetting <= count(BaseMatrix select _si)) then
	{
		_posRespawn = (BaseMatrix select _si) select (_spawnSetting - 1);
	};
}
else
{
	playerBAC = 0;
	playerBACPending = 0;

	pvPlayerRespawn = [_si, _unit];
	_nul = [pvPlayerRespawn] execVM "Player\MsgPlayerRespawn.sqf";
	publicVariable "pvPlayerRespawn";
};

_rpos = [_posRespawn, 5, 15, true, _unit] call funcGetRandomPos;
_unit setPos _rpos;
_unit doMove _rpos;

_unit setVehicleAmmo 1;

if ( _isLeader ) then
{
	if ( isPlayer _unit ) then
	{
		_nul = [_unit, _si] execVM "Player\EquipPlayerRespawn.sqf";
	}
	else
	{
		_nul = [_unit, _si] execVM "Server\EquipGroupLeaderAI.sqf";
	};
};