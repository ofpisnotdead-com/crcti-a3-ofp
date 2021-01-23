_message = _this select 1;
_vehicle = _this select 2;

if ( vehicle player == _vehicle ) then
{
	if ( _message != "" ) then
	{
		[_message, false, true, htVehicleMessage, true] call funcHint;
	};

	if ( count _this > 2 ) then
	{
		call (_this select 3);
	};
};
