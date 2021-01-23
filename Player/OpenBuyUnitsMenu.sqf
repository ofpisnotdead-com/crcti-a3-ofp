// args: [_factory, _type]
disableSerialization;

_factory = _this select 0;
_typeFactory = _this select 1;
_back = _this select 2;

_typeUnit = -1;
_factoryIndex = -1;
_oldFactoryType = -1;

_selectedUnit = -1;
_oldSelectedUnit = -1;
_lastBuildingsInUse = [];

_controlCenters = [playerSideIndex, stComm] call funcGetWorkingStructures;

_remote = false;
if (isNull _factory) then {_remote = true; _typeFactory = -1;};

if (_remote && (count _controlCenters) == 0) then
{
	["No Working Comm Center", true, false, htBuyUnitCancel, true] call funcHint;
}
else
{
	_unit = player;
	_delay = 0.2;
	_maxDistToControl = 500;
	_maxGroupSize = maxGroupSize;

	_lastQueueTime = 0;
	_model = "";

	_nameFactory = "Buy Units";
	if (!_remote) then {_nameFactory = (structDefs select _typeFactory) select sdName;};

	_groups = groupMatrix select playerSideIndex;
	_groupsMoney = groupMoneyMatrix select playerSideIndex;

	_idcQueue = IDC_LB + 3;

// InitMenu	
	bFactoryBuy = false;
	bFactoryBuyManned = false;
	bCancel = false;

	_dialog = CreateDialog "FactoryMenu";
	[IDD_FactoryMenu]call funcFixDialogTitleColor;

	ctrlSetText [IDC_TEXT_MENU_NAME, _nameFactory];

	ctrlShow [IDC_BTN_BUY_MANNED, false];
	ctrlShow [IDC_BTN_BUY_MANNED_BG, false];
	ctrlShow [IDC_BTN_DRIVER, false];
	ctrlShow [IDC_BTN_GUNNER, false];
	ctrlShow [IDC_BTN_COMMANDER, false];
	ctrlShow [IDC_BG_DRIVER_SELECTED, false];
	ctrlShow [IDC_BG_GUNNER_SELECTED, false];
	ctrlShow [IDC_BG_COMMANDER_SELECTED, false];
	ctrlShow [IDC_TEXT_LIST2_INFO, false];
	ctrlShow [IDC_BG_LIST2, false];
	ctrlShow [IDC_LB_LIST2, false];
	ctrlShow [IDC_TEXT_PASSENGER_COUNT, false];

	if (!_remote) then
	{
		ctrlShow [IDC_TEXT_LIST3_INFO, false];
		ctrlShow [IDC_BG_LIST3, false];
		ctrlShow [IDC_LB_LIST3, false];
	};

	_selectedGroup = playerGroupIndex;
	_selectedUnit = -1;
	_lastSelQID = -1;

	_workingFactories = [];
	_lastWorkingFactories = [];
	_factories = [];

	_state = "update";
	while {_state != "finished"}do
	{

		_groupsMoney = groupMoneyMatrix select playerSideIndex;
		_controlCenters = [playerSideIndex, stComm] call funcGetWorkingStructures;

		if (_remote && (count _controlCenters) == 0) then {_state = "finished";};
		if (!alive _unit || !dialog ) then {_state = "finished";};
		if ((not _remote) && !(alive _factory)) then {_state = "finished";};

		if (_factory in buildingsInUse) then
		{
			_rbtime = _factory getVariable "rbtime";
			_str = format["%1 (%2)", _rbtime select 0, (_rbtime select 1) call funcSecondsToString];
			ctrlSetText[IDC_TEXT_MENU_STATUS, _str];
		}
		else
		{
			ctrlSetText[IDC_TEXT_MENU_STATUS, ""];
		};

		_money = _groupsMoney select playerGroupIndex;
		_text = format ["$%1", _money];
		ctrlSetText [IDC_TEXT_PLAYER_MONEY, _text];

		_lastSelQID = -1;
		if ((lbCurSel _idcQueue) < (lbSize _idcQueue)) then {_lastSelQID = lbValue [_idcQueue, lbCurSel _idcQueue];};

		// UpdateQueue
		if (time > _lastQueueTime+5) then
		{
			_lastQueueTime = time;
			lbClear _idcQueue;
			_queues = factoryQueues select playerSideIndex;

			if (count _queues > 0) then
			{
				{
					_facType = _x select 1;
					_facName = (structDefs select _facType) select sdName;
					_queue = _x select 2;

					if (count _queue > 0) then
					{
						_lbi = lbAdd [ _idcQueue, format["--- %1 (%2) ---",_facName, count _queue] ];
						lbSetValue [_idcQueue, _lbi, -1];

						{
							_entry = _x;
							if ( count _entry > 0 ) then
							{
								_type = _entry select 0;
								_name = (unitDefs select _type) select udName;
								_giJoin = _entry select 4;
								_cancelled = _entry select 6;
								_entryIdx = _entry select 7;

								_groupName = [playerSideIndex, _giJoin] call funcGetGroupName;

								_qstr = format["%1, %2", _name, _groupName];
								if ( _cancelled ) then {_qstr = "[CANCELLED]";};
								_lbi = lbAdd [ _idcQueue, _qstr ];
								lbSetValue [_idcQueue, _lbi, _entryIdx];
							};
						}forEach _queue;
					};
				}forEach _queues;

			};
		};

		if ( bCancel ) then
		{
			bCancel = false;
			_selectedQueueEntry = lbCurSel _idcQueue;
			_cancelIdx = lbValue[_idcQueue, _selectedQueueEntry];
			pvCancelQueueEntry = [_cancelIdx, playerSideIndex, playerGroupIndex];
			_nul = [pvCancelQueueEntry] execVM "Server\MsgCancelQueueEntry.sqf";
			publicVariable "pvCancelQueueEntry";
		};

		// InitGroupList
		if (playerGroup == (groupCommander select playerSideIndex)) then
		{
			ctrlShow [IDC_TEXT_LIST2_INFO, true];
			ctrlShow [IDC_LB_LIST2, true];
			ctrlShow [IDC_BG_LIST2, true];
		};

		if (ctrlVisible IDC_LB_LIST2) then
		{
			if ((lbCurSel IDC_LB_LIST2) >= 0) then {_selectedGroup = lbCurSel IDC_LB_LIST2;};
			_textGroups = [];
			_name = "";
			{
				_groupName = [-1,-1,_x] call funcGetGroupName;
				_sizeGroup = count units _x;
				_moneyGroup = _groupsMoney select _forEachIndex;
				_composition = [_x] call funcGetGroupComposition;
				_text = format["(%2) %1 $%3.   %4", _groupName, _sizeGroup, _moneyGroup, _composition];
				_textGroups set [_forEachIndex, _text];
			}foreach _groups;

			lbClear IDC_LB_LIST2;
			{
				lbAdd [IDC_LB_LIST2, _x];
			}foreach _textGroups;

			lbSetCurSel [IDC_LB_LIST2, _selectedGroup];
		};

		// CheckFactoriesChanged
		if ( _remote ) then
		{
			_workingFactories = [];
			_factories = [];
			_types = [stBarracks, stLight, stHeavy, stAir, stMarina];

			{
				_type = _x;
				_structs = [playerSideIndex, _type] call funcGetWorkingStructures;

				{
					_res = [getPos _x, playerSideIndex, stComm] call funcGetClosestStructure;
					if ((_res select 1) < _maxDistToControl) then
					{
						_workingFactories = _workingFactories + [_x];
						_factories = _factories + [[_x,_type]];
					};
				}foreach _structs;
			}forEach _types;

			if ( count(_workingFactories - _lastWorkingFactories) > 0 || count(_lastWorkingFactories - _workingFactories) > 0 ||
					count (_lastBuildingsInUse - buildingsInUse) > 0 || count(buildingsInUse - _lastBuildingsInUse) > 0) then
			{
				_lastWorkingFactories = _workingFactories;
				_lastBuildingsInUse = buildingsInUse;

				lbClear IDC_LB_LIST3;
				{

					_struct = _x select 0;
					_type = _x select 1;
					_name = (structDefs select _type) select sdName;
					_pos = getPos _struct;
					_posInfo = [_pos, playerSideIndex] call funcGetClosestBase;
					_textInUse = "";
					if (_struct in buildingsInUse) then
					{
						_textInUse= "IN USE";
					};
					_textPos = format ["%1 (%2) %3", _name, _posInfo select 0, _textInUse];
					lbAdd [IDC_LB_LIST3, _textPos];
				}foreach _factories;
			};

			_factoryIndex = lbCurSel IDC_LB_LIST3;
			if ( _factoryIndex >= 0 ) then
			{
				_factory = (_factories select _factoryIndex) select 0;
				_typeFactory = (_factories select _factoryIndex) select 1;
			}
			else
			{
				lbClear IDC_LB_LIST1;
				lbAdd[IDC_LB_LIST1,"No Factory Selected"];
			};
		};

		if ( _typeFactory >= 0 && _oldFactoryType != _typeFactory ) then
		{
			_oldFactoryType = _typeFactory;

			lbClear IDC_LB_LIST1;
			{
				_unitDesc = _x;
				_sideUnit = _unitDesc select udSide;

				if (_sideUnit == playerSideIndex && ((_unitDesc select udFactoryType) == _typeFactory)) then
				{

					_name = _unitDesc select udName;
					_cost = _unitDesc select udCost;
					_manning = _unitDesc select udCrew;

					_text = Format["$%1 %2", [_cost, 6] call funcPadNumber, _name];

					_lbi = lbAdd[IDC_LB_LIST1,_text];
					lbSetValue [IDC_LB_LIST1, _lbi, _forEachIndex];

					if ( _forEachIndex in (typesSupport select _sideUnit)) then {lbSetColor [IDC_LB_LIST1, _lbi, [0.5,0.5,.9,1]];};

					if (_cost > _money) then {lbSetColor [IDC_LB_LIST1, _lbi, [.5,0,0,1]];};
					if (lastSelectedUnitType == _forEachIndex) then {lbSetCurSel [IDC_LB_LIST1, _lbi];};

				};
			}forEach unitDefs;
		};

		// Check Selected Unit
		_selectedUnit = lbCurSel IDC_LB_LIST1;

		if (_selectedUnit >= 0 ) then
		{
			_oldSelectedUnit = _selectedUnit;
			_typeUnit = lbValue[IDC_LB_LIST1, _selectedUnit];
			_model = (unitDefs select _typeUnit) select udModel;

			_image = getText (configFile >> "CfgVehicles" >> _model >> "icon");
			if ( _model isKindOf "Man" ) then {_image = "";};
			ctrlSetText [IDC_Buy_Picture, _image];

			lastSelectedUnitType = _typeUnit;
			_cost = (unitDefs select _typeUnit) select udCost;

			_costManned = 0;
			_drivers = 1;
			_gunners = 0;
			_commanders = 0;

			_isUAV = getNumber(configFile >> "CfgVehicles" >> _model >> "isUav");

			_bVehicle = false;
			if ( _model isKindOf "Man" || _isUAV > 0 ) then
			{
				[IDD_FactoryMenu, IDC_BTN_BUY, "Buy"] call funcSetButtonText;
				ctrlShow [IDC_BTN_BUY_MANNED, false];
				ctrlShow [IDC_BTN_BUY_MANNED_BG, false];
				ctrlShow [IDC_BTN_DRIVER, false];
				ctrlShow [IDC_BTN_GUNNER, false];
				ctrlShow [IDC_BTN_COMMANDER, false];
				ctrlShow [IDC_BG_DRIVER_SELECTED, false];
				ctrlShow [IDC_BG_GUNNER_SELECTED, false];
				ctrlShow [IDC_BG_COMMANDER_SELECTED, false];
				ctrlShow [IDC_TEXT_PASSENGER_COUNT, false];

			}
			else
			{
				_bVehicle = true;

				_manning = (unitDefs select _typeUnit) select udCrew;
				_weptmp = (_model call funcGetVehicleWeapons);
				_gunners = count(_weptmp select 3);
				_commanders = count(_weptmp select 4);
				_cargoturrets = count(_weptmp select 5);
				_transportsoldier = getNumber(configFile >> "CfgVehicles" >> _model >> "Transportsoldier");

				_crewType = _manning select 1;
				[IDD_FactoryMenu, IDC_BTN_BUY, "Buy Empty"] call funcSetButtonText;

				if (_drivers == 0) then {ctrlShow [IDC_BTN_DRIVER, false];};
				if (_gunners == 0) then {ctrlShow [IDC_BTN_GUNNER, false];};
				if (_commanders == 0) then {ctrlShow [IDC_BTN_COMMANDER, false];};
				if (_drivers > 0) then {ctrlShow [IDC_BTN_DRIVER, true];};
				if (_gunners > 0) then {ctrlShow [IDC_BTN_GUNNER, true];};
				if (_commanders > 0) then {ctrlShow [IDC_BTN_COMMANDER, true];};

				if (ctrlVisible IDC_BTN_DRIVER && bMannedDriver) then {[IDD_FactoryMenu, IDC_BTN_DRIVER, "Driver: Yes"] call funcSetButtonText} else {[IDD_FactoryMenu, IDC_BTN_DRIVER, "Driver: No"] call funcSetButtonText};
				if (ctrlVisible IDC_BTN_GUNNER && bMannedGunner) then {[IDD_FactoryMenu, IDC_BTN_GUNNER, "Gunner: Yes"] call funcSetButtonText} else {[IDD_FactoryMenu, IDC_BTN_GUNNER, "Gunner: No"] call funcSetButtonText};
				if (ctrlVisible IDC_BTN_COMMANDER && bMannedCommander) then {[IDD_FactoryMenu, IDC_BTN_COMMANDER, "Commander: Yes"] call funcSetButtonText} else {[IDD_FactoryMenu, IDC_BTN_COMMANDER, "Commander: No"] call funcSetButtonText};

				_crewType = _manning select 1;
				_costManned = _cost;
				if (ctrlVisible IDC_BTN_DRIVER && bMannedDriver) then {_costManned = _costManned + _drivers*((unitDefs select _crewType) select udCost)};
				if (ctrlVisible IDC_BTN_GUNNER && bMannedGunner) then {_costManned = _costManned + _gunners*((unitDefs select _crewType) select udCost)};
				if (ctrlVisible IDC_BTN_COMMANDER && bMannedCommander) then {_costManned = _costManned + _commanders*((unitDefs select _crewType) select udCost)};

				ctrlShow [IDC_TEXT_PASSENGER_COUNT, true];
				if ( _cargoTurrets + _transportSoldier > 0 ) then
				{
					_text = format["Passengers: %1 FFV, %2 Cargo", _cargoTurrets, _transportSoldier];
					ctrlSetText [IDC_TEXT_PASSENGER_COUNT, _text];
				}
				else
				{
					ctrlSetText [IDC_TEXT_PASSENGER_COUNT, "Passengers: None"];
				};

				ctrlShow [IDC_BTN_BUY_MANNED, true];
				ctrlShow [IDC_BTN_BUY_MANNED_BG, true];
				[IDD_FactoryMenu, IDC_BTN_BUY_MANNED, format["Buy Manned $%1", _costManned]] call funcSetButtonText;
			};

			if (bFactoryBuy) then
			{
				bFactoryBuy = false;

				if (_typeUnit == -1) then
				{
					["No Unit Selected", true, false, htBuyUnitCancel, true] call funcHint;
				}
				else
				{
					if (_money < _cost) then
					{
						[format["Not Enough Money\nCost %1\nNeed %2", _cost, _cost - _money], true, false, htBuyUnitCancel, true] call funcHint;
					}
					else
					{
						_size = count units ((groupMatrix select playerSideIndex) select _selectedGroup);
						if (!_bVehicle && !(_size < _maxGroupSize)) then
						{
							[format["Group Full\nMax Size: %1\nCurrent Size: %2", maxGroupSize, _size], true, false, htBuyUnitCancel, true] call funcHint;
						}
						else
						{
							if ( _remote && _factoryIndex == -1 ) then
							{
								["No Factory Selected", true, false, htBuyUnitCancel, true] call funcHint;
							}
							else
							{
								if (_remote) then {_factory = (_factories select _factoryIndex) select 0;};
								[_typeUnit, 0, 0, 0, _selectedGroup, _factory] call funcBuyUnit;
							};
						};
					};

				};
			};

			if (bFactoryBuyManned) then
			{
				bFactoryBuyManned = false;

				if (_typeUnit == -1 ) then
				{
					["No Unit Selected", true, false, htBuyUnitCancel, true] call funcHint;
				}
				else
				{
					if (_money < _costManned) then
					{
						[format["Not Enough Money\nCost %1\nNeed %2", _costManned, _costManned - _money], true, false, htBuyUnitCancel, true] call funcHint;
					}
					else
					{
						_unitsToBuild = 0;
						_driver = 0;
						if (_drivers > 0 && bMannedDriver) then {_driver = 1; _unitsToBuild = _unitsToBuild + _drivers;};
						_gunner = 0;
						if (_gunners > 0 && bMannedGunner) then {_gunner = 1; _unitsToBuild = _unitsToBuild + _gunners;};
						_commander = 0;
						if (_commanders > 0 && bMannedCommander) then {_commander = 1; _unitsToBuild = _unitsToBuild + _commanders;};

						_size = count units ((groupMatrix select playerSideIndex) select _selectedGroup);
						if ((_size + _unitsToBuild) > maxGroupSize) then
						{
							[format["Group Full\nMax Size: %1\nCurrent Size: %2", maxGroupSize, _size], true, false, htBuyUnitCancel, true] call funcHint;
						}
						else
						{
							if ( _remote && _factoryIndex == -1) then
							{
								["No Factory Selected", true, false, htBuyUnitCancel, true] call funcHint;
							}
							else
							{
								if ( _remote) then {_factory = (_factories select _factoryIndex) select 0;};
								[_typeUnit, _driver, _gunner, _commander, _selectedGroup, _factory] call funcBuyUnit;
							};
						};
					};
				};
			};
		};

		if (_state != "finished") then {sleep _delay;};
	};

	bFactoryBuy = false;
	bFactoryBuyManned = false;
	if (dialog) then {closeDialog 0;};
	if ( _back ) then {_nul = [] exec "Player\OpenOptionsMenu.sqs";};
};

