private ["_str", "_i", "_hash", "_c", "_v"];

_hash = [];
_str = toArray(_this);

for[ {_i=0}, {_i < count(_str)}, {_i=_i+1}] do
{
	_v = 0;
	_c = _str select _i;

	if ( _c >= 65 && _c <= 90) then
	{
		_c = _c + 32;
	};

	if ( _c >= 48 && _c <= 57) then
	{
		_v = _c - 48;
	};

	if ( _c >= 97 && _c <= 122) then
	{
		_v = _c - 87;
	};

	if ( _v > 0 ) then
	{
		_hash set [count(_hash), _v];
	};
};

_hash
