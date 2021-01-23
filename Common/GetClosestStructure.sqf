// returns closest alive structure of specified type and side
// args: [pos, si, structType]
// return: [struct, distance]

private ["_struct", "_distMin", "_structs", "_dist"];

_struct = objNull;
_distMin = 1000000000;
_structs = (structMatrix select (_this select 1)) select (_this select 2);

{
	if ( !(isNull _x) && (alive _x) ) then
	{
		_dist = (_this select 0) distance _x;
		if (_distMin > _dist) then
		{
			_struct = _x;
			_distMin = _dist;
		};
	};	
} foreach _structs;

[_struct, _distMin]