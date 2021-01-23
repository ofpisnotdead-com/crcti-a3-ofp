// args: [message, vehicle, script]

if ( count _this > 2 ) then
{
	[mtVehicleMessage, _this select 0, _this select 1, _this select 2] execVM "Server\Info\SendInfoMsg.sqf";
}
else
{
	[mtVehicleMessage, _this select 0, _this select 1] execVM "Server\Info\SendInfoMsg.sqf";
};
