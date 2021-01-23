private["_array", "_line", "_object", "_driver", "_gunner", "_commander", "_type", "_pos", "_azimuth", "_special", "_spawned"];

_array = _this;
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

		if ( _spawned ) then
		{
			if ( !isNull _object && alive _object ) then
			{
				_line set [5, getPos _object];
				_line set [6, getDir _object];

				if ( _object isKindof "Air" && (_pos select 2) > 0 ) then
				{
					_line set [7, "FLY"];
				};

				{
					deleteVehicle _x;
				}forEach (crew _object);

				deleteVehicle _object;
				
				_line set [0, objNull];
				_line set [8, false];

			};
		};
		_array set [_forEachIndex, _line];
	};

}forEach _array;

_array
