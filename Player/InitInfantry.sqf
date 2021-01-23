// args: [unit, type, si]
_unit = _this select 0;
_type = _this select 1;
_si = _this select 2;

if (_unit in (units playerGroup) && _unit == driver vehicle _unit) then
{
	if ( (posRally select 0) != -1 && (posRally select 0) != -1 ) then
	{
		_unit doMove ([posRally, 10, 10, true, _unit] call funcGetRandomPos);
	};
};
