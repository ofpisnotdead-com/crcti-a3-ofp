// args: [params]

_type = _this select 1;
_groupBuyer = _this select 2;
_groupJoin = _this select 3;
_si = _this select 4;

if (_si == playerSideIndex && _groupBuyer == playerGroupIndex) then
{
	_unitName = (unitDefs select _type) select udName;
	[format ["Not enough money to build %1", _unitName ], true, false, htBuyUnitCancel, true] call funcHint;
};
