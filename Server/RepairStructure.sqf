// args: [object, value, si]
// return: newValue or -1 if object not found in array

private ["_object", "_value", "_si", "_list", "_res", "_index", "_count", "_entry", "_entryObject", "_type", "_new", "_pos", "_dir", "_model", "_vect", "_posCorrect"];

_object = _this select 0;
_value = _this select 1;
_si = _this select 2;
_gi = _this select 3;

_list = repairableStructureMatrix select _si;
_list = _list - [0];

_res = -1;

_index = 0;
_count = count _list;

while {_index < _count && _res == -1}do
{
	_entry = _list select _index;
	_entryObject = _entry select 0;
	if (isNull _entryObject) then
	{
		_list set [_index, 0];
	}
	else
	{
		if (_object == _entryObject) then
		{
			_value = (_entry select 1) - _value;
			if (_value < 0) then {_value = 0};					
			_entry set [1, _value];
			_res = _value;
			if (_value < 0.01 ) then
			{
				_object setDamage 0;
				_type = _entry select 2;
				_nul = [_object, _type, _si, _gi] execVM "Server\ReplacePrimStruct.sqf";
				_list set [_index, 0];
			};
		};
	};
	_index = _index + 1;
};

_list = _list - [0];
repairableStructureMatrix set [_si, _list];
publicVariable "repairableStructureMatrix";

_res