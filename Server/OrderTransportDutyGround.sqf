// args: [unit, si, gi, [wp, wp, dist]]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_params = _this select 3;

_posPickup = ((wpCO select _si) select (_params select 0));
_posEject = ((wpCO select _si) select (_params select 1));
_posMove = [];
_distEject = 100*(1+(_params select 2));

_idOrder = ((orderMatrix select _si) select _gi) select 0;
_moveoutTime = time;
_lastCargoCount = -1;
_ejectTime = time;
_timeRepeat = time;
_timeRetry = time;

_timeOut = 15;

_transp = vehicle _unit;
_tcrew = [_transp] call funcGetAllCrewWithoutCargo;
_cargo = [_transp] call funcGetAllCargo;

_transp setVariable ["isTpDuty", true, true];

{
	[_x,"TARGET"] call funcDisableAI;
	[_x,"AUTOTARGET"] call funcDisableAI;
	[_x,"FSM"] call funcDisableAI;
	_x setSpeedMode "FULL";
	_x setCombatMode "BLUE";
	_x setBehaviour "CARELESS";
}forEach _tcrew;


_nextState = "";
_prevState = "";

_state = "WaitForCargo";

if ((count _cargo > 0) && ( (_transp distance _posPickup) > 500 )) then
{
	_state = "MoveEject";
};

if ((count _cargo == 0) && ( (_transp distance _posPickup) > 500 )) then
{
	_state = "MovePickup";
};

while {_state != "finished"}do
{
	sleep 5;

	if ( isPlayer leader _unit || isPlayer _unit || !alive _unit || !alive _transp || _transp != (vehicle _unit) || _unit != (driver vehicle _unit) || (_idOrder != ((orderMatrix select _si) select _gi) select 0)) then
	{
		_state = "finished";
	};

	if ( _state == "MoveEject_Check" ) then
	{
		_cargo = [_transp] call funcGetAllCargo;
		if ( count(_cargo) == 0 ) then
		{
			_state = "MovePickup";
		};
	};

	if ( _state == "WaitForCargo") then
	{
		_transp setVariable ["lastMovingTime", time, false];		
		_transp setDamage 0;
		[_transp, 1.0] call funcSetFuel;
		[driver _transp] call funcDoStop;
		_state = "WaitingForCargo";
	};

	if ( _state == "WaitingForCargo") then
	{
		if (_transp call funcLocked) then { _nul = [_transp, false] spawn funcLockVehicle; }; 
		
		_cargo = [_transp] call funcGetAllCargo;

		if ( count _cargo == 0 ) then
		{
			_moveOutTime = time + 80;
		};
		if (_lastCargoCount < count _cargo && _moveOutTime - time < 60 ) then
		{
			_moveOutTime = _moveOutTime + 10;
		};
		_lastCargoCount = count _cargo;

		[format["Departing in %1 seconds!", round(_moveOutTime - time)], _transp] execVM "Server\Info\VehicleMessage.sqf";

		if ( time > _moveoutTime || (_transp emptyPositions "cargo") == 0) then
		{
			[format["Departing!", round(_moveOutTime - time)], _transp] execVM "Server\Info\VehicleMessage.sqf";
			_state = "MoveEject";
		};
	};

	if ( _state == "MovePickup" ) then
	{
		_posPickup = ((wpCO select _si) select (_params select 0));
		_posMove = [_posPickup, 0, 200, true, _transp] call funcGetRandomPos;
		[_unit, _posMove] call funcMoveAI;
		_timeRepeat = time + _timeOut;

		_state = "MovePickup_Check";
	};

	if ( _state == "MovePickup_Check") then
	{

		if ( time > _timeRepeat ) then
		{
			[_unit, _posMove] call funcMoveAI;
			_timeRepeat = time + _timeOut;
		};

		if ( _posMove distance _transp < 150 ) then
		{
			_nextState = "WaitForCargo";
			_prevState = "MovePickup";
			_state = "Stop";
		};

	};

	if ( _state == "MoveEject" ) then
	{
		_posEject = ((wpCO select _si) select (_params select 1));
		_posMove = [_posEject, 0, _distEject, true, _transp] call funcGetRandomPos;
		[_unit, _posMove] call funcMoveAI;
		_timeRepeat = time + _timeOut;
		_state = "MoveEject_Check";
	};

	if ( _state == "MoveEject_Check") then
	{

		if ( time > _timeRepeat ) then
		{
			[_unit, _posMove] call funcMoveAI;
			_timeRepeat = time + _timeOut;
		};

		if ( _posMove distance _transp < 150 ) then
		{
			_nextState = "EjectCargo";
			_prevState = "MoveEject";
			_state = "Stop";
		};
	};

	if ( _state == "Stop" ) then
	{
		[driver _transp] call funcDoStop;
		_state = _nextState;
	};

	if ( _state == "EjectCargo") then
	{
		_nul = [_transp, false] spawn funcLockVehicle;
		sleep 5;
		_nul = [_transp, _si, 2] spawn funcEjectCargo;
		_ejectTime = time + 90;
		_state = "EjectCargo_Check";
	};

	if ( _state == "EjectCargo_Check" ) then
	{
		_cargo = [_transp] call funcGetAllCargo;

		if ( count(_cargo) == 0 || time > _ejectTime ) then
		{
			_state = "MovePickup";
		};
	};

};

_nul = [_transp, false] spawn funcLockVehicle;
_transp setVariable ["isTpDuty", false, true];

{
	[_x, "TARGET"] call funcEnableAI;
	[_x, "AUTOTARGET"] call funcEnableAI;
	[_x, "FSM"] call funcEnableAI;
	_x setCombatMode "YELLOW";
	_x setBehaviour "AWARE";
	_x setSpeedMode "FULL";
}forEach _tcrew;
