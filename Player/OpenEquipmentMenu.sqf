// args: [object, costfactor]
//_object = (_this select 3) select 0;
//_costFactor = (_this select 3) select 1;
_object = _this select 0;
_costFactor = _this select 1;
_unit = player;
_tradeInFactor = tradeInFactor;

_fRemoveCurrentSingle = {
private ["_curIdx"];

	_curIdx = lbCurSel IDC_LB_CURRENT;
	if ( _curIdx != -1 && _curIdx < count(_currentList)) then
	{
		_curEntry = _currentList select _curIdx;
		_class = _curEntry select 0;
		if ( _class != "" ) then {[_class] call _fRemoveCurrent;};
	};
};

_fRemoveCurrentAll = {
private ["_curIdx"];

	_curIdx = lbCurSel IDC_LB_CURRENT;
	if ( _curIdx != -1 && _curIdx < count(_currentList)) then
	{
		_curEntry = _currentList select _curIdx;
		_class = _curEntry select 0;
		if ( _class != "" ) then
		{
			_amount = _curEntry select 1;
			for "_i" from 1 to _amount do {[_class] call _fRemoveCurrent;};
		};
	};
};

_fRemoveCurrent = {
private ["_class"];
	_class = _this select 0;

	if ( _class in _currentMags ) then {[_class] call _fRemoveMagazine;};
	if ( _class in _currentWeapons ) then {[_class] call _fRemoveWeapon;};
	if ( _class in _currentItems ) then {[_class] call _fRemoveItem;};
	if (_class == _currentVest || _class == _currentBackpack || _class == _currentUniform || _class == _currentHeadgear || _class == _currentGoggles) then {[_class] call _fRemoveClothes;};
};

_fRemoveWeapon = {
private ["_class", "_items"];

	_class = _this select 0;

	_items = [];
	if ( _class == primaryWeapon player ) then {_items = primaryWeaponItems player;};
	if ( _class == secondaryWeapon player ) then {_items = secondaryWeaponItems player;};
	if ( _class == handgunWeapon player ) then {_items = handgunItems player;};

	player removeWeapon _class;

	{
		[_x] call _fAssignItem;
	}forEach _items;

};

_fAddWeapon = {
private["_class"];
	_class = _this select 0;

	player addWeapon _class;
	player selectWeapon(primaryWeapon player);
};

_fChangeWeapon = {
private["_type", "_cur", "_newClass", "_items"];
	_type = _this select 0;
	_items = [];

	if ( _type != -1 ) then
	{
		_cur = _this select 1;
		_newClass = (weaponDefs select _type) select wdObject;

		if ( _cur != -1 ) then
		{
			_curClass = (weaponDefs select _cur) select wdObject;
			_cur call _funcRemoveDefaultAmmo;

			if ( _curClass == [primaryWeapon player] call _fGetWeaponBase ) then {_items = primaryWeaponItems player;};
			if ( _curClass == [secondaryWeapon player] call _fGetWeaponBase ) then {_items = secondaryWeaponItems player;};
			if ( _curClass == [handgunWeapon player] call _fGetWeaponBase ) then {_items = handgunItems player;};

			player removeWeapon _curClass;
		};

		_type call _funcAddDefaultAmmo;
		[_newClass] call _fAddWeapon;

		{
			[_x] call _fAssignItem;
		}forEach _items;

		reload player;
	};

	_type
};

_fRemoveMagazine = {
private ["_class"];
	_class = _this select 0;
	player removeMagazine _class;
};

_fAddMagazine = {
private ["_type", "_class"];
	_type = _this select 0;

	if ( _type != -1 ) then
	{
		_class = (equipDefs select _type) select edObject;
		if ( player canAdd _class ) then
		{
			player addMagazine _class;
		};
	};

};

_fAssignItem = {
private ["_item"];
	_item = _this select 0;

	if ( _item != "" ) then
	{
		_remains = [];

		_oldprims = primaryWeaponItems player;
		_oldsecs = secondaryWeaponItems player;
		_oldhg = handgunItems player;
		player addPrimaryWeaponItem _item;

		if ( ! (_item in primaryWeaponItems player)) then
		{
			player addSecondaryWeaponItem _item;
			if ( ! (_item in secondaryWeaponItems player)) then
			{
				player addHandgunItem _item;
				if ( ! (_item in handgunItems player)) then
				{
					player addItem _item;
					if ( _item in (assignedItems player)) then {player assignItem _item;};
				};
			};
		};

		_remains = _remains + (_oldprims - primaryWeaponItems player);
		_remains = _remains + (_oldsecs - secondaryWeaponItems player);
		_remains = _remains + (_oldhg - handgunItems player);

		{
			player addItem _x;
			if ( _x in (assignedItems player)) then {player assignItem _x;};
		}forEach _remains;
	};
};

_fAddItem = {
private ["_type"];
	_type = _this select 0;

	if ( _type != -1 ) then
	{
		_item = ((equipDefs select _type) select edObject);
		if ( isClass(configFile >> "cfgWeapons" >> _item)) then
		{
			[_item] call _fAssignItem;
		}
		else
		{
			player addItem _item;
		};
	};
};

_fRemoveItem = {
private["_class"];
	_class = _this select 0;

	if ( _class in (assignedItems player)) then {player unassignItem _class};
	if ( _class in (primaryWeaponItems player)) then {player removePrimaryWeaponItem _class};
	//if ( _class in (secondaryWeaponItems player)) then { player removeSecondaryWeaponItem _class;};
	if ( _class in (handgunItems player)) then {player removeHandgunItem _class};

	if ( _class in weapons player ) then
	{
		player removeWeapon _class;
	}
	else
	{
		player removeItem _class;
	};
};

_fRemoveClothes = {
private ["_class", "_classtype"];
	_class = _this select 0;

	_items = [];
	_classtype = -1;
	if ( isClass (configFile >> "cfgVehicles" >> _class) ) then
	{
		_classType = -2;
	}
	else
	{
		if ( isClass (configFile >> "cfgGlasses" >> _class) ) then
		{
			_classType = -3;
		}
		else
		{
			_classtype = getNumber(configFile >> "cfgWeapons" >> _class >> "ItemInfo" >> "type");
		};
	};

	switch (_classtype) do
	{
		case -2:
		{
			_items = backpackItems player;
			removeBackPack player;
		};
		case -3:
		{
			removeGoggles player;
		};
		case 701:
		{
			_items = vestItems player;
			removeVest player;
		};
		case 801:
		{
			_items = uniformItems player;
			removeUniform player;
		};
		case 605:
		{
			removeHeadgear player;
		};
	};
};

_fAddClothes = {
private["_type", "_class", "_classtype", "_items"];
	_type = _this select 0;
	if ( _type != -1 ) then
	{
		_class = ((clothesDefs select _type) select cdObject);

		_items = [];
		_classtype = -1;
		if ( isClass (configFile >> "cfgVehicles" >> _class) ) then
		{
			_classType = -2;
		}
		else
		{
			if ( isClass (configFile >> "cfgGlasses" >> _class) ) then
			{
				_classType = -3;
			}
			else
			{
				_classtype = getNumber(configFile >> "cfgWeapons" >> _class >> "ItemInfo" >> "type");
			};
		};

		switch (_classtype) do
		{
			case -2:
			{
				_items = backpackItems player;
				removeBackPack player;
				player addBackPack _class;
			};
			case -3:
			{
				removeGoggles player;
				player addGoggles _class;
			};
			case 701:
			{
				_items = vestItems player;
				removeVest player;
				player addVest _class;
			};
			case 801:
			{
				_items = uniformItems player;
				removeUniform player;
				player addUniform _class;
			};
			case 605:
			{
				removeHeadgear player;
				player addHeadgear _class;
			};
			default
			{
				player addItem _class;
			};
		};

		{
			player addItem _x;
		}forEach _items;

	};
};

_fPrimChange = {
	_PrimDescription = getText (configFile >> "CfgWeapons" >> ((weaponDefs select _typePrim)select wdObject) >> "Library" >> "libTextDesc");
	ctrlSetText [IDC_EquiInfo, _PrimDescription];

	_ammoList = (weaponDefs select _typePrim) select wdAmmoTypes;
	lbClear IDC_LB_PRIM_AMMO;
	lbSetCurSel [IDC_LB_PRIM_AMMO, -1];

	{
		_desc=equipDefs select (_x select 0);
		_text=format["$%1 %2", [_costFactor*(_desc select edCost), 4] call funcPadNumber, _desc select edName];
		_id = lbAdd [IDC_LB_PRIM_AMMO, _text];
		lbSetValue [IDC_LB_PRIM_AMMO, _id, (_x select 0)];
	}foreach _ammoList;
};

_fSecChange = {
	_PrimDescription = "";
	if(((weaponDefs select _typeSec)select wdObject) == "Laserdesignator") then
	{
		_PrimDescription = getText (configFile >> "CfgWeapons" >> ((weaponDefs select _typeSec)select wdObject) >> "descriptionShort");
	}
	else
	{
		_PrimDescription = getText (configFile >> "CfgWeapons" >> ((weaponDefs select _typeSec)select wdObject) >> "Library" >> "libTextDesc");
	};

	ctrlSetText [IDC_EquiInfo, _PrimDescription];
	_ammoList = (weaponDefs select _typeSec) select wdAmmoTypes;
	lbClear IDC_LB_SEC_AMMO;

	lbSetCurSel [IDC_LB_SEC_AMMO, -1];
	{
		_desc=equipDefs select (_x select 0);
		_text=format["$%1 %2", [_costFactor*(_desc select edCost), 4] call funcPadNumber, _desc select edName];
		_id = lbAdd [IDC_LB_SEC_AMMO, _text];
		lbSetValue [IDC_LB_SEC_AMMO, _id, (_x select 0)]
	}foreach _ammoList;
};

_fHandgunChange = {
	_PrimDescription = getText (configFile >> "CfgWeapons" >> ((weaponDefs select _typeHandgun)select wdObject) >> "Library" >> "libTextDesc");
	ctrlSetText [IDC_EquiInfo, _PrimDescription];
	_ammoList = (weaponDefs select _typeHandgun) select wdAmmoTypes;
	lbClear IDC_LB_HG_AMMO;

	lbSetCurSel [IDC_LB_HG_AMMO, -1];
	{
		_desc=equipDefs select (_x select 0);
		_text=format["$%1 %2", [_costFactor*(_desc select edCost), 4] call funcPadNumber, _desc select edName];
		_id = lbAdd [IDC_LB_HG_AMMO, _text];
		lbSetValue [IDC_LB_HG_AMMO, _id, (_x select 0)];
	}foreach _ammoList;
};

_fAmmoChange = {
private ["_typeAmmo"];
	_typeAmmo = _this select 0;
	_AmmoName = getText (configFile >> "CfgMagazines" >> ((equipDefs select _typeAmmo)select edObject)>> "ammo" );
	_Ammohit = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "Hit" );
	_AmmoindirectHit = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "indirectHit" );
	_AmmoindirectHitRange = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "indirectHitRange" );
	_AmmovisibleFire = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "visibleFire" );
	_AmmoaudibleFire = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "audibleFire" );
	_text = format["Ammo Name = %1\nHit Damage = %2\nSplash Damage = %3\nSplash Range = %4\nHow Visible when Fired = %5\nHow Loud when Fired = %6",_AmmoName,_Ammohit,_AmmoindirectHit,_AmmoindirectHitRange,_AmmovisibleFire ,_AmmoaudibleFire];
	ctrlSetText [IDC_EquiInfo, _text];
};

_fEquipmentClick = {
	_text = "No Description";
	if ( !(isClass (configFile >> "CfgMagazines" >> ((equipDefs select _typeEquipment)select edObject)))) then
	{
		_text = getText (configFile >> "CfgWeapons" >> ((equipDefs select _typeEquipment)select edObject) >> "Library" >> "libTextDesc");
	}
	else
	{
		_AmmoName = getText (configFile >> "CfgMagazines" >> ((equipDefs select _typeEquipment)select edObject)>> "ammo" );
		_Ammohit = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "Hit" );
		_AmmoindirectHit = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "indirectHit" );
		_AmmoindirectHitRange = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "indirectHitRange" );
		_AmmovisibleFire = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "visibleFire" );
		_AmmoaudibleFire = getNumber (configFile >> "CfgAmmo" >> _AmmoName >> "audibleFire" );
		_text = format["Ammo Name = %1\nHit Damage = %2\nSplash Damage = %3\nSplash Range = %4\nHow Visible when Fired = %5\nHow Loud when Fired = %6",_AmmoName,_Ammohit,_AmmoindirectHit,_AmmoindirectHitRange,_AmmovisibleFire ,_AmmoaudibleFire];
	};
	ctrlSetText [IDC_EquiInfo, _text];
};

_fClothesChange = {
	_Description = "No Description";
	if ( isClass(configFile >> "CfgVehicles" >> ((clothesDefs select _typeClothes)select cdObject))) then
	{
		_Description = getText (configFile >> "CfgVehicles" >> ((clothesDefs select _typeClothes)select cdObject) >> "displayName");
	}
	else
	{
		_name = getText (configFile >> "CfgWeapons" >> ((clothesDefs select _typeClothes)select cdObject) >> "displayName");
		_desc = getText (configFile >> "CfgWeapons" >> ((clothesDefs select _typeClothes)select cdObject) >> "descriptionShort");
		_Description = format["%1\n%2", _name, _desc];
	};
	ctrlSetText [IDC_EquiInfo, _Description];
};

_funcAddDefaultAmmo = {
	{
		_typeAmmo = _x select 0;
		_amount = _x select 1;
		for "_i" from 1 to _amount do {[_typeAmmo] call _fAddMagazine;};
	}forEach ((weaponDefs select _this) select wdAmmoTypes);
};

_funcRemoveDefaultAmmo = {
	{
		_typeAmmo = _x select 0;
		_classAmmo = (equipDefs select _typeAmmo) select edObject;
		_mags = (magazines player) + [currentMagazine player];

		{
			if (_x == _classAmmo ) then {[_classAmmo] call _fRemoveMagazine;};
		}forEach _mags;
	}forEach ((weaponDefs select _this) select wdAmmoTypes);
};

_fGetWeaponBase = {
private ["_class", "_baseClass", "_entry", "_res"];

	_class = _this select 0;
	_res = _class;

	_entry = configFile >> "CfgWeapons" >> _class;
	_baseClass = configName(inheritsFrom _entry);

	if ( isClass (_entry >> "LinkedItems") ) then
	{
		_res = _baseClass;
	};

	if ( (_baseClass in AcreRadioClasses) && (_class != _baseClass) ) then
	{
		_res = _baseClass;
	};

	_res
};

_fCheckInListArray = {
private["_array", "_res", "_check"];
	_array = _this select 0;
	_res = [];
	{
		_res = _res + [[_x] call _fCheckInList];
	}forEach _array;

	_res
};

_fCheckInList = {
private["_class", "_res", "_object", "_sides", "_base"];
	_class = _this select 0;
	_res = "";

	{
		_object = _x select wdObject;
		_sides = _x select wdSides;
		if ( _object == _class && _sides != _notAllowed ) exitWith {_res = _class};
	}forEach weaponDefs;

	if ( _res == "") then
	{
		{
			_object = _x select edObject;
			_sides = _x select edSides;
			if ( _object == _class && _sides != _notAllowed ) exitWith {_res = _class};
		}forEach equipDefs;
	};

	if ( _res == "" ) then
	{
		{
			_object = _x select cdObject;
			_sides = _x select cdSides;
			if ( _object == _class && _sides != _notAllowed) exitWith {_res = _class};
		}forEach clothesDefs;
	};
	if ( _res == "" ) then
	{
		_base = [_class] call _fgetWeaponBase;
		if ( _base != _class ) then
		{
			_res = [_base] call _fCheckInList;
		};
	};

	_res
};

_fGetPrice = {
private["_class", "_price", "_object", "_cost"];

	_price = -1;
	_class = _this select 0;

	{
		_object = _x select wdObject;
		_cost = _x select wdCost;
		if ( _object == _class ) exitWith {_price = _cost;};
	}forEach weaponDefs;

	if ( _price == -1 ) then
	{
		{
			_object = _x select edObject;
			_cost = _x select edCost;
			if ( _object == _class ) exitWith {_price = _cost;};
		}forEach equipDefs;
	};

	if ( _price == -1 ) then
	{
		{
			_object = _x select cdObject;
			_cost = _x select cdCost;
			if ( _object == _class ) exitWith {_price = _cost;};
		}forEach clothesDefs;
	};

	if ( _price == -1 ) then {_price = 0;};

	_price
};

_fBuildList = {
private ["_list", "_res", "_entry", "_found"];
	_res = [];
	_list = _this select 0;

	{
		if ( _x != "" ) then
		{
			_entry = _x;
			_found = false;
			{
				if (_entry == (_x select 0)) exitWith
				{
					_x set[1, (_x select 1)+1];
					_found = true;
				};
			}forEach _res;

			if ( !_found ) then
			{
				_res = _res + [[_x, 1, str(_x) call funcStringHash]];
			};
		};
	}forEach _list;

	_res = [2, true, _res] call funcSortStrings;

	_res
};

_fCurrent = {
// Current Equipment	
	_currentWeapons = (weapons player) - (assignedItems player) - (items player);
	_currentWeaponsBase = + _currentWeapons;
	_currentMags = magazines player;
	_currentItems = (items player) + (assignedItems player);
	_currentBackPack = backpack player;
	_currentVest = vest player;
	_currentUniform = uniform player;
	_currentHeadgear = headgear player;
	_currentGoggles = goggles player;

	{
		_currentWeaponsBase set [_forEachIndex, [_x] call _fGetWeaponBase];
	}forEach _currentWeaponsBase;

	{
		{
			if ( _forEachIndex > 0 ) then
			{
				if ( typeName _x == "STRING" ) then {_currentItems = _currentItems + [_x];};
				if ( typeName _x == "ARRAY" && {count(_x)>0}) then {_currentMags = _currentMags + [_x select 0];};
			};
		}forEach _x;
	}forEach (weaponsItems _unit);

	_currentWeapons = _currentWeapons - [""];
	_currentMags = _currentMags - [""];
	_currentItems = _currentItems - [""];

	_currentList = [];

	lbClear IDC_LB_CURRENT;
	{

		if ( (count(_x select 0)) > 0 ) then
		{
			if ( (_x select 0) select 0 != "" ) then
			{
				_id = lbAdd [IDC_LB_CURRENT, ""];
				_id = lbAdd [IDC_LB_CURRENT, _x select 1];
				lbSetColor[IDC_LB_CURRENT, _id, [1,1,1,1]];
				_id = lbAdd [IDC_LB_CURRENT, ""];

				_list = [_x select 0] call _fBuildList;
				_currentList = _currentList + [["",0]] + _list;

				{
					_class = [_x select 0] call _fGetWeaponBase;
					_amount = _x select 1;
					_pic = "";
					_name = "";

					{
						if (isClass(configFile >> _x >> _class) ) exitWith
						{
							_pic = getText(configFile >> _x >> _class >> "picture");
							_name = getText(configFile >> _x >> _class >> "displayname");
						};
					}forEach ["cfgWeapons", "cfgMagazines", "cfgVehicles", "cfgGlasses"];

					_id = lbAdd [IDC_LB_CURRENT, ""];
					lbSetPicture [IDC_LB_CURRENT, _id, _pic];
					_id = lbAdd [IDC_LB_CURRENT, _name];
					_id = lbAdd [IDC_LB_CURRENT, str(_amount)];

				}forEach _list;
			};
		};
	}forEach [[_currentWeapons, "Weapons"],
	[_currentMags, "Magazines"],
	[_currentItems, "Items"],
	[[_currentBackPack], "Backpack"],
	[[_currentVest], "Vest"],
	[[_currentUniform], "Uniform"],
	[[_currentHeadgear],"Headgear"],
	[[_currentGoggles], "Goggles"]];

	if ( _init ) then
	{
		_currentListOld = + _currentList;
		_init = false;
	};

	_add = _currentList - _currentListOld;
	_sub = _currentListOld - _currentList;

	{
		_class = _x select 0;
		_amount = _x select 1;
		_transactionCost = _transactionCost + ([[_class] call _fGetWeaponBase]call _fGetPrice) * _amount;
	}forEach _add;
	{
		_class = _x select 0;
		_amount = _x select 1;
		_transactionCost = _transactionCost - ([[_class] call _fGetWeaponBase]call _fGetPrice) * _amount;
	}forEach _sub;

	_currentListOld = + _currentList;

};

_fPopulate = {
// Populate Lists

	lbClear IDC_LB_PRIM;
	lbClear IDC_LB_SEC;
	lbClear IDC_LB_HG;
	lbClear IDC_LB_EQ;
	lbClear IDC_LB_CLOTHES;
	{
		_desc = _x;

		if (_notAllowed != _desc select wdSides) then
		{
			_type = _desc select wdType;
			if (_type == wtPrimary || _type == wtPrimaryOnly) then
			{
				_text = format["$%1 %2", [_costFactor*(_desc select wdCost), 4] call funcPadNumber, _desc select wdName];
				_id = lbAdd [IDC_LB_PRIM, _text];
				lbSetValue [IDC_LB_PRIM, _id, _forEachIndex];
			};

			if (_type == wtHandgun) then
			{
				_text = format["$%1 %2", [_costFactor*(_desc select wdCost), 4] call funcPadNumber, _desc select wdName];
				_id = lbAdd [IDC_LB_HG, _text];
				lbSetValue [IDC_LB_HG, _id, _forEachIndex];
			};

			if (_type == wtSecondary) then
			{
				_text = format["$%1 %2", [_costFactor*(_desc select wdCost), 4] call funcPadNumber, _desc select wdName];
				_id = lbAdd [IDC_LB_SEC, _text];
				lbSetValue [IDC_LB_SEC, _id, _forEachIndex];
			};
		};

		if ((_x select wdObject) in _currentWeaponsBase) then
		{
			_wdType = _x select wdType;
			if ( _wdType == wtPrimary || _wdType == wtPrimaryOnly ) then
			{
				_typePrim = _forEachIndex;
				_primLast = _forEachIndex;
				_curPrim = _forEachIndex;
				lbSetCurSel[IDC_LB_PRIM,_forEachIndex];
			};
			if ( _wdType == wtSecondary ) then
			{
				_typeSec = _forEachIndex;
				_secLast = _forEachIndex;
				_curSec = _forEachIndex;
				lbSetCurSel[IDC_LB_SEC,_forEachIndex];
			};
			if ( _wdType == wtHandgun ) then
			{
				_typeHandgun = _forEachIndex;
				_handgunLast = _forEachIndex;
				_curHandgun = _forEachIndex;
				lbSetCurSel[IDC_LB_HG,_forEachIndex];
			};
		};
	}foreach weaponDefs;

	{
		if ( _forEachIndex >= firstEquip ) then
		{
			_desc = _x;
			_automag = false;

			if ( count _desc > 6 ) then
			{
				if ( _desc select 6 == "automag" ) then {_automag = true;};
			};

			if (_notAllowed != _desc select edSides && !_automag ) then
			{
				_text = format["$%1 %2", [_costFactor*(_desc select edCost), 4] call funcPadNumber, _desc select edName];
				_id = lbAdd [IDC_LB_EQ, _text];
				lbSetValue [IDC_LB_EQ, _id, _forEachIndex];
			};
		};
	}forEach equipDefs;

	{
		_desc = _x;
		_clothesClass = _x select cdObject;
		if (_notAllowed != (_desc select cdSides)) then
		{
			_text = format["$%1 %2", [_costFactor*(_desc select cdCost), 4] call funcPadNumber, _desc select cdName];
			_id = lbAdd [IDC_LB_CLOTHES, _text];
			lbSetValue [IDC_LB_CLOTHES, _id, _forEachIndex];
		};
	}forEach clothesDefs;
};

_fClear = {
	removeAllPrimaryWeaponItems player;
	removeAllHandgunItems player;
	removeAllWeapons player;

	{	player unassignItem _x}forEach (assignedItems player);
	removeAllItems player;

	removeBackPack player;
	removeVest player;
	removeHeadgear player;
	removeUniform player;
	removeGoggles player;
};

_fDefault = {
	call _fClear;

	player addUniform (defaultUniform select playerSideIndex);
	player addVest (defaultVest select playerSideIndex);
	player addBackPack (defaultBackPack select playerSideIndex);
	player addHeadgear (defaultHeadgear select playerSideIndex);
	player addGoggles (defaultGoggles select playerSideIndex);

	{
		player addItem _x;
		player assignItem _x;
	}forEach (defaultAssignedItems select playerSideIndex);

	{
		player addItem _x;
	}forEach (defaultItems select playerSideIndex);

	{
		player addWeapon _x;
	}forEach (defaultWeapons select playerSideIndex);

};

_fPopulateTemplates = {
	lbClear IDC_LB_TEMPLATES;
	{
		lbAdd [IDC_LB_TEMPLATES, _x select 0];
	}foreach eqTemplates;
};

// Load templates from profile
_fLoadProfile = {

	if ( profileAvailable ) then
	{
		savedTemplates = profileNameSpace getVariable "savedTemplatesA3";

		if ( !isNil "savedTemplates" ) then
		{
			{
				_savedWeapons = _x select 0;
				_savedEquipment = _x select 1;
				_savedClothes = _x select 2;
				if ( str(_savedEquipment) == str(equipDefs) && str(_savedWeapons) == str(weaponDefs) && str(_savedClothes) == str(clothesDefs) ) exitWith
				{
					savedIndex = _forEachIndex;
				};
			}forEach savedTemplates;
		}
		else
		{
			savedTemplates = [];
		};
	};

	if ( savedIndex == -1 ) then
	{
		call compile format["if ( !isNil ""eqTemplates_%1_%2"" ) then { eqTemplates = + eqTemplates_%1_%2; };", playerSideIndex,_uid];
	}
	else
	{
		eqTemplates = + (((savedTemplates select savedIndex) select 3) select playerSideIndex);

		if ( count(eqTemplates) != count(defaultEqTemplates)) then
		{
			eqTemplates = + defaultEqTemplates;
		};
	};

};

_fLoadTemplate = {
private ["_id"];
	_id = lbCurSel IDC_LB_TEMPLATES;
	if (_id == -1) then
	{
		["No Template Selected", true, false, htGeneral, false] call funcHint;
	}
	else
	{
		if (count(eqTemplates select _id) != 13 || ((eqTemplates select _id) select 0) == "Empty") then
		{
			["Template Not Defined", true, false, htGeneral, false] call funcHint;
		}
		else
		{
			call _fClear;

			_template = eqTemplates select _id;

			player addGoggles (_template select 12);
			player addHeadgear (_template select 11);
			player addUniform (_template select 10);
			player addVest (_template select 9);
			player addBackpack (_template select 8);

			{	if ( _x != "" ) then {player addMagazine _x;};}forEach ((_template select 3) select 2);
			player addWeapon ((_template select 3) select 0);
			{	if ( _x != "" ) then {player addHandgunItem _x;};}forEach ((_template select 3) select 1);

			{	if ( _x != "" ) then {player addMagazine _x;};}forEach ((_template select 2) select 2);
			player addWeapon ((_template select 2) select 0);
			{	if ( _x != "" ) then {player addSecondaryWeaponItem _x;};}forEach ((_template select 2) select 1);

			{	if ( _x != "" ) then {player addMagazine _x;};}forEach ((_template select 1) select 2);
			player addWeapon ((_template select 1) select 0);
			{	if ( _x != "" ) then {player addPrimaryWeaponItem _x;};}forEach ((_template select 1) select 1);

			{
				player addWeapon _x;
			}forEach (_template select 4);

			{
				player addMagazine _x;
			}forEach (_template select 5);

			{
				player addItem _x;
				player assignItem _x;
			}forEach (_template select 7);

			{
				player addItem _x;
			}forEach (_template select 6);

			player selectWeapon (primaryWeapon player);

			call _fCurrent;
			call _fPopulate;
		};
	}
};

_fSaveTemplate = {
private ["_id"];

	_id = lbCurSel IDC_LB_TEMPLATES;
	if (_id == -1) then
	{
		["No Template Slot Selected", true, false, htGeneral, false] call funcHint;
	}
	else
	{
		_primaryWeapon = [primaryWeapon player] call _fCheckInList;
		_primaryItems = [primaryWeaponItems player] call _fCheckInListArray;
		_primaryMag = [primaryWeaponMagazine player] call _fCheckInListArray;

		_secondaryWeapon = [secondaryWeapon player] call _fCheckInList;
		_secondaryItems = [secondaryWeaponItems player] call _fCheckInListArray;
		_secondaryMag = [secondaryWeaponMagazine player] call _fCheckInListArray;

		_handgunWeapon = [handgunWeapon player] call _fCheckInList;
		_handgunItems = [handgunItems player] call _fCheckInListArray;
		_handgunMag = [handgunMagazine player] call _fCheckInListArray;

		_additionalWeapons = [(weapons player) - [_primaryWeapon, _secondaryWeapon, _handgunWeapon]] call _fCheckInListArray;

		_namePrim = "None";
		if ( isClass(configFile >> "cfgWeapons" >> _primaryWeapon)) then {_namePrim = getText(configFile >> "cfgWeapons" >> _primaryWeapon >> "displayName");};
		_nameSec = "None";
		if ( isClass(configFile >> "cfgWeapons" >> _secondaryWeapon)) then {_nameSec = getText(configFile >> "cfgWeapons" >> _secondaryWeapon >> "displayName");};
		_name = format ["%1 %2", _namePrim, _nameSec];

		_primArray = [_primaryWeapon, _primaryItems, _primaryMag];
		_secArray = [_secondaryWeapon, _secondaryItems, _secondaryMag];
		_hgArray = [_handgunWeapon, _handgunItems, _handgunMag];

		(eqTemplates select _id) set[0, _name];
		(eqTemplates select _id) set[1, _primArray];
		(eqTemplates select _id) set[2, _secArray];
		(eqTemplates select _id) set[3, _hgArray];
		(eqTemplates select _id) set[4, _additionalWeapons];
		(eqTemplates select _id) set[5, [magazines player] call _fCheckInListArray];
		(eqTemplates select _id) set[6, [(items player) - _additionalWeapons] call _fCheckInListArray];
		(eqTemplates select _id) set[7, [(assignedItems player) - _additionalWeapons] call _fCheckInListArray];
		(eqTemplates select _id) set[8, [backpack player] call _fCheckInList];
		(eqTemplates select _id) set[9, [vest player] call _fCheckInList];
		(eqTemplates select _id) set[10, [uniform player] call _fCheckInList];
		(eqTemplates select _id) set[11, [headgear player] call _fCheckInList];
		(eqTemplates select _id) set[12, [goggles player] call _fCheckInList];

		call compile format["eqTemplates_%1_%2 = + eqTemplates;", playerSideIndex,_uid];
		call compile format["publicVariable ""eqTemplates_%1_%2"";", playerSideIndex,_uid];

		if ( profileAvailable ) then
		{
			if ( savedIndex == -1 ) then
			{
				if ( count(savedTemplates) > 10 ) then
				{
					savedTemplates set [0,0];
					savedTemplates = savedTemplates - [0];
				};

				savedIndex = count savedTemplates;
				_empty = + defaultEqTemplates;
				savedTemplates set [savedIndex,[weaponDefs,equipDefs,clothesDefs,[_empty,_empty]]];
			};

			((savedTemplates select savedIndex) select 3) set [playerSideIndex,eqTemplates];

			profileNameSpace setVariable ["savedTemplatesA3", savedTemplates];
			saveProfileNameSpace;
		};

		call _fPopulateTemplates;
	};
};

_fOpenDialog = {
	CreateDialog "EquipmentMenu";
	_escapeHandler = (findDisplay IDD_EquipmentMenu) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { btnExit = true; true }"];
	[IDD_EquipmentMenu]call funcFixDialogTitleColor;

	ctrlSetText [IDC_EQUIP_TYPELABEL, "Primary Weapons"];
	(_ctrlSec+_ctrlHg+_ctrlEquip+_ctrlClothes) call _fHide;
	_ctrlPrimary call _fShow;

	call _fCurrent;
	call _fPopulate;
	call _fPopulateTemplates;
};

_fCloseDialog = {
	(findDisplay IDD_EquipmentMenu) displayRemoveEventHandler ["KeyDown", _escapeHandler];
	closeDialog IDD_EquipmentMenu;
};

_fHide = {
	{
		ctrlShow [_x, false];
	}forEach _this;
};

_fShow = {
	{
		ctrlShow [_x, true];
	}forEach _this;
};

// Init Menu
disableSerialization;

_escapeHandler = -1;
_uid = getPlayerUID player;

_notAllowed = siEast;
if (playerSideIndex == siEast) then {_notAllowed = siWest;};

_transactionCost = 0;
_costBuy = 0;
savedIndex = -1;

_init = true;
_currentList = [];
_currentListOld = [];
_currentWeapons = [];
_currentWeaponsBase = [];
_currentMags = [];
_currentItems = [];
_currentBackPack = "";
_currentVest = "";
_currentUniform = "";
_currentHeadgear = "";
_currentGoggles = "";

_worth = 0;

_typePrim = -1;
_typeHandgun = -1;
_typeSec = -1;
_typeClothes = -1;
_typeAmmoPrim = -1;
_typeAmmoSec = -1;
_typeAmmoHG = -1;
_typeEquipment = -1;
_primLast = -1;
_handgunLast = -1;
_secLast = -1;
_clothesLast = -1;
_curPrim = -1;
_curSec = -1;
_curHandgun = -1;

_prim = -1;
_primAMMO = -1;
_handgun = -1;
_HGAMMO = -1;
_secAMMO = -1;
_sec = -1;
_clothes = -1;
_current = -1;
_EQ = -1;

_ctrlPrimary = [IDC_LB_PRIM, IDC_LB_PRIM_AMMO, IDC_BTN_PRIM, IDC_BTN_PRIM_AMMO];
_ctrlSec = [IDC_LB_SEC, IDC_LB_SEC_AMMO, IDC_BTN_SEC, IDC_BTN_SEC_AMMO];
_ctrlHg = [IDC_LB_HG, IDC_LB_HG_AMMO, IDC_BTN_HG, IDC_BTN_HG_AMMO];
_ctrlEquip = [IDC_LB_EQ, IDC_BTN_EQUIPMENT];
_ctrlClothes = [IDC_LB_CLOTHES, IDC_BTN_CLOTHES];

btnAddPrimary = false;
btnAddSecondary = false;
btnAddHandgun = false;
btnAddPrimaryAmmo = false;
btnAddSecondaryAmmo = false;
btnAddHandgunAmmo = false;
btnAddEquipment = false;
btnAddClothes = false;
btnClear = false;
btnRemoveCurrent = false;
btnRemoveCurrentAll = false;
btnExit = false;
btnSaveTempl = false;
btnLoadTempl = false;

btnPrimaryTab=false;
btnSecondaryTab=false;
btnHandgunTab=false;
btnEquipmentTab=false;
btnClothesTab=false;

_playerPos = getPos player;
_playerDir = getDir player;

call _fLoadProfile;
call _fOpenDialog;

while {true}do
{
	if ( player == vehicle player ) then
	{
		player setPos _playerPos;
		player setDir _playerDir;
	}
	else
	{
		_playerPos = getPos player;
		_playerDir = getDir player;
	};

	_money = (groupMoneyMatrix select playerSideIndex) select playerGroupIndex;
	_absmoney = _money;
	if ( _absmoney < 0 ) then {_absmoney = 0;};

	if ( (!dialog || btnExit)&& (_costBuy <= _absmoney) ) exitWith
	{
		if (_costBuy > 0) then {[_costBuy] execVM "Player\SendMoneySpent.sqf";};
		call _fCloseDialog;
	};
	if ( (!dialog || btnExit)&& (_costBuy > _absmoney) ) then
	{
		["Not Enough Money!", true, false, htGeneral, false] call funcHint;
		btnExit = false;
	};

	if ( !dialog ) then {call _fOpenDialog;};
	if ((!(isNull _object) && !(alive _object)) || !(alive player)) exitWith {call _fClear; call _fCloseDialog;};

// CHECK PRIMARY ammo CHANGE
	_primAMMOLast = _primAMMO;
	_primAMMO = lbCurSel IDC_LB_PRIM_AMMO;

	if (_prim != _primLast) then {_primAMMO = -1;};
	if ((_primAMMO != -1) && (_primAMMO != _primAMMOLast)) then
	{
		_typeAmmoPrim = lbValue [IDC_LB_PRIM_AMMO, _primAMMO];
		[_typeAmmoPrim] call _fAmmoChange;
	};

// CHECK PRIMARY CHANGE
	_primLast = _prim;
	_prim = lbCurSel IDC_LB_PRIM;

	if (_prim != -1 && _prim != _primLast) then
	{
		_typePrim = lbValue [IDC_LB_PRIM, _prim];
		call _fPrimChange;
	};

// CHECK HANDGUN ammo CHANGE
	_HGAMMOLast = _HGAMMO;
	_HGAMMO = lbCurSel IDC_LB_HG_AMMO;
	if (_handgun != _handgunLast) then {_HGAMMO = -1;};
	if ((_HGAMMO != -1) && (_HGAMMO != _HGAMMOLast)) then
	{
		_typeAmmoHG = lbValue [IDC_LB_HG_AMMO, _HGAMMO];
		[_typeAmmoHG] call _fAmmoChange;
	};

// CHECK HANDGUN CHANGE
	_handgunLast = _handgun;
	_handgun = lbCurSel IDC_LB_HG;
	if (_handgun != -1 && _handgun != _handgunLast) then
	{
		_typeHandgun = lbValue [IDC_LB_HG, _handgun];
		call _fHandgunChange;
	};

// CHECK SECONDARY ammo CHANGE
	_secAMMOLast = _secAMMO;
	_secAMMO = lbCurSel IDC_LB_sec_AMMO;
	if (_sec != _secLast) then {_secAMMO = -1;};
	if ((_secAMMO != -1) && (_secAMMO != _secAMMOLast)) then
	{
		_typeAmmoSec = lbValue [IDC_LB_sec_AMMO, _secAMMO];
		[_typeAmmoSec] call _fAmmoChange;
	};

// CHECK SECONDARY CHANGE
	_secLast = _sec;
	_sec = lbCurSel IDC_LB_SEC;
	if (_sec != -1 && _sec != _secLast) then
	{
		_typeSec = lbValue [IDC_LB_SEC, _sec];
		call _fSecChange;
	};

// CHECK BACKPACK CHANGE
	_clothesLast = _clothes;
	_clothes = lbCurSel IDC_LB_CLOTHES;
	if (_clothes != -1 && _clothes != _clothesLast) then
	{
		_typeClothes = lbValue [IDC_LB_CLOTHES, _clothes];
		call _fClothesChange;
	};

// CHECK Equipment Click
	_EqLast = _Eq;
	_Eq = lbCurSel IDC_LB_EQ;
	if ((_Eq != -1) && (_Eq != _EqLast)) then
	{
		_typeEquipment = lbValue [IDC_LB_EQ, _Eq];
		call _fEquipmentClick;
	};

// Check clicks
	if ( btnAddPrimary ) then {btnAddPrimary = false; _curPrim = [_typePrim, _curPrim] call _fChangeWeapon; call _fCurrent;};
	if ( btnAddSecondary ) then {btnAddSecondary = false; _curSec = [_typeSec, _curSec] call _fChangeWeapon; call _fCurrent;};
	if ( btnAddHandgun ) then {btnAddHandgun = false; _curHandgun = [_typeHandgun, _curHandgun] call _fChangeWeapon; call _fCurrent;};
	if ( btnAddPrimaryAmmo ) then {btnAddPrimaryAmmo = false; [_typeAmmoPrim] call _fAddMagazine; call _fCurrent;};
	if ( btnAddSecondaryAmmo ) then {btnAddSecondaryAmmo = false; [_typeAmmoSec] call _fAddMagazine; call _fCurrent;};
	if ( btnAddHandgunAmmo ) then {btnAddHandgunAmmo = false; [_typeAmmoHG] call _fAddMagazine; call _fCurrent;};
	if ( btnAddEquipment ) then {btnAddEquipment = false; [_typeEquipment] call _fAddItem; call _fCurrent;};
	if ( btnAddClothes ) then {btnAddClothes = false; [_typeClothes] call _fAddClothes; call _fCurrent;};
	if ( btnRemoveCurrent) then {btnRemoveCurrent = false; call _fRemoveCurrentSingle; call _fCurrent;};
	if ( btnRemoveCurrentAll) then {btnRemoveCurrentAll = false; call _fRemoveCurrentAll; call _fCurrent;};
	if ( btnClear ) then {btnClear = false; call _fDefault; call _fCurrent;};
	if ( btnSaveTempl ) then {btnSavetempl = false; call _fSaveTemplate;};
	if ( btnLoadTempl ) then {btnLoadtempl = false; call _fLoadTemplate;};

	if ( btnPrimaryTab) then
	{
		ctrlSetText [IDC_EQUIP_TYPELABEL, "Primary Weapons"];
		btnPrimaryTab=false;
		(_ctrlSec+_ctrlHg+_ctrlEquip+_ctrlClothes) call _fHide;
		_ctrlPrimary call _fShow;
	};
	if ( btnSecondaryTab) then
	{
		ctrlSetText [IDC_EQUIP_TYPELABEL, "Secondary Weapons"];
		btnSecondaryTab=false;
		(_ctrlPrimary+_ctrlHg+_ctrlEquip+_ctrlClothes) call _fHide;
		_ctrlSec call _fShow;
	};
	if ( btnHandgunTab) then
	{
		ctrlSetText [IDC_EQUIP_TYPELABEL, "Handguns"];
		btnHandgunTab=false;
		(_ctrlPrimary+_ctrlSec+_ctrlEquip+_ctrlClothes) call _fHide;
		_ctrlHg call _fShow;
	};
	if ( btnEquipmentTab) then
	{
		ctrlSetText [IDC_EQUIP_TYPELABEL, "Equipment"];
		btnEquipmentTab=false;
		(_ctrlPrimary+_ctrlSec+_ctrlHg+_ctrlClothes) call _fHide;
		_ctrlEquip call _fShow;
	};
	if ( btnClothesTab) then
	{
		ctrlSetText [IDC_EQUIP_TYPELABEL, "Clothing / Misc."];
		btnClothesTab=false;
		(_ctrlPrimary+_ctrlSec+_ctrlHg+_ctrlEquip) call _fHide;
		_ctrlClothes call _fShow;
	};

	_curIdx = lbCurSel IDC_LB_CURRENT;
	if ( _curIdx != -1 && _curIdx < count(_currentList)) then
	{
		_curEntry = _currentList select _curIdx;
		_class = _curEntry select 0;
		if ( _class == "" ) then {lbSetCurSel [IDC_LB_CURRENT, _curIdx+1]};
	};

	_weight = "";
	if (systemOfUnits != 2) then
	{
		_weight = format["%1 kg.",round (((loadAbs player)*0.1)/2.2)];
	}
	else
	{
		_weight = format["%1 lbs.",round ((loadabs player)*0.1)];
	};

	_costBuy = _transactionCost;
	if (_costBuy < 0) then {_costBuy = 0;};
	_text = format ["Cash: $%1\nCost: $%2\nWeight: %3", _money, _costBuy, _weight];
	[_text, false, true, htEquipmentCost, true] call funcHint;
	ctrlSetText [IDC_TEXT_MENU_STATUS, _text];

};
