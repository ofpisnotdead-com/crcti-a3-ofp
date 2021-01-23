// args: [vehicle, boat, index, slot, gi, si]

_vehicle = _this select 0;
_tug = _this select 1;
_tugindex = _this select 2;
_tugslot = _this select 3;
_gi = _this select 4;
_si = _this select 5;

_attachDir = 0;
_attachDist = 0;
if (_tugslot == tsCenter) then {_attachDir = -180; _attachDist = 15;};

_speedDamage = 12;

_pos = getPos _vehicle;
_vehicle setPos [-1000, -1000, 10];
_vehicle setVelocity [0, 0, 2];
sleep 0.05;
_vehicle setPos [_pos select 0, _pos select 1, (_pos select 2) + 2];
_vehicle setVelocity [0,0,2];

while {!isNull(((vehicleAttached select _tugindex) select tsTugged) select _tugslot) && (alive _tug) && (alive _vehicle)}do
{
	_posBoat = getPos _tug;
	_dirBoat = getDir _tug;
	_dirVehicle = getDir _vehicle;
	_posAttach = [(_posBoat select 0) + _attachDist*sin(_dirBoat+_attachDir), (_posBoat select 1) + _attachDist*cos(_dirBoat+_attachDir), 0];

	_vDisp = [_posAttach, getPos _vehicle] call fVectorSubstract;
	_vDispLength = _vDisp call fVectorLength;

	_vVelAdd = [(_vDisp select 0)/5, (_vDisp select 1)/5, _vDisp select 2];
	_alt = (getPos _vehicle) select 2;
	_vVelAdd set [2, 2 - _alt];

	_velBoat = velocity _tug;
	_velVehicle = velocity _vehicle;
	_speedDiffHorz = ([_velVehicle, _velBoat] call fVectorSubstract) call fVectorLength;

	_dirDiff = _dirVehicle - _dirBoat;
	if (_dirDiff > 180) then {_dirDiff = _dirDiff - 360;};
	if (_dirDiff < -180) then {_dirDiff = _dirDiff + 360;};
	if (_dirDiff > 1) then {_vehicle setDir (-1 + getDir _vehicle);};
	if (_dirDiff < -1) then {_vehicle setDir (1 + getDir _vehicle);};
	_vehicle setVelocity ([[velocity _tug, 0.8] call fVectorScale, _vVelAdd] call fVectorAdd);

};

((vehicleAttached select _tugindex) select tsTugged) set [_tugslot, objNull];
[_vehicle, _gi, _si] execVM "Common\SendVehicleDetached.sqf";

_pos = getPos _vehicle;
_vehicle setPos [-1000, -1000, 10];
_vehicle setVelocity [0, 0, 2];
sleep 0.05;
_vehicle setPos _pos;
_velVehicle = velocity _vehicle;
_velVehicle set [2, (_velVehicle select 2) + 2];
_vehicle setVelocity _velVehicle;
