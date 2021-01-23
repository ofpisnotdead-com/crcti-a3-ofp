if ( isServer ) then
{
	_pvBuyUnit = _this select 0;
	_type = _pvBuyUnit select 0;
	_driver = _pvBuyUnit select 1;
	_gunner = _pvBuyUnit select 2;
	_commander = _pvBuyUnit select 3;
	_giJoin = _pvBuyUnit select 4;
	_giBuyer = _pvBuyUnit select 5;
	_si = _pvBuyUnit select 6;
	_factory = _pvBuyUnit select 7;

	_model = (unitDefs select _type) select udModel;

	_bVehicle = false;

	if ( !(_model isKindOf "Man")) then
	{
		_bVehicle = true;
	};
	
	_unitsToBuild = 1;
	if ( _bVehicle ) then
	{
		_weptmp = (_model call funcGetVehicleWeapons);
		_gunners = _weptmp select 3;
		_commanders = _weptmp select 4;
	
		_unitsToBuild = _driver;
		_unitsToBuild = _unitsToBuild + _gunner*count(_gunners);
		_unitsToBuild = _unitsToBuild + _commander*count(_commanders);
	};

	_unitsInProgress = ((groupUnitsBuildingMatrix select _si) select _giJoin);
	_size = (count units ((groupMatrix select _si) select _giJoin)) + _unitsInProgress;

	if ((_unitsToBuild + _size) > maxGroupSize) then
	{
		[_type, _si, _giBuyer, _giJoin] execVM "Server\Info\GroupFull.sqf";
	};

	if (isNull _factory || !(alive _factory)) then
	{
		player globalchat "TODO: send factory destroyed message";
	};

	if ((_unitsToBuild + _size) <= maxGroupSize && !(isNull _factory) && alive _factory) then
	{
		[_factory, _type, _driver, _gunner, _commander, _si, _giJoin, _giBuyer] call funcAddToUnitQueue;
	};
};