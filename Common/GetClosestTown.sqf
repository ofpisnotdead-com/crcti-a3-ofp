// arguments: [ pos, siList, exceptList]
// returns: [townDesc, distance, indexTown]

private ["_x", "_minDistance", "_closestTown", "_pos", "_distance", "_indexTown", "_index"];

_minDistance = 1000000000;
_closestTown = [];
_indexTown = -1;

_index = 0;

{
	_pos = getPos (_x select tdFlag);
	_distance = _pos distance (_this select 0);

	if ( _distance < _minDistance && (_x select tdSide) in (_this select 1) && !(_index in (_this select 2)) ) then
	{
		_closestTown = _x;
		_minDistance = _distance;
		_indexTown = _index
	};
	_index = _index + 1;
}forEach towns;

[_closestTown, _minDistance, _indexTown]