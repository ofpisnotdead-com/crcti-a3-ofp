// [_unit, _target]

private ["_unit", "_targets", "_best", "_knowsAbout"];

_unit = _this select 0;
_targets = _this select 1;
_best = objNull;
_knowsAbout = 0;

{	
	if ( !isNull _x && !isNull _unit && (_unit knowsAbout _x) >= attackKnowsAbout && (_unit knowsAbout _x) > _knowsAbout && alive _x) then
	{
		_knowsAbout = _unit knowsAbout _x;
		_best = _x;
	};
}forEach _targets;

_best

