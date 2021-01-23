// args: [unit, truck, <vehicle>]

_unit = _this select 0;
_support = _this select 1;
_vehicle = vehicle _unit;

_mustexit = false;

if((count _this) > 2)then
{
	_vehicle = _this select 2
};

if ( (getPos _support) select 2 > 1 ) then
{
	["Flying Rearmtruck ey?", true, true, htRearmFail, false] call funcHint;
	playSound "fail";
}
else
{
	if ( speed _support > 1 ) then
	{
		["Rearmtruck is moving!", true, false, htRearmFail, false] call funcHint;
	}
	else
	{
		if(((_vehicle distance _support) > 2*repairRange)&&(_unit == player)) then
		{
			["Support vehicle out of range", true, false, htRearmFail, false] call funcHint;
		}
		else
		{
			if((_unit == player) && (_unit == _vehicle)) then
			{
				_nul = [_support, 1] spawn scriptOpenEquipmentMenu;
			}
			else
			{
				_unitRearm = _unit;
				_timeRearm = 5;
				_cost = 0;
				_mustexit = false;

				if( _unit != _vehicle)then
				{
					_unitRearm = _vehicle;
				};

				_sigi_type = _unitRearm getVariable "SQU_SI_GI";
				_si = _sigi_type select 0;
				_type = _sigi_type select 2;

				_model = typeOf _unitRearm;
				_displayName = getText (configFile >> "CfgVehicles" >> _model >> "displayName");

				if( _sigi_type select 3 ) then
				{
					_cost = (structDefs select _type) select sdCost;
					_timeRearm = (structDefs select _type) select sdRearmTime;
				}
				else
				{
					_unitDesc = unitDefs select _type;
					_cost = _unitDesc select udCost;
					_timeRearm = round((_unitDesc select udBuildTime)*0.5);
				};

				//get rearm data from config file
				_rearmData = _unitRearm call funcGetRearmData;
				_weap = _rearmData select 0;
				_mags = _rearmData select 1;
				_items = _rearmData select 2;
				_pack = _rearmData select 3;

				if((count _mags) == 0) then
				{
					["Unit is not armed.", true, false, htRearmFail, false] call funcHint;
				}
				else
				{
					//CALC REARM COST
					_cost = round(_cost * 0.25 * RepairRearmCostFactor);
					if(_cost < 50)then {_cost = 50};
					if(_unit == _unitRearm)then {_cost = _cost + 50*( {_x == magMine}count _mags)};
					_money = (groupMoneyMatrix select playerSideIndex) select playerGroupIndex;

					if( _cost > _money) then
					{
						[format["Not enough money for rearm. ($%1 needed)", _cost], true, false, htRearmFail, false] call funcHint;
					};

					if(_unitRearm in vehiclesRearming) then
					{
						["Rearm not started, rearm of vehicle already in progress.", true, false, htRearmFail, false] call funcHint;
					};

					if ( _money >= _cost && !(_unitRearm in vehiclesRearming) ) then
					{

						[format["Rearm Cost $%1", _cost], false, false, htRearmPrice, true] call funcHint;

						// Rearm Infantry
						if(_unit == _unitRearm)then
						{
							if ( local _unitRearm && alive _unitRearm && alive _support ) then
							{
								if(_cost > 0)then {[_cost] execVM "Player\SendMoneySpent.sqf"};

								{	_unitRearm unassignItem _x}forEach (assignedItems _unitRearm);
								removeAllItems _unitRearm;
								removeAllWeapons _unitRearm;
								removeBackPack _unitRearm;

								sleep 5;

								_unitDesc = unitDefs select _type;
								_scripts = _unitDesc select udRearm;

								_unitRearm addBackPack _pack;

								{	_unitRearm addWeapon _x}foreach _weap;
								{	_unitRearm addMagazine _x}foreach _mags;

								{
									_unitRearm addItem _x;
									_unitRearm assignItem _x;
								}forEach _items;

								reload _unitRearm;

								pvRearmVehicle = [_unitRearm,_scripts,_type,_si];
								publicVariable "pvRearmVehicle";
								[pvRearmVehicle] spawn MsgRearmVehicle;
							};

						}
						else
						{
							// Rearm Vehicle
							if(_cost > 0)then {[_cost] execVM "Player\SendMoneySpent.sqf"};

							vehiclesRearming set [count vehiclesRearming, _unitRearm];

							_startt = time;
							while {time < _startt + _timeRearm}do
							{
								if(!(alive _unitRearm)) exitwith
								{
									["Rearm failed. Vehicle destroyed.", true, false, htRearmFail, false] call funcHint;
									_mustexit = true;
								};

								if(!(alive _support)) exitwith
								{
									["Rearm failed. Support Vehicle destroyed.", true, false, htRearmFail, false] call funcHint;
									_mustexit = true;
								};

								if((_unitRearm distance _support) > 2*repairRange ) exitWith
								{
									["Support vehicle out of range", true, false, htRearmFail, false] call funcHint;
									_mustexit = true;
								};

								[format["Rearming %1\nFinished in %2 seconds.", _displayName, floor((_timeRearm+_startt)-time)], false, true, htRearm, true] call funcHint;
								sleep 0.5;
							};

							if(_mustexit) then
							{
								vehiclesRearming = vehiclesRearming - [_unitRearm];
							}
							else
							{
								_unitDesc = unitDefs select _type;
								_scripts = _unitDesc select udRearm;

								pvRearmVehicle = [_unitRearm,_scripts,_type,_si];
								publicVariable "pvRearmVehicle";
								[pvRearmVehicle] spawn MsgRearmVehicle;
							};

						};

						if(! _mustexit) then
						{
							sleep 2;

							["Rearm Complete.", false, false, htRearm, true] call funcHint;
							if(_unit != _unitRearm)then {vehiclesRearming = vehiclesRearming - [_unitRearm]};
						};
					};
				};
			};
		};
	};
};