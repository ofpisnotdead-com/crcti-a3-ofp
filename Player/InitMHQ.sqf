// args [object, type, si]

_mhq = _this select 0;
_si = _this select 2;

if ( _si == siWest ) then
{
	mhqWest = _mhq;
};
if ( _si == siEast ) then
{
	mhqEast = _mhq;
};

if ( playerSideIndex == _si ) then
{
	mhq = _mhq;
};

if ( !isServer ) then
{
	_event = format["_nul = [_this, %1] execVM ""Common\EventMHQDestroyed.sqf""", _si];
	_mhq addEventHandler ["killed", _event];
};
