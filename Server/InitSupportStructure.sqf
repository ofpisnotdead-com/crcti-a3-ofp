_t = _this select 0;
_si = _this select 1;
_v = _this select 2;

{
	_x setRepairCargo 0;
	_x setAmmoCargo 0;
	_x setFuelCargo 1;
}forEach _v;