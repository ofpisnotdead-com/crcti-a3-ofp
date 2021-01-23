if ( isServer ) then
{
	waitUntil {!isNil "crcti_kb_initServerDone"};
	waitUntil {crcti_kb_initServerDone};
};

if ( !isNull player ) then
{
	waitUntil {!isNil "crcti_kb_initPlayerDone"};
	waitUntil {crcti_kb_initPlayerDone};
};

_pvUnitBuilt = _this select 0;

_type = _pvUnitBuilt select 0;
_si = _pvUnitBuilt select 1;
_gi = _pvUnitBuilt select 2;
_unit = _pvUnitBuilt select 3;

if ( isServer ) then
{
	UnitInitList = UnitInitList + [_pvUnitBuilt];
};

if ( (alive _unit || _unit == mhqWest || _unit == mhqEast) && !(isnull _unit) ) then
{
	_initialized = _unit getVariable ["initialized", false];

	if ( !_initialized ) then
	{
		_unit setVariable ["initialized", true];

		_desc = unitDefs select _type;
		_model = _desc select udModel;
		_cost = _desc select udCost;

		if ( _type in (typesFakeMHQ select _si) ) then
		{
			_mhqdesc = unitDefs select ([utMHQWest, utMHQEast] select (_si == siEast));
			_cost = _mhqdesc select udCost;
		};

		_score = round(_cost);

		_isVehicle = true;
		if ( _model isKindof "Man" ) then
		{
			_isVehicle = false;
			_event = format["[_this, %1, %2] spawn EventInfantryKilled", _si, _score];
			_unit addEventHandler ["killed", _event];
		}
		else
		{
			_event = format["[_this, %1, %2, true] spawn EventVehicleHit", _si, _score];
			_unit addEventHandler ["killed", _event];
			_event = format["[_this, %1, %2, false] spawn EventVehicleHit", _si, _score];
			_unit addEventHandler ["hit", _event];
		};

		if ( GPSAvailable == 0 ) then
		{
			_unit removeWeapon "ItemGPS";
		};

		if ( FatigueEnabled == 1 || FatigueEnabled == 3) then
		{
			_unit enableFatigue true;
		}
		else
		{
			_unit enableFatigue false;
		};

		if ( isServer ) then
		{

			_scripts = _desc select udScriptsServer;
			{
				[_unit, _type, _si] spawn _x;
			}foreach _scripts;

		};

		if ( !isNull player && hasInterface) then
		{

			if( _si == playerSideIndex) then
			{
				playerGroup reveal _unit;
			};

			(unitsBuilt select _si) set [ _type, 1 + ((unitsBuilt select _si) select _type) ];

			if(_isVehicle) then
			{
				[_unit, _type, _si, _gi] spawn funcInitVehicle;
			}
			else
			{
				[_unit, _type, _si, _gi] spawn funcInitInfantry;
			};

			_scripts = _desc select udScriptsPlayer;
			{
				[_unit, _type, _si, _gi] spawn _x;
			}foreach _scripts;

		};
	};
};