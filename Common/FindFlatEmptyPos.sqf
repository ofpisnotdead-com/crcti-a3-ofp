private ["_opos", "_pos", "_radius", "_maxradius", "_e", "_found"];

_opos = _this select 0;
_maxradius = _this select 1;

_pos = _opos;

_radius = 10;
_trys = 0;
_found = false;

_startt = time;

while {_radius < _maxradius && !_found}do
{
	_e = _pos isFlatEmpty [5, 256, 0.5, 2, 0, false, objNull];
	if ( count _e == 0 ) then
	{
		_pos = [-_radius + (_pos select 0 ) + random(_radius*2.0), -_radius + (_pos select 1 ) + random(_radius*2.0),0];
	}
	else
	{
		_pos = _e;
		_found = true;
	};

	if ( _trys > 10 ) then
	{
		_trys = 0;
		_radius = _radius + 10;
	};

	_trys = _trys + 1;
};

_endt = time;
if ( _trys > 10 ) then
{
	diag_log format["FindFlatEmptyPos: %1 %2 %3 %4 %5", _startt, _endt, _endt-_startt, _trys, _pos];
};

_pos;