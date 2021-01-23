private ["_maximum", "_sections", "_r"];

_maximum = _this select 0;
_sections = _this select 1;

_r = 0;

for[ {_i=0}, {_i<_sections}, {_i=_i+1}] do
{
	_r = _r + random(_maximum);
};

_r = _r - (_sections * 0.5);
_r = _r / (_sections * 0.5);
_r = (_r + 1.0) / 2.0;

_r

