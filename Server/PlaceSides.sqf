_startWest = [];
_startEast = [];

if ( fixedStartPos == 0 ) then
{
	_s = [startLocWest, startLocEast];
	_r = random(1);

	_startWest = _s select (_r < 0.5);
	_startEast = _s select (_r >= 0.5);

}
else
{
	_startpositions = [];
	_startlocs = [];

	if ( fixedStartPos == 1 ) then
	{
		_startlocs = startLocsAirfields;
	}
	else
	{
		_startlocs = startLocsRandom;
	};

	_count = count _startlocs;
	_radiusfac = 1.5;

	while {count(_startpositions) < 4}do
	{
		for [ {_j=0}, {_j<_count}, {_j=_j+1}] do
		{
			_x = _startlocs select _j;

			_nextTownDist = ([getPos _x, [siWest,siEast,siRes], []] call funcGetClosestTown) select 1;

			if ( ((getPos _x) distance posCenter) < (townsRadius * _radiusfac) && _nextTownDist < (1500*_radiusFac)) then
			{
				_startpositions = _startpositions + [_x];
			};

		};
		_radiusfac = _radiusfac + 1.0;
	};

	if ( CRCTIDEBUG ) then
	{
		{
			_marker = format["StartPos_%1", _forEachIndex];
			createMarker [_marker, getPos _x ];
			_marker setMarkerType "mil_flag";
			_marker setMarkerColor "colorRed";
		}forEach _startpositions;
	};

	_startPos = [_startPositions select 0, _startPositions select 0];
	_startPosTuples = [];

	{
		_pos1 = _x;
		{
			_pos2 = _x;
			if ( _pos1 != _pos2 ) then
			{
				_startPosTuples = _startPosTuples + [[_pos1, _pos2, _pos1 distance _pos2]];
			};
		}forEach _startPositions;
	}forEach _startPositions;

	_startPosTuples = [2, true, _startPosTuples] call funcSort;

	// Completely Random (for Airfields and Random)
	_startIdx = 0;
	_countIdx = floor(random(count(_startPosTuples)));

	// Near
	if ( fixedStartPos == 3 ) then
	{
		_startIdx = 0;
		_countIdx = floor(random(count(_startPosTuples) * 0.33));
	};
	// Medium
	if ( fixedStartPos == 4 ) then
	{
		_startIdx = floor(count(_startPosTuples) * 0.33);
		_countIdx = floor(random(count(_startPosTuples) * 0.33));
	};
	// Far
	if ( fixedStartPos == 5 ) then
	{
		_startIdx = floor(count(_startPosTuples) * 0.66);
		_countIdx = floor(random(count(_startPosTuples) * 0.33));
	};
	// Maximum separation
	if ( fixedStartPos == 6 ) then
	{
		_startIdx = count(_startPosTuples) - 1;
		_countIdx = 0;
	};

	_startPos = _startPosTuples select (_startIdx + _countIdx);

	_r = random(1);

	_startWest = _startPos select (_r < 0.5);
	_startEast = _startPos select (_r >= 0.5);

};

_posWest = getPos _startWest;
_dirWest = getDir _startWest;
[utMHQWest, 0, 0, 0, _posWest, _dirWest, siWest, -1, tempGroupWest, "NONE",false, false] call funcAddUnit;

_posEast = getPos _startEast;
_dirEast = getDir _startEast;
[utMHQEast, 0, 0, 0, _posEast, _dirEast, siEast, -1, tempGroupEast, "NONE",false, false] call funcAddUnit;

[_posWest, _dirWest, _posEast, _dirEast] execVM "Server\PlaceStartVehicles.sqf";

{
	deleteVehicle _x;
}forEach ([startLocWest, startLocEast] + startLocsAirfields + startLocsRandom) - [objNull];
