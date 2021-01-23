// arguments: [posOrigin, distMin, distMax, search for empty position, object to place ]
// return: pos

private ["_dir", "_dist", "_pos", "_npos", "_object", "_empty", "_trys"];

_pos = [];
_trys = 0;

_startt = time;

while {count(_pos) == 0}do
{
	_trys = _trys + 1;
	_dir = random 360;
	_dist = (_this select 1) + random ((_this select 2) - (_this select 1));
	_pos = [((_this select 0) select 0) + _dist*(sin _dir), ((_this select 0) select 1) + _dist*(cos _dir),0];

	if ( _trys > 100 ) exitWith {};

	_empty = _this select 3;
	_object = _this select 4;

	if ( _empty ) then
	{
		if ( !isNull _object ) then
		{
			_pos = _pos findEmptyPosition [0,_dist, typeOf _object];
		}
		else
		{
			_pos = _pos findEmptyPosition [0,_dist];
		};

		if ( (count _pos) > 0 ) then
		{
			if ( !(_object isKindof "Ship") && SurfaceIsWater [_pos select 0, _pos select 1]) then
			{
				_pos = [];
			};
		};
	};
};

_endt = time;
if ( _trys > 10 ) then
{
	diag_log format["GetRandomPos: %1 %2 %3 %4 %5 %6", _startt, _endt, _endt-_startt, _trys, _pos, _empty];
};

_pos

