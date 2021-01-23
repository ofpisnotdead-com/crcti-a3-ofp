// arguments: object
// return: [ [wpn, ...], [mag, ...] ] 
private["_weapons", "_wmags", "_mags", "_class", "_items", "_pack"];

_class = typeOf _this;
_weapons = [];
_mags = [];
_items = [];
_pack = "";

if ( _class isKindOf "Man" ) then
{
	_weapons = getArray ( configFile >> "CfgVehicles" >> _class >> "weapons");
	_mags = getArray ( configFile >> "CfgVehicles" >> _class >> "magazines");
	_items = getArray ( configFile >> "CfgVehicles" >> _class >> "linkedItems");
	_pack = getText ( configFile >> "CfgVehicles" >> _class >> "backpack");
}
else
{
	_res = _class call funcGetVehicleWeapons;

	_weapons = _res select 0;
	_mags = _res select 1;
	_items = [];
	_pack = "";
};

[_weapons, _mags, _items, _pack]