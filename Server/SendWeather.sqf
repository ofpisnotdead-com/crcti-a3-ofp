_weatherupdate = time;

while {true}do
{
	if ( time >= _weatherupdate ) then
	{
		pvCurrentWeather = [overcast, fog, rain, wind];
		publicVariable "pvCurrentWeather";
		_weatherupdate = time + weatherSyncDelay;		
	};
	
	sleep weatherSyncDelay;
};