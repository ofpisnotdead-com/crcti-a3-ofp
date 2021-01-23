GarbagePending = [];
GarbageList = [];
_emptyGroups = [];

while {true}do
{	
	_maxGarbageCount = maxGarbageCount;
	if ( averageFPS < 20 ) then {_maxGarbageCount = maxGarbageCount * 0.5;};
	if ( averageFPS < 15 ) then {_maxGarbageCount = maxGarbageCount * 0.25;};
	if ( averageFPS < 10 || time < cleanTime) then {_maxGarbageCount = 0;};

	{
		if ( count(units _x) == 0 && !(_x in _emptyGroups)) then
		{
			_x setVariable ["EmptyTime", time + 240];
			_emptyGroups = _emptyGroups + [_x];
		};
		if ( count(units _x) > 0 && (_x in _emptyGroups)) then
		{
			_x setVariable ["EmptyTime", nil];
			_emptyGroups = _emptyGroups - [_x];
		};
	}forEach (allGroups - [logicGroup, tempGroupWest, tempGroupEast, tempGroupCiv, tempGroupRes, workerGroupWest, workerGroupEast] - (groupMatrix select siWest) - (groupMatrix select siEast));

	//diag_log str(allGroups - [logicGroup, tempGroupWest, tempGroupEast, tempGroupCiv, tempGroupRes, workerGroupWest, workerGroupEast] - (groupMatrix select siWest) - (groupMatrix select siEast));
	
	{
		if ( time > (_x getVariable ["EmptyTime", time + 240]) && (count units _x) == 0 ) then				
		{
			[_x] call funcDeleteGroup;
		};
	}forEach _emptyGroups;
	
	_emptyGroups = _emptyGroups - [grpNull];
	//diag_log str(_emptyGroups);
	
	_humans = [];
	{
		if ( alive _x && isPlayer _x ) then
		{
			_humans = _humans + [_x];
		};
	}forEach playableUnits;

	{
		_pending = _x;
		_obj = _x select 0;
		_t = _x select 1;

		if ( time > _t || (!(_obj isKindOf "Man") && (time < cleanTime) )) then
		{
			if ( !(_obj in GarbageList)) then
			{
				GarbageList = GarbageList + [_obj];
			};
			GarbagePending set [_forEachIndex, objNull];
		};
	}forEach GarbagePending;
	GarbagePending = GarbagePending - [objNull];

	GarbageList = GarbageList - [objNULL];

	for[ {_i=0}, {_i<count(GarbageList)}, {_i=_i+1}] do
	{
		_trash = GarbageList select _i;
		_dist = 1000000;
		
		if ( (count(GarbageList) - _i) < _maxGarbageCount ) then
		{
			{
				_player = _x;
				_d = _player distance _trash;

				if ( _d < _dist ) then {_dist = _d};
			}forEach _humans;
		};

		if ( _dist > GarbageDeleteDist && !(_trash in playableUnits) ) then
		{
			if ( count(crew _trash) > 0 ) then
			{
				{
					unassignVehicle _x;
				}forEach crew _trash;
			};

			_trashPos = position _trash;

			deleteVehicle _trash;
			GarbageList set[_i, objNull];
		};

	};

	GarbageList = GarbageList - [objNull];

	_allDead = allDead - [mhqWest] - [mhqEast];
	{
		[_x, deleteItemDelay] call funcMoveToGarbage;
	}forEach _allDead;

	{
		_type = _x;
		_delay = 0;
		if ( _type in itemTrash ) then {_delay = deleteItemDelay;};

		_list = allMissionObjects _type;
		{
			[_x, _delay] call funcMoveToGarbage;
		}forEach _list;
	}forEach (specialTrash + itemTrash);

	if ( time > cleanTime ) then
	{
		sleep 30 + random(30);
	};
};