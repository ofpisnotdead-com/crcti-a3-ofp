// args: [unit, pos]

_unit = _this select 0;
_pos = _this select 1;

if ( alive _unit && alive driver vehicle _unit) then
{
	_posMove = [_pos, 5, 20, true, _unit] call funcGetRandomPos;
	[_unit, _posMove] call funcMove;
};
