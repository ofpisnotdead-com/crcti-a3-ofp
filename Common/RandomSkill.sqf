private ["_unit", "_skillspread", "_skill", "_skilltypes", "_skilldelta"];

_unit = _this;
_skillspread = 0.10;

_skilltypes = ["general","aimingShake","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding"];

{
	_skilldelta = (floor(random(_skillspread*200.0))-(_skillspread*100))/ 100.0;
	_skill = AiSkill + _skilldelta;

	if ( _skill > 1.0 ) then {_skill = 1.0;};
	if ( _skill < 0.2 ) then {_skill = 0.2;};

	_unit setSkill [_x,_skill];

}forEach _skilltypes;

_skilltypes = ["aimingAccuracy", "aimingSpeed"];

{
	_skilldelta = (floor(random(_skillspread*200.0))-(_skillspread*100))/ 100.0;
	_skill = AiAccuracy + _skilldelta;

	if ( _skill > 1.0 ) then {_skill = 1.0;};
	if ( _skill < 0.2 ) then {_skill = 0.2;};

	_unit setSkill [_x,_skill];

}forEach _skilltypes;

_skilltypes = ["general","aimingShake","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","aimingAccuracy", "aimingSpeed"];

/*{
	diag_log format["%1 %2", _x, _unit skill _x];
}forEach _skilltypes;*/