// args: [params]

_type = _this select 1;
_si = _this select 2;
_gi = _this select 3;
_giBuyer = _this select 4;

if (_si == playerSideIndex && (_gi == playerGroupIndex || _giBuyer == playerGroupIndex) ) then
{
	_unitName = (unitDefs select _type) select udName;
	[format ["Removed from Queue: %1", _unitName ], true, false, htQueueCancel, true] call funcHint;
};
