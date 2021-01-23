private["_array", "_line", "_object", "_driver", "_gunner", "_commander", "_type", "_pos", "_azimuth", "_special", "_ret", "_si", "_gi", "_group", "_spawned", "_lock"];

_array = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_group = _this select 3;

//diag_log format["spawn: %1", str(_this)];

{
	_line = _x;
	if ( str(_line) != "0" ) then
	{
		_object = _line select 0;
		_driver = _line select 1;
		_gunner = _line select 2;
		_commander = _line select 3;
		_type = _line select 4;
		_pos = _line select 5;
		_azimuth = _line select 6;
		_special = _line select 7;
		_spawned = _line select 8;
		_lock = _line select 9;

		if ( !_spawned ) then
		{
			_ret = [_type, _driver, _gunner, _commander, _pos, _azimuth, _si, _gi, _group, _special, true, false] call funcAddUnit;

			[_ret select 0, _lock] spawn funcLockVehicle;

			_line set [0, _ret select 0];
			_line set [8, true];

			_array set [_forEachIndex, _line];
		};
	};

}forEach _array;

_array