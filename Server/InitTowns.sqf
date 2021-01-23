_funcCenterRadius = {
	// calc map center and radius by using town positions
	_c = count towns;

	_posX = 0;
	_posY = 0;
	{
		_posX = _posX + ((getPos (_x select tdFlag)) select 0);
		_posY = _posY + ((getPos (_x select tdFlag)) select 1);
	}foreach towns;

	posCenter = [_posX/_c, _posY/_c, 0];

	townsRadius = 0;

	{
		_radius = (_x select tdFlag) distance posCenter;

		if ( _radius > townsRadius ) then
		{
			townsRadius = _radius;
		};
	}forEach towns;
};

_origFlags = [];
{
	_origFlags = _origFlags + [_x select 0];
}forEach towns;

TownLine = [];

_OneFourthTowns = ceil((count towns) / 4);

// Place Towns Randomly
// Random Placement
if ( ClusterCount == 0 ) then
{
	while {(count towns) > TownCount}do
	{
		_i = floor(random(count towns));
		towns set [_i,objNull];
		towns = towns - [objNull];
	};
};
// Clustered
if ( ClusterCount > 0 && ClusterCount < 5 ) then
{
	if ( ClusterCount > TownCount ) then {ClusterCount = TownCount;};

	_clusters = [];
	_except = [];

	while {count _clusters < ClusterCount}do
	{
		_clusterIdx = floor(random(count Towns));
		if ( !(_clusterIdx in _except)) then
		{
			_clusterTown = Towns select _clusterIdx;
			_clusters = _clusters + [_clusterTown];
			_except = _except + [_clusterIdx];
		};
	};

	_clusterTowns = + _clusters;
	_i=0;
	while {(count _clusterTowns) < TownCount && (count _clusterTowns) < (count Towns)}do
	{
		_pivotIdx = _i % ClusterCount;
		_addIdx = ([getPos((_clusters select _pivotIdx) select tdFlag), [siWest,siEast,siRes], _except] call funcGetClosestTown) select 2;

		if ( _addIdx != -1 && !(_addIdx in _except)) then
		{
			_except = _except + [_addIdx];
			_addTown = towns select _addIdx;
			_clusterTowns = _clusterTowns + [_addTown];
		};

		_i = _i + 1;
	};

	towns = _clusterTowns;
};

// Circular
if ( ClusterCount == 5 ) then
{
	if ( TownCount == (count towns)) then {TownCount = _OneFourthTowns;};

	_newTowns = [];
	_except = [];
	call _funcCenterRadius;
	_c = [posCenter, 0, townsRadius * 0.25, false, objNull] call funcGetRandomPos;
	_r = townsRadius * 0.25 + townsRadius * 0.25 * (TownCount/count(towns));

	_angle = random(360);
	_step = 360 / TownCount;

	for [ {_i=0}, {_i<TownCount}, {_i=_i+1}] do
	{
		_v = [0,1,0];
		_v = [_v, _angle] call fVectorRot;
		_p = [_c, _v, _r] call fVectorAdd;

		_addIdx = ([_p, [siWest,siEast,siRes], _except] call funcGetClosestTown) select 2;

		if ( _addIdx != -1 && !(_addIdx in _except)) then
		{
			_except = _except + [_addIdx];
			_addTown = towns select _addIdx;
			_newTowns = _newTowns + [_addTown];
			TownLine = TownLine + [getPos(_addTown select tdFlag)];
		};

		_angle = _angle + _step;
	};

	towns = _newTowns;
};

// Axis
if ( ClusterCount == 6 ) then
{
	if ( TownCount == (count towns)) then {TownCount = _OneFourthTowns;};

	_newTowns = [];
	_except = [];
	call _funcCenterRadius;

	_c = [posCenter, 0, townsRadius * 0.25, false, objNull] call funcGetRandomPos;
	_r = townsRadius * 0.25 + townsRadius * 0.75 * (TownCount/count(towns));

	_angle = random(360);

	_v = [0,1,0];
	_v = [_v, _angle] call fVectorRot;

	_p0 = [_c, _v, -_r] call fVectorAdd;
	_p1 = [_c, _v, _r] call fVectorAdd;

	TownAxis = [_p0,_p1];
	publicVariable "TownAxis";

	_dist = _p0 distance _p1;
	_step = _dist / TownCount;

	for [ {_i=0}, {_i<TownCount}, {_i=_i+1}] do
	{
		_f = _step * _i;
		_p = [_p0, _v, _f] call fVectorAdd;

		_addIdx = ([_p, [siWest,siEast,siRes], _except] call funcGetClosestTown) select 2;

		if ( _addIdx != -1 && !(_addIdx in _except)) then
		{
			_except = _except + [_addIdx];
			_addTown = towns select _addIdx;
			_newTowns = _newTowns + [_addTown];
		};

		_angle = _angle + _step;
	};

	towns = _newTowns;

};

// String
if ( ClusterCount == 7 ) then
{
	if ( TownCount == (count towns)) then {TownCount = _OneFourthTowns;};

	_newTowns = [];
	_except = [];

	_t0idx = floor(random(count(towns)));
	_t0 = towns select _t0idx;
	_p0 = getPos(_t0 select tdFlag);
	_except = [_t0idx];

	_t1idx = ([_p0, [siWest,siEast,siRes], _except] call funcGetClosestTown) select 2;
	_t1 = towns select _t1idx;
	_p1 = getPos(_t1 select tdFlag);

	_except = [_t0idx,_t1idx];
	_newTowns = [_t0,_t1];
	TownLine = [_p0, _p1];

	_v0 = [_p1,_p0] call fVectorSubstract;
	_dir0 = _v0 call fVectorNormalize;

	_nextIdx = -2;
	while {count(_newTowns) < TownCount && _nextIdx != -1}do
	{
		_except2 = + _except;
		_mindist = 10000000000;
		_minangle = 1000000;
		_nextIdx = -1;
		_ps = [];
		_dir = [];
		_newdir = [];
		_newps = [];
		_searchIdx = -1;

		for [ {_i=0}, {_i<5}, {_i=_i+1}] do
		{
			_searchidx = ([_p1, [siWest,siEast,siRes], _except2 ] call funcGetClosestTown) select 2;
			if ( _searchIdx != -1 ) then
			{
				_except2 = _except2 + [_searchidx];
				_ps = getPos((towns select _searchidx) select tdFlag);

				_v = [_ps, _p1] call fVectorSubstract;
				_dir = _v call fVectorNormalize;

				_dist = _p1 distance _ps;
				_angle = [_dir0, _dir] call fVectorAngle;

				_d = ([_dir0, _dir] call fVectorSubstract) call fVectorLength;
				if ( _d > 1.0 ) then {_angle = _angle + 90;};

				//diag_log format["%1 %2 %3 %4 %5 %6 %7", str(_ps), str(_v), str(_dir), str(_dist), str(_angle), _searchidx, str(towns select _searchidx)];

				if ( _dist < _mindist && _angle < _minangle ) then
				{
					_mindist = _dist;
					_minangle = _angle;
					_nextidx = _searchidx;
					_newdir = _dir;
					_newps = _ps;
				};
			};
		};

		if ( _nextIdx != -1 ) then
		{
			_dir0 = _newdir;
			_p1 = _newps;
			_except = _except + [_nextIdx];
			_newTowns = _newTowns + [towns select _nextIdx];
			TownLine = TownLine + [_p1];
		};

	};

	towns = _newTowns;
};

// Even
if ( ClusterCount == 8 ) then
{
	_newTowns = [];

	_minX = 1000000;
	_minY = 1000000;
	_maxX = 0;
	_maxY = 0;

	{
		_pos = getPos(_x select tdFlag);
		_px = _pos select 0;
		_py = _pos select 1;

		if ( _minX > _px ) then {_minX = _px;};
		if ( _minY > _py ) then {_miny = _py;};
		if ( _maxX < _px ) then {_maxX = _px;};
		if ( _maxY < _py ) then {_maxY = _py;};

	}forEach towns;

	_steps = ceil(sqrt(TownCount));
	_stepX = (_maxX - _minX) / _steps;
	_stepY = (_maxY - _minY) / _steps;

	_except = [];

	for[ {_y=_minY}, {_y<_maxY}, {_y=_y+_stepY}] do
	{
		for[ {_x=_minX}, {_x<_maxX}, {_x=_x+_stepX}] do
		{
			_pos = [_x + _stepX*0.5,_y + _stepY*0.5,0];

			if ( count(_newTowns) < TownCount ) then
			{

				_addIdx = ([_pos, [siWest,siEast,siRes], _except] call funcGetClosestTown) select 2;

				if ( _addIdx != -1 && !(_addIdx in _except)) then
				{
					_except = _except + [_addIdx];
					_addTown = towns select _addIdx;
					_newTowns = _newTowns + [_addTown];
				};
			};

		};
	};

	towns = _newTowns;

};

//diag_log str(towns);

_newFlags = [];
{
	_newFlags = _newFlags + [_x select 0];
}forEach towns;

{
	if ( !(_x in _newFlags) ) then {deleteVehicle _x;};
}forEach _origFlags;

{
	_x set [tdHash, (_x select tdName) call funcStringHash];
}forEach towns;

towns = [tdHash, true, towns] call funcSortStrings;

call _funcCenterRadius;

if ( townsRadius < 1500 ) then
{
	townsRadius = 1500;
};

//diag_log format["Towns Center: %1\nTowns Radius: %2", str(posCenter), str(townsRadius)];

publicVariable "towns";
publicVariable "posCenter";
publicVariable "townsRadius";
publicVariable "TownLine";

TakeHoldTownsArray = [[],[]];
PatrolTownsArray = [];

_triggerList = [];
for [ {_i=0}, {_i<count(towns)}, {_i=_i+1}] do
{
	(TakeHoldTownsArray select siWest) set [_i, []];
	(TakeHoldTownsArray select siEast) set [_i, []];
	PatrolTownsArray set [_i, []];

	_town = towns select _i;

	_town set [tdState, "init"];
	_town set [tdCivState, "init"];
	_town set [tdMinDist, [-1,-1]];
	_town set [tdWestTownGroupStarted, false];
	_town set [tdEastTownGroupStarted, false];

	_flag = _town select tdFlag;
	_flag SetFlagTexture "\a3\data_f\Flags\flag_green_co.paa";
	_pos = getPos _flag;

	if ( ResAmmoCratesEnabled > 0 ) then
	{
		_crate = "Box_IND_WpsSpecial_F" createVehicle _pos;
		[_crate] execVM "Server\InitAmmoBox.sqf";
	};

	// add Townsidechange Trigger
	_trig = createTrigger ["EmptyDetector", _pos];
	_trig setTriggerArea [flagRadius, flagRadius, 0, false];
	_trig setTriggerActivation ["ANY", "PRESENT", false];
	_trig setTriggerStatements ["this","",""];
	_triggerList = _triggerList + [_trig];
	
};

_nul = _triggerList execVM "Server\UpdateTowns.sqf";

for [ {_i=0}, {_i<resPatrolGroups}, {_i=_i+1}] do
{
	_nul = [] execVM "Server\UpdateResPatrolGroup.sqf";
};

