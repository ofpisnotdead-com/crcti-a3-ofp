_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_movePos = [];

if ( isServer && alive _unit ) then
{
	sleep 5 + random(5);
	
	_vehicle = vehicle _unit;
	if ( _vehicle isKindOf "StaticWeapon" ) then
	{
		unassignVehicle _unit;
		[_unit] orderGetIn false;
		[_unit] allowGetIn false;		
	};

	[_unit, "TARGET"] call funcEnableAI;
	[_unit, "AUTOTARGET"] call funcEnableAI;
	[_unit, "FSM"] call funcEnableAI;

	_unit setCombatMode "RED";
	_unit setBehaviour "AWARE";
	_unit setSpeedMode "FULL";

	_idOrder = ((orderMatrix select _si) select _gi) select 0;

	_typeVehicle = -2;
	_sigi = _vehicle getVariable "SQU_SI_GI";
	if ( !isNil "_sigi" ) then {_typeVehicle = _sigi select 2;} else {_typeVehicle = -2;};

	if ( _unit != _vehicle && _typeVehicle in (typesSupport select _si) && _unit == driver _vehicle ) then
	{
		_nul = [_unit, _si, _gi] spawn funcAiPlaceSupportVehicle;
	}
	else
	{
		if ( (((aiSetting select _si) select _gi) select aisRallyPoint) != 0 && _unit == driver _vehicle ) then
		{
			_nul = [_unit, _si, _gi] spawn funcAiMoveToRallyPoint;
			waitUntil {sleep 1 ; !(alive _unit) || unitReady _unit || (_idOrder != ((orderMatrix select _si) select _gi) select 0)};
		};

		if ( (((aiSetting select _si) select _gi) select aisPickupWait) != 0 && ((((aiSetting select _si) select _gi) select aisFormation) == 0 || _unit != leader _unit)) then
		{
			if ( _unit == (vehicle _unit) ) then
			{
				_timeCheckBoardStart = time;
				_posCheckBoardStart = getPos _unit;

				while {vehicle _unit == _unit && alive _unit && ([getPos _unit, _posCheckBoardStart] call funcDistH) < 200 && time < (_timeCheckBoardStart + 60*(((aiSetting select _si) select _gi) select aisPickupWait)) && (_idOrder == ((orderMatrix select _si) select _gi) select 0)}do
				{
					_board_handle = [_unit, _si, _gi] spawn scriptAiCheckBoardTransport;
					_to = time + 10;
					waitUntil {sleep 1 ; (scriptDone _board_handle) || (_idOrder != ((orderMatrix select _si) select _gi) select 0)};
					terminate _board_handle;
					waitUntil {sleep 1 ; time > _to || vehicle _unit != _unit || !alive _unit};
				};
			};

			_cargo = [vehicle _unit] call funcGetAllCargo;
			if ( _unit in _cargo ) then
			{
				waitUntil {sleep 1 ; (_idOrder != ((orderMatrix select _si) select _gi) select 0) || !(alive _unit) || vehicle _unit == _unit || isNull (driver vehicle _unit)};
			};
		};

		if (_idOrder == ((orderMatrix select _si) select _gi) select 0) then
		{
			_order = (orderMatrix select _si) select _gi;
			_script = (orderDefs select (_order select 1)) select 2;
			[_unit, _si, _gi, _order select 2] spawn _script;
		};

	};

};