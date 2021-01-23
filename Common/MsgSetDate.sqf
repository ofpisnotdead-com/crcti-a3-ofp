private ["_pvDate", "_maxDrift"];

_pvDate = _this select 0;
_maxDrift = 2;

if ( (_pvDate select 0 != date select 0) ||
		(_pvDate select 1 != date select 1) ||
		(_pvDate select 2 != date select 2) ||
		(_pvDate select 3 != date select 3) ||
		(abs((_pvDate select 4) - (date select 4)) > _maxDrift) ) then
{
	setDate _pvDate;
};

