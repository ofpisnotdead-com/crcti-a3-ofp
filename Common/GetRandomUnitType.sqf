// arguments: array
// array entry : [typeUnit, probability]
// return: type

private ["_type", "_tmptype", "_entry", "_trys"];

_tmptype = [];
_type = -1;
_trys = 0;

while {_type == -1 && _trys < 50 && (count _this) > 0}do
{
	_entry = _this select floor(random(count _this));

	if ( (_entry select 1) >= random(1.0) ) then
	{
		_type = _entry select 0;
	};

	_trys = _trys + 1;
};

_type