// args: [object, type, si, gi]

_v = _this select 0;
_si = _this select 2;

_v setRepairCargo 0;
clearWeaponCargo _v;
clearMagazineCargo _v;

_nul = [_v] execVM "Server\UpdateRepairVehicle.sqf";