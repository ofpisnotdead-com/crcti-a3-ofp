// args: [unit, si, gi]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;

_idOrder = ((orderMatrix select _si) select _gi) select 0;
_unit doFollow _unit;

_distEject = 500;

_support = vehicle _unit;
supportVehiclesPlaced set [_si, (supportVehiclesPlaced select _si) + [_support]];

_except = [];
_state = "selecttown";
_posMove = [];

_moveTimeout = time;

while {_state != "finished"}do
{
	sleep 2;
	if ( isNull (driver _support) ) exitWith {_state = "finished";};
	if ( !(alive _support) || !(alive driver _support) || _unit != driver _support ) exitWith {_state = "finished";};
	if ( _idOrder != ((orderMatrix select _si) select _gi) select 0) exitWith {_state = "finished";};

	if ( _state == "selecttown" ) then
	{
		_res = [getPos _support, [_si], _except] call funcGetClosestTown;
		_ti = _res select 2;

		if ( _ti != -1 ) then
		{
			_posTown = getPos ((towns select _ti) select tdFlag);
			_res = [_posTown, _distEject, [_si], typesSupport select _si, [_support]] call funcGetNearbyVehicles;
			//_c = { isNull driver (_x select 0)} count _res;
			_c = count _res;

			if ( _c == 0 ) then
			{
				_posMove = _posTown;
				_state = "move";
			}
			else
			{
				_except set [count _except, _ti];
			};
		}
		else
		{
			_posMove = [getPos _support, 500, 1000, true, _support] call funcGetRandomPos;
			_state = "move";
		};

	};

	if ( _state == "move" ) then
	{
		_moveTimeout = time + 120;
		[_unit, _posMove] call funcMoveAI;
		_state = "checkmove";
	};

	if ( _state == "checkmove" ) then
	{
		if ( isNull (driver _support) ) exitWith {_state = "finished";};
		if ( !(alive _support) || !(alive driver _support) || _unit != driver _support ) exitWith {_state = "finished";};
		if ( _idOrder != ((orderMatrix select _si) select _gi) select 0) exitWith {_state = "finished";};
		if ( time > _moveTimeout ) then {_state = "selecttown";};

		if ( _support distance _posmove < _distEject ) then
		{
			_res = [getPos _support, _distEject, [_si], typesSupport select _si, [_support]] call funcGetNearbyVehicles;
			_c = {isNull driver (_x select 0)}count _res;

			if ( _c == 0 ) exitWith
			{
				_posMove = [getPos _unit, 50, 100, true, vehicle _unit] call funcGetRandomPos;
				[_unit, _posMove] call funcMoveAI;
				waitUntil {sleep 1 ; !(alive _unit) || unitReady _unit};

				if (_unit != vehicle _unit) then { (vehicle _unit) engineOn false; };
				
				_nul = [_unit] call funcEjectDisband; 
				
			};

			_state = "selecttown";
		};

	};

};