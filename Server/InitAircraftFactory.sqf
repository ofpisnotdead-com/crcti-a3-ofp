_type = _this select 0;
_si = _this select 1;
_objects = _this select 2;
_object = _objects select 0;

_pos = getPos _object;

if ( THISISARMA3 && ((productVersion select 2) >= 154) && ((productVersion select 3) >= 132763) ) then
{
	_stuff = [_pos, [], 50 ] call funcNearestTerrainObjects;
	{
		[_x, true] call funcHideObjectGlobal;
	}forEach _stuff;

};