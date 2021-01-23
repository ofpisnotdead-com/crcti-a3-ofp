//; args: [vehicle, tug, index, slot, gi, si]

_vehicle = _this select 0;
_heli = _this select 1;
_tugindex = _this select 2;
_tugslot = _this select 3;
_gi = _this select 4;
_si = _this select 5;

_attachHeight = 20;
_speedDamageVert = 10;
_speedDiffDetachHorz = 22;
_damage = 0;
_vehicle setVelocity [0,0,1];
_accC2 = [0,0,0];
_chute = objnull;

cable_length = 25;

_Abort=
{
	((vehicleAttached select _tugindex) select tsTugged) set [_tugslot, objNull];
	[_vehicle, _gi, _si] execVM "Common\SendVehicleDetached.sqf";

	if ( (getPosATL _vehicle) select 2 > 50 ) then
	{
		_chute = createVehicle ["B_Parachute_02_F", [0,0,1000], [], getDir _vehicle, 'FLY'];

		{
			[[_x,_chute], "funcDisableCollisionWith", [_x,_chute], false, true] call BIS_fnc_MP;
		}forEach (crew _heli);

		[[_vehicle,_chute], "funcDisableCollisionWith", [_vehicle, _chute], false, true] call BIS_fnc_MP;
		[[_heli,_chute], "funcDisableCollisionWith", [_heli, _chute], false, true] call BIS_fnc_MP;

		_t = time + 10;
		waitUntil {(_vehicle distance _heli > 40) || (time > _t)};

		_pos = getPos _vehicle;
		_chute setPos _pos;
		_vehicle setPos _pos;
		_vehicle attachTo [_chute];

		waitUntil {((getPos _vehicle) select 2) < 5};
		detach _vehicle;
	};
};

_ev = {
	deleteVehicle (_this select 6);
	_veh = _this select 0;
	_hint = _veh getVariable ["failhint", false];
	if ( !_hint ) then
	{
		["Maybe you should go play Battlefield instead.", vehicle leader gunner _veh, {playsound "fail";}] execVM "Server\Info\VehicleMessage.sqf";
		_veh setVariable ["failhint", true, false];
	};
};
_firedEVH = _vehicle addEventHandler ["fired", _ev];

_posHeli = getPos _heli;
while {_attachHeight > _posHeli select 2}do
{
	_posHeli = getPos _heli;
	if(isNull(((vehicleAttached select _tugindex) select tsTugged) select _tugslot) || !(alive _heli) || !(alive _vehicle))exitwith {};
	if((_heli distance _vehicle) > 2*_attachHeight)exitwith {};
};

[[_heli,_vehicle], "funcDisableCollisionWith", [_heli, _vehicle], false, true] call BIS_fnc_MP;

_oldMass = getMass _vehicle;

if ( _heli canSlingLoad _vehicle ) then
{
	_heli setSlingLoad _vehicle;
}
else
{
	_maxLoad = getNumber(configFile >> "cfgVehicles" >> typeOf _heli >> "slingLoadMaxCargoMass");
	if ( _maxLoad < 10 ) then {_maxLoad = 10;};
	if ( _oldMass > _maxLoad*0.75 ) then
	{
		_vehicle setMass _maxLoad*0.75;
		if ( !(local _heli) ) then {[[_vehicle, _maxLoad*0.75], "funcSetMass", _heli, false, true] call BIS_fnc_MP;};
		waitUntil {(getMass _vehicle) < (_maxLoad + 1)};
	};
	
	_vehicle setDir (getDir _heli);
	_vehicle setVectorUp [0,0,1];

	_bbox = boundingBoxReal _vehicle;
	_cg = getCenterOfMass _vehicle;

	_min = [_bbox select 0, _cg] call fVectorAdd;
	_max = [_bbox select 1, _cg] call fVectorAdd;

	_minx = (_min select 0)*0.3;
	_maxx = (_max select 0)*0.3;
	_miny = (_min select 1)*0.3;
	_maxy = (_max select 1)*0.3;
	_z = ((_min select 2) + (_max select 2))*0.3;

	ropeCreate [_heli, "slingload0", _vehicle, [_minx,_miny,_z], cable_length];
	ropeCreate [_heli, "slingload0", _vehicle, [_minx,_maxy,_z], cable_length];
	ropeCreate [_heli, "slingload0", _vehicle, [_maxx,_miny,_z], cable_length];
	ropeCreate [_heli, "slingload0", _vehicle, [_maxx,_maxy,_z], cable_length];

};

while {(alive _heli) && (alive _vehicle)}do
{
	if(!(_vehicle in (ropeAttachedObjects _heli))) exitWith {diag_log "Ropes cut.";};
	if(isNull(((vehicleAttached select _tugindex) select tsTugged) select _tugslot)) exitWith {diag_log "Detached normally.";};
	if( !(alive _heli))exitwith {diag_log "Tug destroyed.";};
	if(!(alive _vehicle))exitwith {player groupChat 'Vehicle detached - damaged'; diag_log "Vehicle destroyed.";};
};

_vehicle setMass _oldmass;
waitUntil {(getMass _vehicle) > (_oldmass - 1)};
{	ropeDestroy _x}forEach (ropes _heli);
if ( !(local _heli) ) then {[[_vehicle, _oldmass], "funcSetMass", _heli, false, true] call BIS_fnc_MP;};

[[_heli,_vehicle], "funcEnableCollisionWith", [_heli, _vehicle], false, true] call BIS_fnc_MP;
_vehicle removeEventHandler ["fired", _firedEVH];

call _Abort;

