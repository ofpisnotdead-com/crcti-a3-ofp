_pvAddUnit = _this select 0;

_si = _pvAddUnit select 6;
_gi = _pvAddUnit select 7;
_group = _pvAddUnit select 8;

if ( _gi >= 0 ) then
{
	_group = (groupMatrix select _si) select _gi;
};

if ( (isNull _group && isServer) || local leader _group) then
{
	_pvAddUnit spawn funcAddUnit;
};