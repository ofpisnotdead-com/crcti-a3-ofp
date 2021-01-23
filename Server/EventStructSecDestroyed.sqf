// args [[object, ...], si]

_object = (_this select 0) select 0;
_si = _this select 1;

_delay = 10;

{
	_objects = _x select 0;
	
	if ( _object in _objects ) exitWith
	{
		{_x setDamage 1;}foreach _objects;		
		structuresServer = structuresServer - [_x];
	};

}forEach structuresServer;

sleep _delay;
deleteVehicle _object;
