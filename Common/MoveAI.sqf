// args: [unit, pos]
// return: none
private ["_unit", "_veh", "_pos", "_minDist", "_maxDist", "_dest", "_rpos", "_lastMovePos"];

_unit = _this select 0;

if ( _unit == (driver vehicle _unit) ) then
{
	if ( !local _unit) then
	{
		[_this, "funcMoveAI", [_unit], false, true] call BIS_fnc_MP;
	}
	else
	{
		_veh = vehicle _unit;
		_pos = _this select 1;

		_lastMovePos = _unit getVariable ["lastMovePos", getPos _unit];

		_minDist = 0;
		_maxDist = 0;
		if ( (count _this) > 2 ) then {_minDist = _this select 2;};
		if ( (count _this) > 3 ) then {_maxDist = _this select 3;};

		if ( _maxDist < _minDist ) then {_maxDist = _minDist;};

		_dest = [0,0,0];
		_expDest = expectedDestination _unit;
		if ( !isNil "_expDest" && {count(_expDest) > 0}) then { _dest = _expDest select 0; };

		_dest set [2,0];
		_pos set[2,0];

		if ( unitReady (vehicle _unit) || ((getPos _unit) distance _lastMovePos) < 2 || (_dest distance _pos) < _minDist || (_dest distance _pos) > _maxDist ) then
		{
			_rpos = _pos;
			if ( _maxDist > 0 ) then
			{
				_rpos = [_pos, _minDist, _maxDist, true, vehicle _unit] call funcGetRandomPos;
			};

			_unit doFollow _unit;
			_veh doMove _rpos;
			_unit setUnitPos "AUTO";
			_unit setSpeedMode "FULL";
			//diag_log format["MOVE: %1 %2 %3 %4 %5 %6", str(_unit), _minDist, _maxDist, _dest, _pos, str(_dest distance _pos)];
		};
		/*else
		 {
		 diag_log format["REDUNDANT MOVE: %1 %2 %3 %4 %5 %6", str(_unit), _minDist, _maxDist, _dest, _pos, str(_dest distance _pos)];
		 };*/

		_unit setVariable ["lastMovePos", getPos _unit, false];
	};
};