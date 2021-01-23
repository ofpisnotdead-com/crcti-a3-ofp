// args: [params]

_type = _this select 1;
_groupBuyer = _this select 2;
_groupJoin = _this select 3;
_si = _this select 4;

if (_si == playerSideIndex) then
{
	if ((_groupJoin != playerGroupIndex) && (_groupBuyer == playerGroupIndex)) then
	{
		_unitName = (unitDefs select _type) select udName;
		[format ["A %1 has arrived (which you ordered for another group).", _unitName ], false, true, htBuyUnit, true] call funcHint;
	}
	else
	{
		if (_groupJoin == playerGroupIndex) then
		{
			_unitName = (unitDefs select _type) select udName;
			_text = format ["Your %1 has arrived.", _unitName ];
			[_text, false, false, htBuyUnit, true] call funcHint;
		};
	};
};