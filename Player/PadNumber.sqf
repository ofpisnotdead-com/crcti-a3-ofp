private ["_number", "_digits", "_spacer", "_i"];

_number = _this select 0;
_digits = _this select 1;

_spacer = "";
for [ {_i=0}, {_i<_digits}, {_i=_i+1}] do
{
	if ( _number < (10^_i) ) then
	{
		_spacer = format["%1 ", _spacer];
	};
};

format["%1%2", str(_number), _spacer]