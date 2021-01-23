// args: [pos, sound]
_pvSay3D = _this select 0;

_object = _pvSay3D select 0;
_pos = _pvSay3D select 1;
_sound = _pvSay3D select 2;
_maxDist = _pvSay3D select 3;
_delete = false;

if ( !isNull Player ) then
{
	if ( isNull _object ) then
	{
		_object = "Land_HelipadEmpty_F" createVehicleLocal _pos;
		_delete = true;
	};
	
	_object say3D [_sound, _maxDist, 1];
	sleep 120;

	if ( _delete ) then
	{
		deleteVehicle _object;
	};
};