// args: [unit, si, gi, [wp, wp, dist]]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_params = _this select 3;

_posPickup = ((wpCO select _si) select (_params select 0));
_posEject = ((wpCO select _si) select (_params select 1));
_posMove = [];
_landPos = [];
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

{
	[_x,"TARGET"] call funcDisableAI;
	[_x,"AUTOTARGET"] call funcDisableAI;
	[_x,"FSM"] call funcDisableAI;
	_x setSpeedMode "FULL";
	_x setCombatMode "BLUE";
	_x setBehaviour "CARELESS";
}forEach _tcrew;

_transp setVariable ["isTpDuty", true, true];

_land = "";
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
	sleep 1;

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

		if (((getPosATL _transp) select 2) > 10) then
		{
			_state = "Land";
			_nextState = "WaitForCargo";
		}
		else
		{			
			_transp setDamage 0;
			[_transp, 1.0] call funcSetFuel;
			[driver _transp] call funcDoStop;
			_state = "WaitingForCargo";
		};
	};

	if ( _state == "WaitingForCargo" ) then
	{
		if (_transp call funcLocked) then { _nul = [_transp, false] spawn funcLockVehicle; };
		
		if (((getPosATL _transp) select 2) > 10) then
		{
			_state = "Land";
			_nextState = "WaitForCargo";
		};

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
		if ( time > _moveoutTime || (_transp emptyPositions "cargo") == 0 ) then
		{
			_tcrew = [_transp] call funcGetAllCrewWithoutCargo;

			{
				[_x, "TARGET"] call funcDisableAI;
				[_x, "AUTOTARGET"] call funcDisableAI;
				_x setSpeedMode "FULL";
				_x setCombatMode "BLUE";
				_x setBehaviour "CARELESS";
			}forEach _tcrew;

			[format["Departing!", round(_moveOutTime - time)], _transp] execVM "Server\Info\VehicleMessage.sqf";
			["", _transp, {playMusic "LeadTrack01_F_Heli";}] execVM "Server\Info\VehicleMessage.sqf";
			_state = "MoveEject";
		};
	};

	if ( _state == "MovePickup" ) then
	{
		_posPickup = ((wpCO select _si) select (_params select 0));
		[_transp, 50 + random(20)] call funcFlyInHeight;
		_posMove = [_posPickup, 0, 200, true, _transp] call funcGetRandomPos;
		[_unit, _posMove] call funcMoveAI;
		_timeRepeat = time + _timeOut;

		_state = "MovePickup_Check";
	};

	if ( _state == "MovePickup_Check") then
	{
		[_transp, true] spawn funcLockVehicle;
		if ( time > _timeRepeat ) then
		{
			[_unit, _posMove] call funcMoveAI;
			_timeRepeat = time + _timeOut;
		};

		if ( _posMove distance _transp < 300 && unitReady _transp) then
		{
			_landPos = _posMove;
			_nextState = "WaitForCargo";
			_prevState = "MovePickup";
			_land = "LAND";
			_state = "Land";
		};

	};

	if ( _state == "MoveEject" ) then
	{
		_posEject = ((wpCO select _si) select (_params select 1));
		[_transp, true] spawn funcLockVehicle;
		[_transp, 50 + random(20)] call funcFlyInHeight;
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

		if ( _posMove distance _transp < 200 ) then
		{
			["", _transp, {playMusic "Track10_StageB_action";}] execVM "Server\Info\VehicleMessage.sqf";
			_shell = createVehicle ["SmokeShellYellow",_posEject, [], 0, "FORM"];

			_landPos = _posMove;
			_nextState = "EjectCargo";
			_prevState = "MoveEject";
			_land = "GET IN";
			_state = "Land";
		};

		if ( _posMove distance _transp < 500 ) then
		{
			_targets = _transp nearTargets 1500;

			{
				_tt = _x select 1;
				_ts = _x select 2;
				if ( !(_tt isKindOf "Man") && ((_si == siWest && _ts == East) || (_si == siEast && _ts == West) || _ts == Resistance)) exitWith
				{
					["", _transp, {playMusic "Track12_StageC_action";}] execVM "Server\Info\VehicleMessage.sqf";
					_state = "Drop";
				};
			}forEach _targets;
		};

	};

	if ( _state == "Land" ) then
	{
		[_transp, 50] call funcFlyInHeight;
		[driver _transp] call funcDoStop;
		[_transp, _land] call funcLand;
		_timeRetry = time + _timeOut*6;
		_state = "Landed_Check";
	};

	if ( _state == "Landed_Check" ) then
	{
		if (time > _timeRetry) then
		{
			_state = "Land";
		};

		if (((getPosATL _transp) select 2) < 5) then
		{
			_state = _nextState;
		};

	};

	if ( _state == "EjectCargo") then
	{
		[_transp, false] spawn funcLockVehicle;
		sleep 2;
		if (((getPosATL _transp) select 2) > 15) then
		{
			_state = "Land";
		}
		else
		{
			[_transp, _si, 0.25] spawn funcEjectCargo;
			_ejectTime = time + _timeOut*4;
			_state = "EjectCargo_Check";
		};

	};

	if ( _state == "EjectCargo_Check" ) then
	{
		_cargo = [_transp] call funcGetAllCargo;

		if ( count(_cargo) == 0 || time > _ejectTime ) then
		{
			_state = "MovePickup";
		};
	};

	if ( _state == "Drop") then
	{
		[_transp, false] spawn funcLockVehicle;
		[_transp, 150] call funcFlyInHeight;
		[_unit, _posPickup] call funcMoveAI;
		sleep 5;
		if (((getPosATL _transp) select 2) > 100) then
		{
			[_transp, _si, 2] spawn funcEjectCargo;
			_ejectTime = time + _timeOut*4;
			_state = "EjectCargo_Check";
		};
	};
};

_transp setVariable ["isTpDuty", false, true];
[_transp, false] spawn funcLockVehicle;

{
	[_x, "TARGET"] call funcEnableAI;
	[_x, "AUTOTARGET"] call funcEnableAI;
	[_x, "FSM"] call funcEnableAI;
	_x setCombatMode "YELLOW";
	_x setBehaviour "AWARE";
	_x setSpeedMode "FULL";
}forEach _tcrew;

