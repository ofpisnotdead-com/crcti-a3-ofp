// args: [params]

_type = _this select 1;
_si = _this select 2;

_structName = (structDefs select _type) select sdName;

if (playerSideIndex == _si ) then
{
	_info = format["%1 DESTROYED", _structName];
	titleText [_info, "PLAIN DOWN", 2];
};