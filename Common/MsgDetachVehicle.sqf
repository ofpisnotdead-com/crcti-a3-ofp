_value = _this select 0;
_tug = _value select 0;
_slot = _value select 1;

if ( !(isNull _tug) ) then
{
	_index = 0;
	_count = count vehicleAttached;
	_found = false;

	while {_index < _count && !_found} do 
	{ 
		if (_tug == ((vehicleAttached select _index) select tsTug)) then 
		{ 
			((vehicleAttached select _index) select tsTugged) set [_slot, objNull]; 
			_found = true; 
		} 
		else 
		{ 
			_index = _index + 1; 
		}; 
	};

};