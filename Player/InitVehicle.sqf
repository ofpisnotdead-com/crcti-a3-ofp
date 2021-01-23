// args: [vehicle, type, si]
_vehicle = _this select 0;
_type = _this select 1;
_si = _this select 2;
_gi = _this select 3;

_freeMarkers = freeVehicleMarkers select _si;
_mapping = vehicleMarkerMapping select _si;

_index = 0;
{
	if ( isNull(_x select 0) || (!alive(_x select 0) && (_x select 0) != mhqWest && (_x select 0) != mhqEast) ) then
	{
		if (!((_x select 1) in _freeMarkers)) then
		{
			_freeMarkers set [count _freeMarkers, _x select 1];
		};

		_mapping set [_index, 0];
	};

	_index=_index+1;
}foreach _mapping;
_mapping = _mapping - [0];

_idMarker = -1;
if (count _freeMarkers > 0) then
{
	_idMarker = _freeMarkers select 0;
};

if (_idMarker != -1) then
{
	_freeMarkers = _freeMarkers - [_idMarker];
	_mapping set [count _mapping, [_vehicle, _idMarker]];
	_marker = format ["%1 Vehicle %2", str(_si), _idMarker];
	_markerType = (unitDefs select _type) select udMarkerType;
	_marker setMarkerTypeLocal _markerType;

	if ( _markerType == SQbike ) then {_marker setMarkerSizeLocal [0.5,0.5];};
	if ( _markerType == SQCar ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == SQTruck ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == SQBoat ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == SQAPC ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == sqTank ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == sQHeli ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == sQPlane ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == sQSupport ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == SQFuel ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == SQMHQ ) then {_marker setMarkerSizeLocal [1,1];};
	if ( _markerType == sQAA ) then {_marker setMarkerSizeLocal [1,1];};

};

freeVehicleMarkers set [_si, _freeMarkers];
vehicleMarkerMapping set [_si, _mapping];

if (_vehicle isKindOf "Air" ) then
{
	_vehicle addAction ["Set Flight Altitude", "Player\ActionSetFlightAltitude.sqf", [], 3, false, false, "", "_this == driver _target"];
	_vehicle addAction ["Eject Yourself", "Player\ActionEject.sqf", [], 3, false, false, "", "vehicle _this == _target"];
};

_vehicle addAction ["Eject Cargo", "Player\ActionEjectCargo.sqf", [], 3, false, false, "", "_this == driver _target"];