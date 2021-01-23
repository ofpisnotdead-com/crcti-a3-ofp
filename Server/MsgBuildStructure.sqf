if ( isServer ) then
{
	_value = _this select 0;

	_posX = (_value select 0) select 0;
	_posY = (_value select 0) select 1;
	_dir = _value select 1;
	_type = _value select 2;
	_gi = _value select 3;
	_si = _value select 4;

	_FloatObj = false;

	if (_dir >499) then
	{
		_dir = (_dir - 500);
		_FloatObj = true;
	};

	[_type, _si, _gi, [_posX, _posY, 0], _dir, _FloatObj] execVM "Server\BuildStructure.sqf";
};
