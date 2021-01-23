_pvRearmVehicle = _this select 0;

_veh = _pvRearmVehicle select 0;
_scripts = _pvRearmVehicle select 1;
_type = _pvRearmVehicle select 2;
_si = _pvRearmVehicle select 3;

_veh setVehicleAmmo 1.0;

if((count _scripts) > 0 && _type != -1 ) then
{
	_script = format ["Server\%1",(_scripts select 0)];
	[ _veh, _type, _si] execVM _script;
};

reload _veh;

