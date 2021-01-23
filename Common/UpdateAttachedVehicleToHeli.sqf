//; args: [vehicle, tug, index, slot, gi, si]

if ( THISISARMA3 && ((productVersion select 2) >= 133) ) then
{
	_nul = _this execVM "Common\UpdateAttachedVehicleToHeliRopes.sqf";
}
else
{

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

	cable_length = 12;
//-----------------------------------------------------------------------------
// these functions are based on airlift script by ArMaTec and T_D
	_calcAccH =
	{
	private['_vel1', '_vel2', '_t1', '_t2', '_dt', '_aX', '_aY', '_aZ', '_accH'];
		_vel1 = velocity (_this select 0);
		_t1 = time;

		while {time < (_t1 + 0.001)}do {};

		_vel2 = velocity (_this select 0);
		_t2 = time;
		_dt = _t2-_t1;
		_aX = ((_vel2 select 0) - (_vel1 select 0))/_dt;
		_aY = ((_vel2 select 1) - (_vel1 select 1))/_dt;
		_aZ = ((_vel2 select 2) - (_vel1 select 2))/_dt;
		_accH = [_aX,_aY,_aZ];
		_accH;
	};

	_calcPos =
	{
	private['_offsetX', '_offsetY', '_offsetZ', '_l', '_v', '_cargoPos', '_heliPos', '_cargoZ', '_heliZ', '_posC', '_radius'];
		_radius = cable_length;
		_offsetX = -((_this select 2)select 0);
		_offsetY = -((_this select 2)select 1);
		_l = sqrt(_offsetX^2 + _offsetY^2);
		if(_l >= _radius)then
		{
			_l = sin 95 * _radius;
			_v = [_offsetX,_offsetY,0] call fVectorNormalize;
			_v = [_v,[_l]] call fVectorProduct;
			_offsetX = _v select 0;
			_offsetY = _v select 1;
		};
		_offsetZ = sqrt(_radius^2 - _l^2);
		_cargoPos = getPos (_this select 0);
		_cargoZ = _cargoPos select 2;
		_heliPos = getPos (_this select 1);
		_heliZ = _heliPos select 2;
		//IF chopper height is lower then the rope lenght
		//then shorten the distance form chopper to transport
		if((_cargoZ <= -0))then {_Offsetz = _Offsetz - _cargoZ;};
		if((_cargoZ >= 0)&&(_heliZ <= _radius))then {_Offsetz = _heliZ+2.1;}; // what's 2.1? prob vehicle_bottom_offset
		if(_heliZ >= _radius)then {_Offsetz = _radius};

		_posC = [(getPos (_this select 1)),[_offsetX,_offsetY,-_offsetZ]] call fVectorAdd;
		if (_posC select 2 < 0) then
		{
			_posC = [_posC select 0, _posC select 1, 0]; // modified code to prevent bouncing under ground
		};
		_posC;
	};

	_interpolateAcc =
	{
	private['_difAcc', '_accH', '_accC'];
		_accH = _this select 0;
		_accC = _this select 1;
		_difAcc = [_accH,_accC] call fVectorSubstract;
		_accC = [_accC,[_difAcc,[0.04]] call fVectorProduct] call fVectorAdd;
		_accC;
	};

	ArmA_AL_vectors =
	{
	private['_accC2', '_accH', '_vUp', '_posC'];
		_accC2 = _this select 2;
		_accH = [(_this select 1)] call _calcAccH;
		_accC2 = [_accH, _accC2] call _interpolateAcc;
		_posC = [(_this select 0),(_this select 1),_accC2] call _calcPos;
		_vUp = [getPos (_this select 0),getPos (_this select 1)] call fVectorTo;
		(_this select 0) setPos _posC;
		(_this select 0) setDir getdir (_this select 1);
		(_this select 0) setVectorUp _vUp;
		(_this select 0) setVelocity velocity (_this select 1);
		_accC2;
	};

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

			waitUntil {(getPos _vehicle) select 2 < 5};
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

	while {(alive _heli) && (alive _vehicle)}do
	{
		_accC2 = [_vehicle, _heli, _accC2] call ArmA_AL_vectors;

		if(isNull(((vehicleAttached select _tugindex) select tsTugged) select _tugslot) || !(alive _heli) )exitwith {};
		if(!(alive _vehicle))exitwith {player groupChat 'Vehicle detached - damaged';};
	};
	[[_heli,_vehicle], "funcEnableCollisionWith", [_heli, _vehicle], false, true] call BIS_fnc_MP;
	_vehicle removeEventHandler ["fired", _firedEVH];

	call _Abort;

};