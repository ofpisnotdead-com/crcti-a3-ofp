// Quicksort
// args: [ nEntrySortIndex, bAsc, aEntries ] (e.g.  [0, false, [[3,"Cleanrock"],[5,"Ernst"]] ])
// return: [aEntriesSorted] (e.g. [[5,"Ernst"],[3,"Cleanrock"]])

private ["_indexSort", "_bAsc", "_entries", "_count", "_res", "_pivotidx", "_pivot", "_left", "_right", "_entry", "_idxl", "_idxr"];

_indexSort = _this select 0;
_bAsc = _this select 1;
_entries = _this select 2;
_count = count _entries;
_res = [];

if ( _count > 1 ) then
{
	_pivotidx = round(_count / 2);
	_pivot = _entries select _pivotidx;

	_left = [];
	_right = [];

	{
		_entry = _x;
		if ( _forEachIndex != _pivotidx ) then
		{
			_idxl = _entry select _indexSort;
			_idxr = _pivot select _indexSort;
			if ( ((_idxl > _idxr) && _bAsc) || ((_idxl < _idxr) && !_bAsc)) then
			{
				_right = _right + [_entry];
			}
			else
			{
				_left = _left + [_entry];
			};
		};

	}forEach _entries;

	_right = [_indexSort, _bAsc, _right] call funcSort;
	_left = [_indexSort, _bAsc, _left] call funcSort;

	_res = _left + [_pivot] + _right;
}
else
{
	_res = _entries;
};

_res