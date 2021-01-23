// args: [params]

_type = _this select 1;
_si = _this select 2;
_gi = _this select 3;

if (_si == playerSideIndex && _gi == playerGroupIndex) then
{
	_unitName = (unitDefs select _type) select udName;
	[format ["Cannot remove from Queue: %1", _unitName ], true, false, htQueueCancel, true] call funcHint;
};
