// Quicksort
// args: [ nEntrySortIndex, bAsc, aEntries ] (e.g.  [0, false, [[3,"Cleanrock"],[5,"Ernst"]] ])
// return: [aEntriesSorted] (e.g. [[5,"Ernst"],[3,"Cleanrock"]])

private ["_indexSort", "_bAsc", "_entries", "_count", "_res", "_pivotidx", "_pivot", "_left", "_right", "_entry", "_strl", "_strr", "_comp", "_fStringComp"];

_indexSort = _this select 0;
_bAsc = _this select 1;
_entries = _this select 2;
_count = count _entries;
_res = [];

_fStringComp = {

private["_res", "_str0", "_str1", "_pos", "_c0", "_c1", "_l0", "_l1"];

	_pos = 0;
	_res = 2;
	_str0 = _this select 0;
	_str1 = _this select 1;
	_l0 = count(_str0);
	_l1 = count(_str1);

	while {_res == 2}do
	{
		_c0 = 0;
		if ( _pos < _l0 ) then
		{
			_c0 = _str0 select _pos;
		};

		_c1 = 0;
		if ( _pos < _l1 ) then
		{
			_c1 = _str1 select _pos;
		};

		if ( _c0 > _c1 ) then
		{
			_res = 1;
		};
		if ( _c0 < _c1 ) then
		{
			_res = -1;
		};

		if ( _c0 == _c1) then
		{
			if ( _l0 > _pos || _l1 > _pos ) then
			{
				_pos = _pos + 1;
			}
			else
			{
				_res = 0;
			};
		};
	};

	_res
};

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
			_strl = _entry select _indexSort;
			_strr = _pivot select _indexSort;

			_comp = [_strl, _strr] call _fStringComp;

			if ( ((_comp > 0) && _bAsc) || ((_comp < 0) && !_bAsc)) then
			{
				_right = _right + [_entry];
			}
			else
			{
				_left = _left + [_entry];
			};
		};

	}forEach _entries;

	_right = [_indexSort, _bAsc, _right] call funcSortStrings;
	_left = [_indexSort, _bAsc, _left] call funcSortStrings;

	_res = _left + [_pivot] + _right;
}
else
{
	_res = _entries;
};

_res