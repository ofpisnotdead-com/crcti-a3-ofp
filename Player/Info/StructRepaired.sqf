// args: [params]

_percent = _this select 1;
_gi = _this select 2;
_type = _this select 3;
_si = _this select 4;

_structName = (structDefs select _type) select sdName;

if (playerSideIndex == _si && playerGroupIndex == _gi) then
{
	[format["Repairing %1%2\n%3", _percent, "%", _structName], false, true, htRepairStruct, true] call funcHint;
};
