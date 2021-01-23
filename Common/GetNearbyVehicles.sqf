private ["_pos", "_maxdist", "_sides", "_types", "_except", "_res", "_si", "_type", "_dist", "_si_gi_type"];

_pos = _this select 0;
_maxdist = _this select 1;
_sides = _this select 2;
_types = _this select 3;
_except = _this select 4;

_res = [];

{
	_si_gi_type = _x getVariable "SQU_SI_GI";

	if ( !isNil "_si_gi_type") then
	{
		_si = _si_gi_type select 0;
		_type = _si_gi_type select 2;

		if ( alive _x && ((count _sides == 0) || (_si in _sides)) && (_type >= 0) && ((count _types == 0) || (_type in _types)) && !(_x in _except)) then
		{
			_res set [count _res, [_x, _type, _x distance _pos, "vehicle"]];
		};
	};

}forEach (_pos nearEntities ["All", _maxdist]);

_res
