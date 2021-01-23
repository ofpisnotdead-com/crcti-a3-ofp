// arguments: [ pos, siList, exceptList]
// returns: [townDesc, distance, indexTown]

private ["_x", "_maxDistance", "_farthestTown", "_pos", "_distance", "_indexTown", "_index"];

_maxDistance = 0;
_farthestTown = [];
_indexTown = -1;

_index = 0;

{
	_pos = getPos (_x select tdFlag);
	_distance = _pos distance (_this select 0);

	if ( _distance > _maxDistance && (_x select tdSide) in (_this select 1) && !(_index in (_this select 2)) ) then
	{
		_farthestTown = _x;
		_maxDistance = _distance;
		_indexTown = _index
	};
	_index = _index + 1;
}forEach towns;

[_farthestTown, _maxDistance, _indexTown]