private["_group", "_result", "_si"];

_group = _this select 0;
_result = ""; // [];

if ( !isNull _group ) then
{
	_men = 0;
	_cars = 0;
	_light = 0;
	_heavy = 0;
	_heli = 0;
	_plane = 0;
	_support = 0;
	_static = 0;

	_veh = [];

	{
		if ( !((vehicle _x) in _veh) ) then
		{
			_veh = _veh + [vehicle _x];
		};
	}forEach (units _group);

	{
		_type = -1;
		_si = siNone;
		_si_gi_type = _x getVariable "SQU_SI_GI";

		if ( !isNil "_si_gi_type") then
		{
			_si = _si_gi_type select 0;
			_type = _si_gi_type select 2;
		};

		if ( _type != -1 && (_type in (typesSupport select _si)) ) then
		{
			_support = _support + 1;
		}
		else
		{
			if ( _x isKindOf "Man" ) then
			{
				_men = _men + 1;
			};
			if ( ((_x isKindof "Motorcycle" || _x isKindof "Car" || _x isKindof "Car_F") && !(_x isKindof "Wheeled_APC_F" || _x isKindof "Wheeled_APC" || _x isKindof "Tracked_APC" || _x isKindOf "APC"))) then
			{
				_cars = _cars + 1;
			};
			if ( (_x isKindof "Wheeled_APC_F" || _x isKindof "Wheeled_APC" || _x isKindof "Tracked_APC" || _x isKindOf "APC") ) then
			{
				_light = _light + 1;
			};
			if ( (_x isKindof "Tank" || _x isKindof "Tank_F") && !(_x isKindof "Wheeled_APC_F" ||_x isKindof "Wheeled_APC" || _x isKindof "Tracked_APC" || _x isKindOf "APC")) then
			{
				_heavy = _heavy + 1;
			};
			if ( _x isKindOf "Helicopter") then
			{
				_heli = _heli + 1;
			};
			if ( _x isKindOf "Plane") then
			{
				_plane = _plane + 1;
			};
			if ( _x isKindOf "StaticWeapon") then
			{
				_static = _static + 1;
			};
		};

	}forEach _veh;

	if ( _men > 0 ) then
	{
		_result = format["%1M:%2 ", _result, _men];
	};
	if ( _cars > 0 ) then
	{
		_result = format["%1C:%2 ", _result, _cars];
	};
	if ( _light > 0 ) then
	{
		_result = format["%1L:%2 ", _result, _light];
	};
	if ( _heavy > 0 ) then
	{
		_result = format["%1H:%2 ", _result, _heavy];
	};
	if ( _heli > 0 ) then
	{
		_result = format["%1CH:%2 ", _result, _heli];
	};
	if ( _plane > 0 ) then
	{
		_result = format["%1P:%2 ", _result, _plane];
	};
	if ( _support > 0 ) then
	{
		_result = format["%1S:%2 ", _result, _support];
	};
	if ( _static > 0 ) then
	{
		_result = format["%1SW:%2 ", _result, _static];
	};
};

_result;
