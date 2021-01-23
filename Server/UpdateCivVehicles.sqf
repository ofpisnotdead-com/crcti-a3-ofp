_towns = + towns;
_si = siCiv;
_vehicleArray = [];
_exclude = [];

_garageClasses = ["Land_i_Garage_V1_F", "Land_Ind_Garage01", "Land_Ind_Garage01_EP1"];

// Throw the dice
{
	_placePos = getPos(_x select tdFlag);
	_count = round(6+random(8));
	_count = _count * CivilianVehiclesAmount;

	_buildings = nearestObjects [_placePos, ["House"], 500];
	_garages = nearestObjects [_placePos, _garageClasses, 500];

	{
		if ( _x in _exclude ) then {_garages = _garages - [_x];};
	}forEach _garages;

	for[ {_i=0}, {_i<_count}, {_i=_i+1}] do
	{
		_type = (carTown select _si) call funcGetRandomUnitType;

		if ( _type != -1 ) then
		{
			_model = ((unitDefs) select _type) select udModel;

			_pos = [0,0,0];
			_dir = 0;
			_trys = 0;
			_placed = false;

			while {(_pos select 0) == 0 && (_pos select 1) == 0 && _trys < 100}do
			{
				if ( count(_buildings) > 0 ) then
				{
					if ( count(_garages) > 0 ) then
					{
						_garage = _garages select 0;
						_pos = getPos _garage;
						_dir = getDir _garage;

						_bbox = boundingBox _garage;
						_dx = abs(((_bbox select 1) select 0) - ((_bbox select 0) select 0));
						_dy = abs(((_bbox select 1) select 1) - ((_bbox select 0) select 1));

						if ( _dx > _dy ) then {_dir = _dir + 90;};

						_dir = [_dir, _dir + 180] select (random(1) < 0.5);

						_placed = true;
						_garages = _garages - [_garage];
						_exclude = _exclude + [_garage];
					}
					else
					{
						if ( count(_buildings) > 0 ) then
						{
							_building = _buildings select floor(random(count(_buildings)));
							_buildings = _buildings - [_building];
							_bbox = boundingBox _building;

							_p0 = _building modelToWorld [(_bbox select 0) select 0, (_bbox select 0) select 1, (_bbox select 0) select 2];
							_p1 = _building modelToWorld [(_bbox select 1) select 0, (_bbox select 0) select 1, (_bbox select 0) select 2];
							_p2 = _building modelToWorld [(_bbox select 1) select 0, (_bbox select 1) select 1, (_bbox select 0) select 2];
							_p3 = _building modelToWorld [(_bbox select 0) select 0, (_bbox select 1) select 1, (_bbox select 0) select 2];
							_sides = [[_p0, _p1], [_p1, _p2], [_p2, _p3], [_p3, _p0]];

							{
								_side = _x;
								_v = [_side select 1, _side select 0] call fVectorSubstract;
								_pos = [_side select 0, _v, 0.5] call fVectorAdd;

								_npos = _pos isFlatEmpty [(sizeOf _model), (sizeOf _model) * 2.0, 1.0, 5, 0, false];
								if ( count(_npos) > 0 ) exitWith
								{
									_pos = _npos;
									_dir = [_side select 0, _side select 1] call funcCalcAzimuth;
								};
							}forEach _sides;
						}
						else
						{
							_pos = [_placePos, 0, 500, false, objNull] call funcGetRandomPos;
						};
					};
				};
				_pos set [2,0];
				_trys = _trys + 1;
			};

			if ( (_pos select 0) != 0 || (_pos select 1) != 0 ) then
			{
				_vehicleArray = _vehicleArray + [[objNull, _type,_pos,_dir,false, _placed]];
			};
		};
	};

}forEach _towns;

_exclude = nil;

waitUntil {!isNil "crcti_kb_initServerDone"};
waitUntil {crcti_kb_initServerDone};
waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
waitUntil {!isNull mhqWest && !isNull mhqEast};

while {count(pvGameOver) == 0}do
{
	sleep 15;
	_humans = [];
	{
		if ( alive _x && isPlayer _x ) then
		{
			_humans = _humans + [_x];
		};
	}forEach playableUnits;

	{
		_line = _x;
		if ( str(_line) != "0" ) then
		{
			_obj = _line select 0;
			_type = _line select 1;
			_pos = _line select 2;
			_dir = _line select 3;
			_spawned = _line select 4;
			_clean = false;
			_placed = _line select 5;

			_mindist = 100000;
			{
				_d = _x distance _pos;
				if ( _d < _mindist) then {_mindist = _d;};
			}forEach _humans;

			if ( _mindist < CivilianSpawnDist && !_spawned ) then
			{
				if ( !_placed ) then
				{
					_res = [_type, 0, 0, 0, _pos, _dir, _si, -1, tempGroupCiv, "NONE", false, false] call funcAddUnit;
					_obj = _res select 0;
					_spawned = true;
					_placed = true;
				}
				else
				{
					_res = [_type, 0, 0, 0, [_pos select 0, _pos select 1, 100000], _dir, _si, -1, tempGroupCiv, "NONE", false, false] call funcAddUnit;
					_obj = _res select 0;
					_obj setDir _dir;
					_obj setPos _pos;
					_spawned = true;
				};
			};

			if ( _spawned && !isNull _obj && alive _obj) then
			{
				_pos = getPos _obj;
				_dir = getDir _obj;
			};

			if ( _mindist > CivilianSpawnDist*1.1 && _spawned ) then
			{
				if ( count(crew(_obj)) == 0 ) then
				{
					deleteVehicle _obj;
					_obj = objNull;
					_spawned = false;
				};
			};

			if ( _spawned && (isNull _obj || !alive _obj) ) then
			{
				_line = 0;
			}
			else
			{
				_line = [_obj,_type,_pos,_dir,_spawned, _placed];
			};

			_vehicleArray set [_forEachIndex, _line];
		};		
	}forEach _vehicleArray;

	_vehicleArray = _vehicleArray - [0];

};

