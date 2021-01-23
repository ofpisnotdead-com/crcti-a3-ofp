_weather = _this select 0;

if ( !isServer && count _weather == 4 && count(pvGameOver) == 0) then
{
	_tolerance = 0.025;

	if ( isNil "LastSimulWeatherSync" ) then
	{
		LastSimulWeatherSync = -1;
	};

	_overcast = _weather select 0;
	_fog = _weather select 1;
	_rain = _weather select 2;
	_w = _weather select 3;
	_wind = [_w select 0, _w select 1, true];

	//diag_log format["weather: %1 %2 %3 %4", overcast, _overcast, abs(overcast - _overcast), LastSimulWeatherSync];

	if ( abs(overcast - _overcast) > _tolerance ) then
	{
		skipTime -24;
		86400 setOvercast _overcast;
		skipTime 24;		
	};

	if ( abs(LastSimulWeatherSync - overcast) > _tolerance) then
	{
		LastSimulWeatherSync = overcast;
		sleep 1.0;
		simulWeatherSync;
	};

	if ( overcast < _overcast ) then
	{
		0 setOverCast 1.0;
	}
	else
	{
		0 setOverCast 0.0;
	};

	weatherSyncDelay setFog _fog;
	weatherSyncDelay setRain _rain;
	setWind _wind;
};
