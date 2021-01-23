private ["_veh", "_weapons", "_mags", "_ts","_turrets","_gunners","_commanders","_turretcount", "_cargoturrets", "_pylonMags", "_pylonWep"];

_veh = (configFile >> "cfgVehicles" >> _this);
_weapons = getArray(_veh >> "weapons");
_mags = getArray(_veh >> "magazines");

_ts = [_veh, 0,[]] call funcGetTurrets;

_turrets = _ts select 0;
_gunners = _ts select 1;
_commanders = _ts select 2;
_cargoturrets = _ts select 3;

_turretcount = count _turrets;

_pylonMags = getArray(_veh >> "Components" >> "TransportPylonsComponent" >> "Presets" >> "Default" >> "attachment");

{
	if ( isClass _x ) then
	{
		_weapons = _weapons + getArray(_x >> "weapons");
		_mags = _mags + getArray(_x >> "magazines");
	};
}forEach _turrets;

{
	_mags = _mags + [_x];
	_pylonWep = getText(configFile >> "cfgMagazines" >> _x >> "pylonWeapon");
	if ( !(_pylonWep in _weapons)) then {_weapons = _weapons + [_pylonWep];};
}forEach _pylonMags;

[_weapons, _mags, _turretcount, _gunners, _commanders, _cargoturrets]
