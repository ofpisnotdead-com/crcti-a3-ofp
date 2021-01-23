// args: [params]

_t = _this select 1;
_si = _this select 2;

_tstr = _t call funcSecondsToString;

if (playerSideIndex == _si) then
{
	[format["AI Commander in %1", _tstr], false, true, htCommanderTimeout, true] call funcHint;
};

