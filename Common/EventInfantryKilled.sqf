// args: [[unit, killer], siUnit, score]

_unit = (_this select 0) select 0;
_killer = (_this select 0) select 1;
_siUnit = _this select 1;
_score = _this select 2;

_vehicle = vehicle _unit;

// Killer Score
_sigi = _killer call funcGetSideAndGroup;

_siKiller = _sigi select 0;
_giKiller = _sigi select 1;

if ( isPlayer _unit && (difficultyOption "deathMessages") == 0 ) then
{
	pvPlayerKilled = _this;
	_nul = [pvPlayerKilled] execVM "Player\MsgPlayerKilled.sqf";
	publicVariable "pvPlayerKilled";
};

if (_siKiller != -1 && _siKiller != _siUnit && _score != 0) then
{
	[_score, scInfantry, _siKiller, _giKiller] spawn funcSendScore;
};

// Victim Penalty
_sigi = _unit call funcGetSideAndGroup;

_siVictim = _sigi select 0;
_giVictim = _sigi select 1;

if (_siVictim != -1 && (_score * -DeathPenaltyFactor) != 0 && !(_giVictim in (_siVictim call funcGetAiGroupIds))) then
{
	[_score * -DeathPenaltyFactor, scInfantry, _siVictim, _giVictim] spawn funcSendScore;
};

if (_unit != _vehicle) then
{
	_dir = random 360;
	_dist = 3;
	_pos = getPos _vehicle;
	_pos set [0, _dist*(sin _dir) + (_pos select 0)];
	_pos set [1, _dist*(cos _dir) + (_pos select 1)];
	_unit setPos _pos;
	_unit setVelocity [sin _dir, cos _dir, 0];
};

[_unit, deleteUnitDelay] call funcMoveToGarbage;

