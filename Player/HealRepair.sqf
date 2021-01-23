// args: [unit, truck, <vehicle>]

_unit = _this select 0;
_truck = _this select 1;
_vehicle = vehicle _unit;

if ( count _this > 2 ) then
{
	_vehicle = _this select 2;
};

if ( (getPos _truck) select 2 > 5 ) then
{
	["Flying Repairtruck ey?", true, true, htGeneral, false] call funcHint;
	playSound "fail";
}
else
{
	if ( speed _truck > 5 ) then
	{
		["Repairtruck is moving!", true, false, htGeneral, false] call funcHint;
	}
	else
	{
		if (_unit == _vehicle) then
		{
			_damage = damage _unit;

			if (alive _unit && alive _truck ) then
			{
				_timeHeal = time + _damage*10;

				while {time < _timeHeal && alive _unit && alive _truck}do
				{
					[format["Healing. %1 seconds to completion.", round(_timeHeal-time)], false, true, htHealRepair, true] call funcHint;
					sleep 1;
				};

				if (alive _unit && alive _truck) then
				{
					if ( AceWoundingEnabled > 0 ) then
					{
						_nul = _unit execVM "x\ace\addons\sys_wounds\fnc_unitinit.sqf";
					};

					_unit setDamage 0;
					["Healing complete ...", false, false, htGeneral, false] call funcHint;
				};

			};
		}
		else
		{
			_damage = damage _vehicle;

			_type = (_vehicle getVariable "SQU_SI_GI") select 2;
			_lastrepair = (_vehicle getVariable "lastRepair");

			if ( isNil "_lastrepair" ) then {_lastrepair = time - repairBlockTime;};

			if ( time - _lastrepair < repairBlockTime ) then
			{
				[format["Repair blocked for another %1 seconds.", repairBlockTime - round(time - _lastRepair)], true, false, htGeneral, false] call funcHint;
			}
			else
			{
				_vehcost = (unitDefs select _type) select udCost;
				_buildtime = (unitDefs select _type) select udBuildTime;

				_cost = round(_vehcost * _damage*RepairRearmCostFactor)+100;
				_money = (groupMoneyMatrix select playerSideIndex) select playerGroupIndex;

				if ( _money <= _cost ) then
				{
					[format["Not enough money for repair. (%1$).", _cost], true, false, htGeneral, false] call funcHint;
				}
				else
				{
					_abort = false;
					if (alive _vehicle && alive _truck && (_vehicle distance _truck) < repairRange) then
					{
						[_cost] execVM "Player\SendMoneySpent.sqf";
						[format["Repair Cost %1$.", _cost], false, false, htRepairPrice, false] call funcHint;
						
						_timeRepair = ceil(_damage*_buildtime*factorRepairTime + 10);
						_d = _damage / _timeRepair;
						_timeRepair = time + _timeRepair;
						_startt = time;
						_vehicle setVariable ["lastRepair", _timeRepair, true];

						while {time < _timeRepair && alive _vehicle && alive _truck && (_vehicle distance _truck) < repairRange}do
						{
							[format["Repairing. %1 seconds to completion.", round(_timeRepair-time)], false, true, htHealRepair, true] call funcHint;
							_vehicle setDamage ((damage _vehicle) - _d);
							_oldd = damage _vehicle;
							sleep 1;
							if ( damage _vehicle > _oldd ) exitWith {_abort = true;};
						};

						if (alive _vehicle && alive _truck && (_vehicle distance _truck) < repairRange) then
						{
							{
								if ( AceWoundingEnabled > 0 ) then
								{
									_nul = _x execVM "x\ace\addons\sys_wounds\fnc_unitinit.sqf";
								};

								_x setDamage 0;
							}forEach (crew _vehicle);

							["Repairs complete.", false, false, htGeneral, false] call funcHint;
						}
						else
						{
							_abort = true;
						};

						if ( _abort ) then
						{
							[format["Repair aborted!"], true, false, htGeneral, false] call funcHint;
						};

						_vehicle setVariable ["lastRepair", time, true];
					};
				};
			};
		};
	};
};