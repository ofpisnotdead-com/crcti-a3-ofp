private ["_veh", "_res"];
_veh = _this;
_res = false;

if ( !THISISARMA3 ) then
{
	_res = locked _veh;
}
else
{
	if ( locked _veh < 2 ) then
	{
		_res = false;
	};
	if ( locked _veh > 1 ) then
	{
		_res = true;
	};
};

_res