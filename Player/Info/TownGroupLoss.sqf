// args: [params]
_ti = _this select 1;
_si = _this select 2;

if (_si == playerSideIndex)then
{
	[format["%1 is taking casualties", (towns select _ti) select tdName], false, true, htGeneral, false] call funcHint;
};
