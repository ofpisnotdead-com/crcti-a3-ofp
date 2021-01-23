//args: [unit, si, gi, vehicleRearm, type, truck]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_vehicleRearm = _this select 3;
_type = _this select 4;
_support = _this select 5;
_rearmData = [[],[]];
_timeRearm = 5;
_cost = 50;

_sigi_type = _vehicleRearm getVariable "SQU_SI_GI";
_type = _sigi_type select 2;
_rearmData = _vehicleRearm call funcGetRearmData;
_weapons = _rearmData select 0;
_Mags = _rearmData select 1;
_items = _rearmData select 2;
_pack = _rearmData select 3;

if( (alive _unit) && (alive _vehicleRearm) && (count _Mags > 0) && (_type != -1) )then
{
	if( _gi == -1)then {_gi = giCO select _si};

	if(_sigi_type select 3)then
	{
		_cost = (structDefs select _type) select sdCost;
		_timeRearm = (structDefs select _type) select sdRearmTime;
	}
	else
	{
		_cost = (unitDefs select _type) select udCost;
		_unitDesc = unitDefs select _type;
		_timeRearm = round(_unitDesc select udBuildTime * 0.5);
	};

	_cost = round(_cost * 0.25 * RepairRearmCostFactor);

	if( _cost < 50) then
	{
		_cost = 50;
	};

	_money = (groupMoneyMatrix select _si) select _gi;
	if(_money >= _cost ) then
	{
		//REARM INF
		if(_unit == _vehicleRearm) then
		{
			_vehicleRearm setCombatMode "BLUE";
			//_vehicleRearm playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep _timeRearm;

			if ( alive _vehicleRearm && alive _support ) then
			{

				if(_type == -2) then
				{
					if( _cost > 0 )then {[_si, _gi, _cost] call funcMoneySpend};
					[_vehicleRearm, _si] execVM "Server\EquipGroupLeaderAI.sqf";
				}
				else
				{
					{	_vehicleRearm unassignItem _x}forEach (assignedItems _vehicleRearm);
					removeAllItems _vehicleRearm;
					removeAllWeapons _vehicleRearm;
					removeBackPack _vehicleRearm;

					_vehicleRearm setCombatMode "YELLOW";
					_unitDesc = unitDefs select _type;
					_scripts = _unitDesc select udRearm;

					_vehicleRearm addBackPack _pack;

					{	_vehicleRearm addWeapon _x}foreach _weapons;
					{	_vehicleRearm addMagazine _x}foreach _mags;

					{
						_vehicleRearm addItem _x;
						_vehicleRearm assignItem _x;
					}forEach _items;

					reload _unitRearm;

					pvRearmVehicle = [_vehicleRearm,_scripts,_type,_si,_rearmData];
					publicVariable "pvRearmVehicle";
					[pvRearmVehicle] spawn MsgRearmVehicle;
				};
			};

		}
		else
		{
			//REARM Vehicle or Static						
			sleep _timeRearm;

			if ( alive _unit && alive _vehicleRearm ) then
			{
				_unitDesc = unitDefs select _type;
				_scripts = _unitDesc select udRearm;

				pvRearmVehicle = [_vehicleRearm,_scripts,_type, _si,_rearmData];
				publicVariable "pvRearmVehicle";
				[pvRearmVehicle] spawn MsgRearmVehicle;
			};
		};

		if( _cost > 0 )then {[_si, _gi, _cost] call funcMoneySpend};

	};
};
