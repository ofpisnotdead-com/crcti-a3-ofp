// args: [unit, si]

_unit = _this select 0;
_si = _this select 1;
_mags = magsRespawnAI select _si;
_weapons = weaponsRespawnAI select _si;
_assignedItems = assignedItemsRespawnAI select _si;
_items = itemsRespawnAI select _si;

removeBackPack _unit;
_unit addBackPack (backPacksRespawnAI select _si);

removeAllWeapons _unit;
{	_unit unassignItem _x}forEach (assignedItems _unit);
removeAllItems _unit;

{
	_unit addMagazine _x;
}forEach _mags;

{
	_unit addWeapon _x;
}forEach _weapons;

{
	_unit addItem _x;
	_unit assignItem _x;
}forEach _assignedItems;

{
	_unit addItem _x;
}forEach _items;


_unit selectWeapon (_weapons select 0);
