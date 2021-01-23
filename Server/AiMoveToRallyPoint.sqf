// args: [unit, si, gi]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;

_pos = (wpCO select _si) select ((((aiSetting select _si) select _gi) select aisRallyPoint)-1);

if (_pos select 0 != -1 ) then
{
	if( alive _unit && _unit == (driver vehicle _unit) ) then
	{
		[_unit, _pos] call funcMoveAI;
	};
};