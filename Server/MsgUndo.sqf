// args: [_si,_gi]

if ( isServer ) then
{
	pvUndo = [];

	_si = (_this select 0) select 0;
	_gi = (_this select 0) select 1;

	_list = (undoList select _si) select _gi;
	_list = _list - [0];
	_count = count _list;

	if ( _count > 0 ) then
	{
		_entry = _list select (_count - 1);

		if ( count _entry > 0) then
		{
			_list set [_count - 1, 0];
			_list = _list - [0];
			(undoList select _si) set [_gi, _list];

			_type = _entry select 0;
			_objects = _entry select 1;
			_cost = (structDefs select _type) select sdCost;

			if ( _si == siWest ) then
			{
				westGuns = westGuns - _objects;
				westWalls = westWalls - _objects;
			};

			if ( _si == siEast ) then
			{
				eastGuns = eastGuns - _objects;
				eastWalls = eastWalls - _objects;
			};

			_fired = false;
			{
				_f = _x getVariable "HasBeenFired";

				if ( !isNil "_f" && _f) then
				{
					_fired = true;
				};

				deleteVehicle _x;
			}foreach _objects;

			_nul = [_type, _si] execVM "Server\Info\StructUndone.sqf";

			if ( ! _fired ) then
			{
				[_si, _gi, -_cost] call funcMoneySpend;
			};
		};
	};

};