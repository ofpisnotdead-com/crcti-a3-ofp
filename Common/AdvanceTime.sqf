// setDate [year, month, day, hour, minute]

_lastsent = time;
_lastt = time;

if ( isServer && isNull player ) then
{
	while {true}do
	{
		_dt = time - _lastt;
		_lastt = time;

		if ( (time - _lastsent) > 120 ) then
		{
			_lastsent = time;
			pvDate = date;
			[pvDate] call MsgSetDate;
			publicVariable "pvDate";
		};

		if ( skipTimeFactor != 1 ) then
		{
			skipTime ((_dt*SkipTimeFactor)/3600);
		};

		sleep 10;
	};
}
else
{
	while {true && (skipTimeFactor != 1)}do
	{
		_dt = time - _lastt;
		_lastt = time;
		skipTime ((_dt*SkipTimeFactor)/3600);
	};
};

