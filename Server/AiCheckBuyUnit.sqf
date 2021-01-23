// arg: [unit, si, giBuyer]

_unit = _this select 0;
_si = _this select 1;
_giBuyer = _this select 2;
_type = -1;
_giJoin = _giBuyer;

sleep 5 + random(5);

_money = (groupMoneyMatrix select _si) select _giBuyer;
_slots = maxGroupSize - (count units ((groupMatrix select _si) select _giJoin) + ((groupUnitsBuildingMatrix select _si) select _giJoin));

{
	if ( time > (_x select 1) ) then
	{
		((groupBuyQueue select _si) select _giJoin) set [_forEachIndex, 0];
	};
}forEach ((groupBuyQueue select _si) select _giJoin);

(groupBuyQueue select _si) set [_giJoin, ((groupBuyQueue select _si) select _giJoin) - [0]];

//diag_log format["%1 %2 %3 %4 %5", _si, _giJoin, time, str((groupBuyQueue select _si) select _giJoin), count((groupBuyQueue select _si) select _giJoin)];

if ( _money > 0 && _slots > 0 && count((groupBuyQueue select _si) select _giJoin) < 5) then
{

	_unitsBuy = (unitsBuyAI select _si) select (((aiSetting select _si) select _giJoin) select aisBuy);
	_type = _unitsBuy call funcGetRandomUnitType;

	if ( _type != -1 ) then
	{

		_unitDesc = unitDefs select _type;
		_name = _unitDesc select udName;
		_cost = _unitDesc select udCost;

		_income = 0;

		{
			_townSide = (_x select tdSide);
			_val = round((_x select tdValue)*TownIncomeFactor);

			if (_townSide == _si) then
			{
				_income = _income + _val;
			}
		}forEach towns;

		_income = _income / 12.0;

		_diff = 0 max (_cost - _money);

		_btime = 1;
		if ( _income > 0 ) then {_btime = _diff / _income;};
		_btime = _btime * 60;

		if ( _btime < 60 ) then {_btime = 60;};

		if ( _btime < 600 ) then
		{
			(groupBuyQueue select _si) set [_giJoin, ((groupBuyQueue select _si) select _giJoin) + [[_type,time + _btime]]];
		};
	};
};

_type = -1;

if ( count((groupBuyQueue select _si) select _giJoin) > 0 ) then
{
	_entry = ((groupBuyQueue select _si) select _giJoin) select 0;
	_type = _entry select 0;

	if ( _type != -1 ) then
	{
		_unitDesc = unitDefs select _type;
		_model = (unitDefs select _type) select udModel;
		_weptmp = (_model call funcGetVehicleWeapons);
		_gunners = count(_weptmp select 3);
		_commanders = count(_weptmp select 4);

		_cost = _unitDesc select udCost;
		_crew = _unitDesc select udCrew;
		_costCrew = 0;
		if ( count(_crew) > 0 ) then
		{
			_costCrew = (unitDefs select (_crew select 1)) select udCost;
		};

		_driver = 0;
		_gunner = 0;
		_comm = 0;

		if ( !(_model isKindof "Man")) then
		{
			_driver = 1;
			_cost = _cost + _costCrew;
		};

		if (_gunners > 0) then
		{
			_gunner = 1;
			_cost = _cost + _gunners*_costCrew;
		};

		if (_commanders > 0) then
		{
			_comm = 1;
			_cost = _cost + _commanders*_costCrew;
		};

		if ( _slots >= (_driver + _gunners + _commanders) && (_money >= _cost )) then
		{
			_buyBase = ((aiSetting select _si) select _giJoin) select aisBuyBase;
			_factoryType = (unitDefs select _type) select udFactoryType;
			_factory = [_si, [_factoryType], _buyBase] call funcGetIdleFactory;

			if (!isNull _factory) then
			{
				[_factory, _type, _driver, _gunner, _comm, _si, _giJoin, _giBuyer] call funcAddToUnitQueue;
				((groupBuyQueue select _si) select _giJoin) set [0,0];
				(groupBuyQueue select _si) set [_giJoin, ((groupBuyQueue select _si) select _giJoin) - [0]];
			};
		};
	};
};
