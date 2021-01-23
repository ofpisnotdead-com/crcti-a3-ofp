// args: [_gi, _si]

_si = -1;
_gi = -1;

if ( count _this > 0 ) then
{
	_gi = _this select 0;
	_si = _this select 1;
}
else
{
	_si = playerSideIndex;
	_gi = playerGroupIndex;
};

if ( count ([_si, stComm] call funcGetWorkingStructures) == 0 ) then
{
	["No Comm Center", true, false, htGeneral, false] call funcHint;
}
else
{
	if ( !isNull player ) then
	{
		if ( time > lastSitrep + SitrepInterval ) then
		{
			pvSitrep = [_gi,_si];
			lastSitrep = time;
			_nul = [pvSitrep] spawn MsgSitrep;
			publicVariable "pvSitrep";
		}
		else
		{
			["Blocked by Sitrep Interval", true, false, htGeneral, false] call funcHint;
		};

	}
	else
	{
		pvSitrep = [_gi,_si];
		publicVariable "pvSitrep";
	};
};