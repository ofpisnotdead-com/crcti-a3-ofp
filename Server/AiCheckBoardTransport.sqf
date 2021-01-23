// args: [unit, si, gi]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;

_transp = objNull;

// Check air
_typesTransport = airTransport select _si;
if (count _typesTransport > 0 ) then
{
	_res = [getPos _unit, 500, [_si], _typesTransport, []] call funcGetNearbyVehicles;
	_transports = [];

	{
		_v = _x select 0;
		_cargospace = _v emptyPositions "cargo";

		if ( (damage _v) < 0.5 && ((getPos _v) select 2) < 5 && (speed _v) < 1 && !(_v call funcLocked) && (_cargospace > 0) && !(isNull driver _v) ) then
		{
			_transports set [count _transports, _v];
		};
	}foreach _res;

	if (count _transports > 0 ) then
	{
		_transp = _transports select (random (count _transports) - 0.5);
	};

};

// Check ground
if ( isNull _transp ) then
{
	_typesTransport = groundTransport select _si;

	if (count _typesTransport > 0 ) then
	{
		_res = [getPos _unit, 500, [_si], _typesTransport, []] call funcGetNearbyVehicles;
		_transports = [];

		{
			_v = _x select 0;
			_cargospace = _v emptyPositions "cargo";

			if ( (damage _v) < 0.5 && ((getPos _v) select 2) < 5 && (speed _v) < 1 && !(_v call funcLocked) && (_cargospace > 0) && !(isNull driver _v) ) then
			{
				_transports set [count _transports, _v];
			};
		}foreach _res;

		if (count _transports > 0 ) then
		{
			_transp = _transports select (random (count _transports) - 0.5);
		};
	};
};

// Duuuh. No wieheikels?
if ( isNull _transp ) then
{
	[_unit, getPos _unit, 10, 20] call funcMoveAI;
}
else
{
	[_unit, _transp] call funcAssignAsCargo;

	/*[_unit,"TARGET"] call funcDisableAI;
	[_unit,"AUTOTARGET"] call funcDisableAI;
	[_unit,"FSM"] call funcDisableAI;
	_unit setSpeedMode "FULL";
	_unit setCombatMode "BLUE";
	_unit setBehaviour "CARELESS";*/

	_timeAbort = time + 300;
	waitUntil {sleep 1 ; !alive _transp || !alive _unit || time > _timeAbort || _transp == (vehicle _unit) || (_transp call funcLocked) || ((getPos _transp) select 2 > 20) || (speed _transp > 20)};

	_timeAbort = time + 180;
	while {sleep 1 ; alive _unit && alive _transp && (alive driver _transp) && !(isNull driver _transp) && (time < _timeAbort) && (_transp == (vehicle _unit))}do
	{
		sleep 1;
		if ( (speed _transp > 2) || ((getPos _transp) select 2 > 2)) then
		{
			_timeAbort = time + 180;
		};
	};
	
	[_unit] call funcEjectUnit;

	/*[_unit, "TARGET"] call funcEnableAI;
	[_unit, "AUTOTARGET"] call funcEnableAI;
	[_unit, "FSM"] call funcEnableAI;
	_unit setCombatMode "YELLOW";
	_unit setBehaviour "AWARE";
	_unit setSpeedMode "FULL";*/
};

