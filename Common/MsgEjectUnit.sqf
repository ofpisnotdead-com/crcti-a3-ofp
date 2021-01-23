_unit = _this select 0;

if (local _unit && alive _unit) then
{
	if ( _unit != (vehicle _unit) ) then
	{
		_backpack = backpack _unit;
		_items = backpackitems _unit;

		if ( (vehicle _unit) isKindof "Air" && ((getPos _unit) select 2) > 30 ) then
		{
			removeBackPack _unit;
			_unit addBackpack "B_Parachute";

			//_unit action ["EJECT", vehicle _unit];
			_unit action ["GetOut", vehicle _unit]; // HUGH?!			
			unassignVehicle _unit;
			[_unit] orderGetIn false;
			[_unit] allowGetIn false;

			waitUntil {(backpack _unit == "") || ((getPos _unit) select 2) < 5 || !(alive _unit)};
			removeBackPack _unit;
			_unit addBackPack _backpack;
			{
				_unit addItemToBackPack _x;
			}forEach _items;
		}
		else
		{
			_unit action ["GetOut", vehicle _unit];
			unassignVehicle _unit;
			[_unit] orderGetIn false;
			[_unit] allowGetIn false;

		};
	}
	else
	{
		unassignVehicle _unit;
		[_unit] orderGetIn false;
		[_unit] allowGetIn false;
	};
};