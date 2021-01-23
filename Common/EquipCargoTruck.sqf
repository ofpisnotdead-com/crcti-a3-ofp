// args: [vehicle, type, si]

_vehicle = _this select 0;
_type = _this select 1;
_si = _this select 2;

_cargo = [];
if ( _si == siWest ) then
{
	_cargo = cargoTruckWest;
};

if ( _si == siEast ) then
{
	_cargo = cargoTruckEast;
};

{
	_vehicle addMagazineCargo _x;
}forEach _cargo;

