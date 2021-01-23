// args: [unit, si]

_unit = _this Select 0;
_si = _this Select 1;

if ( _unit == leader group _unit ) then
{
	_mags = magsRespawnPlayer select _si;
	_weapons = weaponsRespawnPlayer select _si;
	_assignedItems = assignedItemsRespawnPlayer select _si;
	_items = itemsRespawnPlayer select _si;
	_backpack = (backPacksRespawnPlayer select _si);

	removeBackPack _unit;
	_unit addBackPack _backpack;

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
}
else
{
	_unit setVehicleAmmo 1;
};

// Set Radio Channel 1 to Side Frequency
if ( AcreAllowed ) then
{
	_freqs = pvAcreFreq select _si;
	{
		[_x, _freqs ] call acre_api_fnc_setDefaultChannels;
	}forEach AcreRadioClasses;
};