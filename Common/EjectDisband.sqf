private ["_units", "_t"];

_units = _this;

{	
	[_x] call funcEjectUnit;
	
	_t = time + 60;
	waitUntil {vehicle _x == _x || time > _t};
	_x setDamage 1;
}forEach _units;
