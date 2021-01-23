// args: [params]

_type = _this select 1;
_groupBuyer = _this select 2;
_groupJoin = _this select 3;
_si = _this select 4;

if (_si == playerSideIndex) then
{
	if ((_groupBuyer == playerGroupIndex) && (_groupJoin == playerGroupIndex)) then
	{
		_unitName = (unitDefs select _type) select udName;
		[format ["Queued Unit: %1", _unitName ], false, true, htBuyUnit, true] call funcHint;
	};
};
