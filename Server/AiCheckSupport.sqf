// args: [unit, si, gi, forceRearm]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_vt = -1;
_v = vehicle _unit;

_heal = false;
_refuel = false;
_rearm = false;

_idOrder = (((orderMatrix select _si) select _gi) select 0);

_nearby = [getPos _v, 500, [_si], typesSupport select _si, [_v]] call funcGetNearbyVehicles;

_distRepair = 0;
_supportRepair = objNull;
_distRefuel = 0;
_supportRefuel = objNull;
_distRearm = 0;
_supportRearm = objNull;

{
	if ( (_x select 1) in (typesRepair select _si)) then
	{
		_distRepair = _x select 2;
		_supportRepair = _x select 0;
	};
	if ( (_x select 1) in (typesRefuel select _si)) then
	{
		_distRefuel = _x select 2;
		_supportRefuel = _x select 0;
	};
	if ( (_x select 1) in (typesRearm select _si)) then
	{
		_distRearm = _x select 2;
		_supportRearm = _x select 0;
	};
}forEach _nearby;

if (count _this > 3 ) then
{
	_rearm = true;
};

if ( _v isKindof "Man" ) then
{
	if (damage _unit > 0.2 ) then
	{
		_heal = true;
	};

	if ( !someAmmo _unit ) then
	{
		_rearm = true;
	};

}
else
{
	_vt = ((_v getVariable "SQU_SI_GI")select 2);

	if (damage _v > 0.2 || (!isNull (gunner _v) && !canFire _v) ) then
	{
		_heal = true;
	};

	if (fuel _v < 0.2 ) then
	{
		_refuel = true;
	};

	{
		if ((damage _x) > 0.2) then
		{
			_heal = true;
		};
	}foreach (crew _v);

	_rearmData = _v call funcGetRearmData;
	_rearmMags = _rearmData select 1;

	if (count _rearmMags == 0) then
	{
		_rearm = false;
	}
	else
	{
		_rearm = true;
		_weapons = weapons _v;

		{
			if ((_v ammo _x) > 0) then
			{
				_rearm = false;
			};
		}foreach _weapons;

	};
};

if ( _distRepair > 500 || isNull _supportRepair) then {_heal = false;};
if ( _distRefuel > 500 || isNull _supportRefuel) then {_refuel = false;};
if ( _distRearm > 500 || isNull _supportRearm) then {_rearm = false;};

if ( _heal ) then {_refuel = false; _rearm = false};
if ( _refuel ) then {_rearm = false;};

_support = [];

if ( _heal || _rearm || _refuel) then
{
	if ( _heal ) then {_support = _supportRepair;};
	if ( _refuel ) then {_support = _supportRefuel;};
	if ( _rearm ) then {_support = _supportRearm;};

	_timeAbort = time + 10*60;

	if ( !(_v isKindof "Air")) then
	{

		[driver _v, getPos _support, 5, 10] call funcMoveAI;

		while
		{	(_v distance _support) > repairRange
			&& alive driver _v
			&& alive _support
			&& time < _timeAbort
			&& _idOrder == (((orderMatrix select _si) select _gi) select 0)}do
		{
			sleep 10;
		};
	}
	else
	{
		[driver _v, 40] call funcFlyInHeight;
		[driver _v, getPos _support] call funcMoveAI;

		while
		{	alive driver _v
			&& (alive _support)
			&& time < _timeAbort
			&& _idOrder == (((orderMatrix select _si) select _gi) select 0)
			&& (([getPos _v, getPos _support] call funcDistH > 6*repairRange) || (speed _v > 5))}do
		{
			sleep 10;
		};

		[driver _v,5] call funcFlyInHeight;
		_posMove = getPos _support;
		[driver _v, _posMove] call funcMoveAI;
		_timeRetry = time + 60;

		while
		{	alive driver _v
			&& alive _support
			&& time < _timeRetry
			&& _idOrder == (((orderMatrix select _si) select _gi) select 0)
			&& ((_v distance _support) > 2*repairRange)}do
		{
			sleep 10;
		};

	};

	if ( alive driver _v && alive _support && ((_v distance _support) < 2*repairRange) ) then
	{
		[driver _v,0] call funcFlyInHeight;
		[driver _v] call funcDoStop;

		if ( _heal ) then
		{
			_handle = [_unit, _si, _gi, _v, _vt, _support] spawn funcAiHeal;
			waitUntil {sleep 1 ; scriptDone _handle};
		};
		if ( _refuel ) then
		{
			[_v, 1.0] call funcSetFuel;
		};
		if ( _rearm ) then
		{
			_handle = [_unit, _si, _gi, _v, _vt, _support] spawn funcAiRearm;
			waitUntil {sleep 1 ; scriptDone _handle};
		};
	};

};