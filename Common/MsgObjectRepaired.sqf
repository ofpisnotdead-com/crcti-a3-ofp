_value = _this select 0;

_obj = _value select 0;
_percent = _value select 1;
_gi = _value select 2;
_si = _value select 3;

if ( _percent >= 100 ) then {_obj setDamage 0;};

if ( (_si == playerSideIndex) && (_gi == playerGroupIndex) ) then
{
	[format["Object repaired.\n%1%2", _percent, "%"], false, false, htGeneral,false] call funcHint;
};

