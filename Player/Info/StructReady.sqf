// args: [params]

_type = _this select 1;
_si = _this select 2;

_structName = (structDefs select _type) select sdName;

if (playerSideIndex == _si ) then
{
	[format["%1 READY", _structName], false, true, htGeneral, false] call funcHint;
};