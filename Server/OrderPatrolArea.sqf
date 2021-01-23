// args: [unit, si, gi, [wp, dist]]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_params = _this select 3;

_group = ((groupMatrix select _si) select _gi);

_pos = ((wpCO select _si) select (_params select 0));
_dist = 50*((_params select 1) + 1);

_idOrder = ((orderMatrix select _si) select _gi) select 0;

_timeCheckSupport = time + 30 + random 60;

_timeout = time;
_state = "update";
_posMove = [];
_distToDest = 0;

while {_state != "finished"}do
{
	sleep 10 + random(10);

	if (isPlayer leader _unit || isPlayer _unit || !(alive _unit) || _idOrder != ((orderMatrix select _si) select _gi) select 0 ) then
	{
		_state = "finished";
	};

	if ( _state == "update") then
	{
		if ( _unit == (driver vehicle _unit) && !((vehicle _unit) isKindOf "StaticWeapon") ) then
		{
			if ( time > _timeCheckSupport ) then
			{
				_timeCheckSupport = time + timeCheckSupport + random(timeCheckSupport);
				_handle = [_unit, _si, _gi] spawn funcAiCheckSupport;
				waitUntil {sleep 5 ; scriptDone _handle};
			};

			_gundist = 100000;
			_nearestgun = objNull;
			_guns = gunMatrix select _si;

			if ( _unit == vehicle _unit && count(assignedVehicleRole _unit) == 0) then
			{
				{
					if ( (_unit distance _x) < _gundist && (isNull assignedGunner _x) && (isNull gunner _x) && (someAmmo _x) ) then
					{
						_gundist = _unit distance _x;
						_nearestgun = _x;
					};
				}forEach _guns;
			};

			if ( !isNull _nearestgun && (_pos distance _nearestgun) < _dist ) then
			{
				[_unit, _nearestGun] call funcAssignAsGunner;
				
				_timeout = time + 30 + random(30);
				_state = "sleep";
			}
			else
			{
				[driver vehicle _unit, _pos, 0, _dist] call funcMoveAI;
				_timeout = time + 30 + random(30);
				_state = "move";
			};

		}
		else
		{
			if ( ((vehicle _unit) isKindOf "StaticWeapon") && !(someAmmo (vehicle _unit))) then
			{
				[_unit] call funcEjectUnit;
			};
		};

	};

	if ( _state == "move" ) then
	{
		if ( unitReady (driver vehicle _unit) || time > _timeout ) then
		{
			_state = "update";
		};
	};

	if ( _state == "sleep") then
	{
		if ( time > _timeout ) then
		{
			_state = "update";
		};
	};
};

if ( (vehicle _unit) isKindOf "StaticWeapon" ) then
{
	[_unit] call funcEjectUnit;
};
