_type = _this select 1;
_objects = _this select 4;

_name = (structDefs select _type) select sdName;

_str = format["Remove %1", _name];

{	
	_cond = "(playerGroup == (groupCommander select playerSideIndex) || (_target getVariable [""SQU_SI_GI"", [-1,-1,-1]] select 1) == playerGroupIndex) && (vehicle _this != _target)";
	_nul = _x addAction [_str, "Player\ActionDeleteVehicle.sqf", _objects, 2, false, false, "", _cond];
}forEach _objects;
