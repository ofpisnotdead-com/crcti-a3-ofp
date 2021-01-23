// args: [vehicle]

_vehicle = _this Select 0;
_pos = getPos _vehicle;
_dir = getDir _vehicle;

if ( _pos select 2 < 15 ) then
{
	_vehicle setVelocity [0,0,0];
	_vehicle setPos [_pos select 0, _pos select 1, 0];
	_vehicle setVectorUp (surfaceNormal _pos);
	_vehicle setDir _dir;
};
