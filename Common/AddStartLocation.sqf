_location = _this select 0;
_type = _this select 1;

if ( isNil "startLocsRandom" ) then {startLocsRandom = [];};
if ( isNil "startLocsAirfields" ) then {startLocsAirfields = [];};

if ( isNil "startLocWest" ) then {startLocWest = objNull;};
if ( isNil "startLocEast" ) then {startLocEast = objNull;};

if ( _type == "RANDOM" ) then
{
	startLocsRandom = startLocsRandom + [_location];
};

if ( _type == "AIRFIELD" ) then
{
	startLocsAirfields = startLocsAirfields + [_location];
};

if ( _type == "WEST" ) then
{
	startLocWest = _location;
};

if ( _type == "EAST" ) then
{
	startLocEast = _location;
};