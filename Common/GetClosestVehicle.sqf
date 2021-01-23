private ["_pos", "_sides", "_types", "_except", "_vehicleFound", "_distanceFound", "_si_gi_type", "_si", "_type", "_dist"];

_pos = _this select 0;
_sides = _this select 1;
_types = _this select 2;
_except = _this select 3;

_vehicleFound = objNull;
_distanceFound = 1000000000;

{
	_si_gi_type = _x getVariable "SQU_SI_GI";

	if ( !isNil "_si_gi_type") then
	{

		_si = _si_gi_type select 0;
		_type = _si_gi_type select 2;

		if ( alive _x && ((count _sides == 0) || (_si in _sides)) && ((count _types == 0) || (_type in _types)) && !(_x in _except)) then
		{
			_dist = _x distance _pos;
			if ( _dist < _distanceFound ) then
			{
				_distanceFound = _dist;
				_vehicleFound = _x;
			};
		};

	};
}forEach vehicles;

[_vehicleFound, _distanceFound]

