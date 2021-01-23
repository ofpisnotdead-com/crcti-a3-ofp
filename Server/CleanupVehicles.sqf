while {true}do
{
	_vehicles = vehicles;

	_humans = [];
	{
		if ( alive _x && isPlayer _x ) then
		{
			_humans = _humans + [_x];
		};
	}forEach playableUnits;

	_cleanUnitDelay = cleanUnitDelay;
	if ( averageFPS < 15 ) then {_cleanUnitDelay = cleanUnitDelay * 0.5;};
	if ( averageFPS < 10 ) then {_cleanUnitDelay = cleanUnitDelay * 0.1;};
	if ( time < cleanTime ) then {_cleanUnitDelay = 0;};

	_stuckVehicleTimeOut = stuckVehicleTimeout;
	if ( averageFPS < 10 ) then {_stuckVehicleTimeOut = stuckVehicleTimeout * 0.5;};
	if ( time < cleanTime ) then {_stuckVehicleTimeOut = stuckVehicleTimeout * 0.25;};

	{
		if ( !(isNull _x) && _x != mhqWest && _x != mhqEast ) then
		{
			_dyn = _x getVariable "dynamic";
			if ( isNil "_dyn" ) then {_dyn = false;};
			_sigi = _x getVariable "SQU_SI_GI";
			if ( isNil "_sigi" ) then {_sigi = [-1,-1,-1, false];};
			_type = _sigi select 2;

			if ( _dyn ) then
			{
				_t = time;
				_humancrew = false;

				_veh = _x;
				_humandist = 100000;
				{
					_d = _veh distance _x;
					if ( _d < _humandist ) then {_humandist = _d};
				}forEach _humans;

				{
					if ( isPlayer _x || isPlayer leader _x ) then
					{
						_humancrew = true;
					};
				}forEach (crew _x);

				if ( (isNull driver _x || !canMove _x) && (isNull gunner _x || !canFire _x) && (isNull commander _x || !canFire _x) && !_humancrew ) then
				{
					_lasttime = _x getVariable "lastUsageTime";

					if ( isNil "_lasttime" || _humandist < disbandVehicleDist ) then
					{
						_x setVariable ["lastUsageTime", _t, false];
						_lasttime = _t;
					};

					if ( (_t - _lasttime) > (_cleanUnitDelay) && (alive _x)) then
					{
						if ( (!(_type in (typesSupport select siWest)) && !(_type in (typesSupport select siEast))) || time < cleanTime) then
						{
							pvUnlock = _x;
							publicVariable "pvUnlock";
							_nul = [pvUnlock] spawn MsgUnlock;

							{
								if ( !isNull _x && vehicle _x != _x ) then
								{
									[_x] call funcEjectUnit;
									sleep 1;
								};
							}forEach crew _x;
							sleep 0.1;
							[getPosATL _x, "funcLightning"] call BIS_fnc_MP;
							_x setDamage 1.0;
						};
					};

				}
				else
				{
					_x setVariable ["lastUsageTime", _t, false];
					_isTpDuty = _x getVariable ["isTpDuty", false];
					if ( isNil "_isTpDuty" ) then {_isTpDuty = false;};

					if ( !(_x isKindOf "StaticWeapon") && !(_x isKindOf "StaticSearchLight") && !_humancrew && !_isTpDuty ) then
					{

						_lp = _x getVariable "lastPosition";
						_lv = _x getVariable "lastVelocity";

						_lastpos = getPos _x;
						_lastv = 0;

						if ( !isNil "_lp" && !isNil "_lv" ) then
						{
							_lastpos = _lp;
							_lastv = _lv;
						};

						_curv = _lastpos distance (getPos _x);
						_lastv = (_lastv*0.75) + _curv;

						_x setVariable ["lastPosition", getPos _x, false];
						_x setVariable ["lastVelocity", _lastv, false];

						if ( _lastv > 2.0 ) then
						{
							_x setVariable ["lastMovingTime", _t,false];
						};

						_lastmove = _x getVariable "lastMovingTime";

						if ( isNil "_lastmove" ) then
						{
							_x setVariable ["lastMovingTime", _t,false];
							_lastmove = _t;
						};

						_timeout = _stuckVehicleTimeout;

						if ( !canMove _x ) then
						{
							_timeout = 5;
						};

						//diag_log format["%1 %2 %3 %4 %5 %6 %7 %8", str(_x), _lastpos, _lastv, _lastmove, driver _x, gunner _x, commander _x, crew _x];

						if ((_t-_lastmove) > _timeout) then
						{
							_veh = _x;
							diag_log format["%1 seems to be stuck. Ejecting crew.", _veh];

							pvUnlock = _veh;
							publicVariable "pvUnlock";
							_nul = [pvUnlock] spawn MsgUnlock;

							{
								if ( !isNull _x && vehicle _x != _x ) then
								{
									(group _x) leaveVehicle _veh;
									[_x] call funcEjectUnit;
									sleep 0.1;
								};
							}forEach crew _veh;

						};
					};

				};
			};
		};
	}forEach _vehicles;
	if ( time > cleanTime ) then
	{
		sleep 30 + random(30);
	};
};