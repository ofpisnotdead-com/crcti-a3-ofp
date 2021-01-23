// args: si (e.g. siWest)
// return: [gi1, gi2, ...]

private ["_ids", "_index"];

_ids = [];

if ( _this == siWest || _this == siEast ) then
{
	_index = 0;
	{
		if (_x in (groupAiMatrix select _this)) then
		{
			_ids set [count _ids, _index];
		};
		_index = _index + 1;
	}foreach (groupMatrix select _this);
};

_ids