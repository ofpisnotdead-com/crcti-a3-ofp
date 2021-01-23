private ["_w", "_t", "_overcast", "_fog", "_rain", "_wind"];

_w = _this select 0;

if ( count(_w) == 5 ) then
{
	_t = _w select 0;

	_overcast = _w select 1;
	_fog = _w select 2;
	_rain = _w select 3;
	_wind = _w select 4;

	_t setOvercast _overcast;
	_t setFog _fog;
	_t setRain _rain;
	setWind _wind;
};
