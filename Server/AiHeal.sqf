// args: [unit, si, gi, vehicleHeal, type, support]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_vehicleHeal = _this select 3;
_type = _this select 4;
_support = _this select 5;

_timeHeal = 5;
_cost = 0;

if ( _unit != _vehicleHeal ) then
{
	if ( _type != -1 ) then
	{

		_damage = damage _vehicleHeal;
		_buildtime = (unitDefs select _type) select udBuildTime;
		_cost = (unitDefs select _type) select udCost;

		_costRepair = _damage*_cost*RepairRearmCostFactor;
		_costRepair = _costRepair - (_costRepair % 1);

		if ( _costRepair < 100 ) then
		{
			_costRepair = 100;
		};

		_money = (groupMoneyMatrix select _si) select _gi;
		if ( _costRepair <= _money ) then
		{

			[_si, _gi, _costRepair] call funcMoneySpend;

			_timeRepair = ceil(_damage*_buildtime*factorRepairTime + 10);

			sleep _timeRepair;
			if (alive _vehicleHeal && alive _support ) then
			{

				_vehicleHeal setDamage 0;
				_crew = crew _vehicleHeal;

				{
					if ( alive _x && alive _support ) then
					{
						_x setDamage 0;
						sleep _timeHeal;
					};
				}forEach _crew;
			};
		};
	};
}
else
{
	sleep _timeHeal;
	if (alive _vehicleHeal && alive _support) then
	{
		_unit setDamage 0;
	};
};