_force = _this select 0;

_prev = "";
_next = "";
_effect = objNull;

while {true}do
{
	if ( ((dayTime > 6) && (dayTime < 18)) || _force == 1 ) then
	{
		_next = "BIS_Effect_Day";

	};

	if ( (dayTime <= 6) || (dayTime >= 18) || _force == 2 ) then
	{
		_next = "BIS_Effect_MovieNight";
	};

	if ( _next != _prev ) then
	{
		if ( !isNull _effect ) then
		{
			deleteVehicle _effect;
		};

		_effect = logicGroup createUnit [_next,[2,2,2], [], 0, "NONE"];
		diag_log format["%1 %2", _next, str(units logicGroup)];

		_prev = _next;
	};

	sleep 60;
};
