// args: [unit, seconds]
private["_unit", "_delay"];

_unit = _this select 0;
_delay = _this select 1;

if (!isNull _unit) then
{	
	pvGarbage = [_unit, _delay];
	if ( isServer ) then
	{
		[pvGarbage] spawn MsgGarbage;
	}
	else
	{
		publicVariable "pvGarbage";
	};
};