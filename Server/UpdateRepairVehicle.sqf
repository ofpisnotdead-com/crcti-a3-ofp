// args: [support, si]

_support = _this select 0;

_obj = objNull;
_object = objNull;
_repairTime = 75;
_repair = 1.0 / _repairTime;
_range = repairRange + 10;

if ( CRCTIDEBUG ) then { _repair = 1.0; };

_state = "update";
_sleep = 5;

while {_state != "finished"}do
{
	sleep _sleep;

	if (isNull _support || !alive _support) then
	{
		_state = "finished";
	}
	else
	{
		_sleep = 5;
		if (alive driver _support) then
		{
			_sleep = 1;
			_unit = driver _support;
			_group = group _unit;

			_si = -1;
			_gi = (groupMatrix select siwest) find _group;
			if ( _gi != -1 ) then
			{
				_si = siwest;
			}
			else
			{
				_gi = (groupMatrix select sieast) find _group;
				if ( _gi != -1 ) then
				{
					_si = sieast;
				};
			};

			if ( _si != -1 ) then
			{
				_list = repairableStructureMatrix select _si;
				_object = objNull;
				_type = -1;
				_distMin = 100000;

				{
					_obj =_x select 0;
					_mhqOnly = (structDefs select (_x select 2)) select sdOnlyMHQ;
					_isBuilding = _obj getVariable["building", false];

					if ( !(isNull _obj) && (!(_isBuilding) || !_mhqOnly) ) then
					{
						_objpos = getPos _obj;
						_supportpos = getPos _support;
						_supportpos = [_supportpos select 0,_supportpos select 1, _objpos select 2];
						_dist = (_supportpos distance _obj);

						if (_dist < _distMin && _dist < _range) then
						{
							_object = _obj;
							_type = _x select 2;
							_distMin = _dist;
						};
					};
				}foreach _list;

				_damage = [_object, _repair, _si, _gi] call funcRepairStructure;
				if ( !(_group in (groupAiMatrix select _si))) then
				{
					if ( _gi != -1 && _type != -1 ) then
					{
						[_damage, _si, _gi, _type] execVM "Server\Info\StructRepaired.sqf";
					};
					if ( _damage == 0 && _type != -1 ) then
					{
						[_si, _type] execVM "Server\Info\StructReady.sqf";
						primStructsPlaced = primStructsPlaced - [_object, objNull];
					};
				};
			};
		};
	};
};