private ["_t", "_min", "_secs"];

_t = floor(_this);

_hours = floor(_t/3600);
_min = floor((_t mod 3600)/60);
_secs = (_t mod 60);

if ( _secs < 10 ) then
{
	_secs = format["0%1", _secs];
};

_res = "";
if ( _hours > 0 ) then
{
	if ( _min < 10 ) then
	{
		_min = format["0%1", _min];
	};

	_res = format["%1:%2:%3", _hours, _min, _secs];
}
else
{
	_res = format["%1:%2", _min, _secs];
};

_res