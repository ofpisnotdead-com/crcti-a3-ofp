private ["_wmags", "_hit", "_muzzles", "_canLock", "_mmags", "_magclass", "_ammoname", "_ammo", "_curhit"];

_muzzles = getArray(configFile >> "cfgWeapons" >> _this >> "muzzles");
_wmags = getArray(configFile >> "cfgWeapons" >> _this >> "magazines");
_canLock = getNumber(configFIle >> "cfgWeapons" >> _this >> "canLock");

{
	_mmags = getArray(configFile >> "cfgWeapons" >> _this >> _x >> "magazines");

	{
		if ( !(_x in _wmags) ) then
		{
			_wmags = _wmags + [_x];
		};
	}forEach _mmags;
}forEach _muzzles;

_hit = 0;

{
	_magclass = (configFile >> "CfgMagazines" >> _x);
	_ammoname = getText(_magclass >> "ammo");
	_ammo = (configFile >> "cfgAmmo" >> _ammoname);
	_curhit = getNumber(_ammo >> "hit") + getNumber(_ammo>>"indirecthit")*(sqrt(1.0 + getNumber(_ammo >> "indirecthitrange")));

	if ( _curhit > _hit ) then
	{
		_hit = _curhit;
	};

}forEach _wmags;

//diag_log format["weap: %1 mags: %2 canlock: %3 hit: %4", str(_this), str(_wmags), str(_canlock), str(_hit)];

if ( _canLock > 1 ) then {_hit = _hit * 2.0;};

_hit
