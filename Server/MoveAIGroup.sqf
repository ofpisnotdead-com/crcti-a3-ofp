private ["_unit", "_pos", "_group", "_leader", "_inf","_car", "_apc", "_tank", "_air", "_typelist", "_formation", "_speedmode", "_distToDest", "_si", "_gi", "_setformation","_setspeedmode"];

_unit = _this select 0;
_pos = _this select 1;
_gi = _this select 2;
_si = _this select 3;

_minDist = 0;
_maxDist = 0;
if ( (count _this) > 4 ) then { _minDist = _this select 4; };
if ( (count _this) > 5 ) then { _maxDist = _this select 5; };

_group = group _unit;
_leader = leader _group;

_inf = [];
_car = [];
_apc = [];
_tank = [];
_air = [];

_speedmode = (((aiSetting select _si) select _gi) select aisSpeedmode);
_formation = (((aiSetting select _si) select _gi) select aisFormation);

_distToDest = _unit distance _pos;

_setformation = _formation;
if ( _formation == 10 && _distToDest > 300 ) then
{
	_setformation = 2;
};
if ( _formation == 10 && _distToDest <= 300 ) then
{
	_setformation = 7;
};

_setformation = aisFormations select _setformation;
_setspeedmode = aisSpeedModes select _speedmode;

{
	_veh = vehicle _x;

	if ( _x != _veh && _x == driver _veh ) then
	{
		if ( _veh isKindOf "Car" && !(_veh isKindof "Wheeled_APC" || _x isKindof "Tracked_APC" || _x isKindOf "APC") ) then
		{
			_car = _car + [_x];
		};

		if ( _veh isKindof "Wheeled_APC" || _x isKindof "Tracked_APC" || _x isKindOf "APC" ) then
		{
			_apc = _apc + [_x];
		};

		if ( _veh isKindOf "Tank" ) then
		{
			_tank = _tank + [_x];
		};

		if ( _veh isKindOf "Air" ) then
		{
			_air = _air + [_x];
		};
	};

	if ( _x == _veh ) then
	{
		_inf = _inf + [_x];
	};

}forEach units _group;

_typelist = [_inf, _car,_apc,_tank,_air];

/*diag_log str(_inf);
 diag_log str(_car);
 diag_log str(_apc);
 diag_log str(_tank);
 diag_log str(_air);

 diag_log format["%1 move to %2", str(_unit), str(_pos)];*/

{
	_list = _x;
	if ( count _list > 0 ) then
	{
		_first = _list select 0;

		if ( (vehicle _first) isKindof "Man" ) then
		{
			_first = (leader _group);
		};

		_follow = [];

		{
			_unit = _x;

			if ( vehicle _unit == _unit || (driver vehicle _unit) == _unit ) then
			{

				if ( _unit == _first || (_unit distance _first) > 200 ) then
				{
					[_unit, _pos, _minDist, _maxDist] call funcMoveAI;
				}
				else
				{
					_follow = _follow + [_unit];
				};

				_unit setUnitPos "AUTO";
				_unit setFormation _setformation;
				_unit setSpeedMode _setspeedmode;
			};

		}forEach _list;

		_follow doFollow _first;
	};
}forEach _typelist;

_group setFormation _setformation;
_group setSpeedMode _setspeedmode;
