// args: [params]

_type = _this select 1;
_giBuyer = _this select 2;
_giJoin = _this select 3;
_si = _this select 4;

if (_si == playerSideIndex && _giBuyer == playerGroupIndex) then
{
	_nameGroup = (groupNameMatrix select _si) select _giJoin;
	_unitName = (unitDefs select _type) select udName;
	[format ["Group %1 Full (including units building/queued), Aborting build of %2", _nameGroup, _unitName ], true, false, htBuyUnitCancel, true] call funcHint;
};
