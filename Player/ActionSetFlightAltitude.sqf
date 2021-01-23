// args: [vehicle, unit, idAction]

_vehicle = _this select 0;
_unit = _this select 1;

if (alive _vehicle) then
{
	if (_unit == driver _vehicle) then
	{
		[_vehicle, _unit] exec "Player\OpenSetFlightAltitudeDialog.sqs";
	};
}
else
{
	_vehicle removeAction (_this select 2);
};
