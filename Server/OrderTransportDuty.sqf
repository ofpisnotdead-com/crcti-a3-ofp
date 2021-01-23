// args: [unit, si, gi, [wp, wp, dist]]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_params = _this select 3;
_posPickup = ((wpCO select _si) select (_params select 0));
_posEject = ((wpCO select _si) select (_params select 1));
_distEject = 100*(1+(_params select 2));
_type = -1;
_idOrder = ((orderMatrix select _si) select _gi) select 0;
_posMove = [_posEject, 50, 150, true, _unit] call funcGetRandomPos;
_distToDest = 0;

if (alive _unit) then
{
	_state = "patrol";

	if ( _unit == (driver (vehicle _unit))) then
	{
		_type = ((vehicle _unit) getVariable "SQU_SI_GI") select 2;

		if (_type >= 0) then
		{
			if (_type in (airTransport select _si)) then
			{
				_nul = _this execVM "Server\OrderTransportDutyAir.sqf";
				_state = "finished";
			};
			if (_type in (groundTransport select _si)) then
			{
				_nul = _this execVM "Server\OrderTransportDutyGround.sqf";
				_state = "finished";
			};
		};
	};

	if ( _state != "finished" && _unit == leader _unit) then
	{
		if ( _unit != vehicle _unit ) then
		{
			[_unit] call funcEjectUnit;
			_ta = time + 10;
			waitUntil {sleep 1; _unit == vehicle _unit || time > _ta};
		};

		_posMove = [_posPickup, 50, 150, true, _unit] call funcGetRandomPos;
		_unit SetPos _posMove;

		if ( vehicle _unit == _unit ) then
		{
			[_unit,"TARGET"] call funcDisableAI;
			[_unit,"AUTOTARGET"] call funcDisableAI;
			[_unit,"FSM"] call funcDisableAI;
			_unit setSpeedMode "FULL";
			_unit setCombatMode "BLUE";
			_unit setBehaviour "CARELESS";
			[_unit] call funcDoStop;
		};

		while {_state != "finished"}do
		{
			if ( !alive _unit || isPlayer leader _unit || isPlayer _unit || _idOrder != ((orderMatrix select _si) select _gi) select 0) then
			{
				_state = "finished";
			};
			sleep 10;
		};

		[_unit, "TARGET"] call funcEnableAI;
		[_unit, "AUTOTARGET"] call funcEnableAI;
		[_unit, "FSM"] call funcEnableAI;
		_unit setCombatMode "YELLOW";
		_unit setBehaviour "AWARE";
		_unit setSpeedMode "FULL";
	};
};