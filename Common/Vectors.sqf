// T_D's vector functions

fVectorRot = {
	[((_this select 0) select 0)*(cos(_this select 1)) + ((_this select 0) select 1)*(sin(_this select 1)), 
	 ((_this select 0) select 1)*(cos(_this select 1)) - ((_this select 0) select 0)*(sin(_this select 1)), 0]
};

fVectorDot = {
	((_this select 0) select 0)*((_this select 1) select 0) + ((_this select 0) select 1)*((_this select 1) select 1)
};

fVectorCross = {
	private ["_x", "_y", "_z"];
	_x = ((_this select 0) select 1)*((_this select 1) select 2) - ((_this select 0) select 2)*((_this select 1) select 1);
	_y = ((_this select 0) select 2)*((_this select 1) select 0) - ((_this select 0) select 0)*((_this select 1) select 2);
	_z = ((_this select 0) select 0)*((_this select 1) select 1) - ((_this select 0) select 1)*((_this select 1) select 0);
	[_x,_y,_z]
};


fVectorScale = {
	private["_v1", "_scale"];
	_v1 = _this select 0;
	_scale = _this select 1;
	[(_v1 select 0)*_scale,(_v1 select 1)*_scale,(_v1 select 2)*_scale]
};

fVectorAdd ={
	private["_v1","_v2","_f"];
	_v1=_this select 0;
	_v2=_this select 1;
	_f = if(count _this >2)then{_this select 2}else{1};
	[(_v1 select 0) + _f*(_v2 select 0),(_v1 select 1) + _f*(_v2 select 1),(_v1 select 2) + _f*(_v2 select 2)]
};
fVectorLength ={ [0,0,0] distance _this; };
fVectorNormalize ={
	private["_l"];
	_l=_this call fVectorLength;
	if(_l != 0)then
	{
		[(_this select 0)/_l,(_this select 1)/_l,(_this select 2)/_l]
	}else{
		[0,0,0]
	}
};
fVectorSubstract ={
	private["_v1","_v2","_f"];
	_v1=_this select 0;
	_v2=_this select 1;
	_f = if (count _this >2) then {_this select 2} else {1};
	[(_v1 select 0)-_f*(_v2 select 0), (_v1 select 1)-_f*(_v2 select 1), (_v1 select 2)-_f*(_v2 select 2)]
};
fVectorTo ={
	[_this select 1,_this select 0] call fVectorSubstract
};
fVectorProduct ={
	private["_v1","_v2","_sp"];
	_v1=_this select 0;
	_v2=_this select 1;
	_sp= if(count _this >2) then {_this select 2} else {false};
	if(count(_v2) == 1)then
	{
		[(_v2 select 0)*(_v1 select 0),(_v2 select 0)*(_v1 select 1),(_v2 select 0)*(_v1 select 2)]
	}else{
		if(_sp)then	{(_v1 select 0)*(_v2 select 0) + (_v1 select 1)*(_v2 select 1) + (_v1 select 2)*(_v2 select 2)}else{[(_v1 select 1)*(_v2 select 2) - (_v1 select 2)*(_v2 select 1),	- ((_v1 select 0)*(_v2 select 2) - (_v1 select 2)*(_v2 select 0)),(_v1 select 0)*(_v2 select 1) - (_v1 select 1)*(_v2 select 0)]}
	}
};
fVectorAngle ={
	private["_v1","_v2","_v1l","_v2l"];
	_v1=_this select 0;

	_angle = -1;
	if(count _this >1)then
	{
		_v2=_this select 1;
	}else{
		_v2=[_v1 select 0,_v1 select 1,0];
	};
	_v1l=_v1 call fVectorLength; _v2l=_v2 call fVectorLength;
	acos(([_v1,_v2,true] call fVectorProduct)/(_v1l*_v2l))
};
fVectorSide ={
	private["_vDir","_vUp"];
	_vDir = vectorDir _this;
	_vUp = vectorUp _this;
	([_vDir,_vUp] call fVectorProduct) call fVectorNormalize
};
fQuaternionCreate ={
	private["_axis","_angle"];
	_axis = _this select 0;
	_angle = (_this select 1);
	[cos _angle,[_axis,[sin _angle]] call fVectorProduct]
};
fQuaternionConjugate ={	
	[_this select 0,[_this select 1,-1] call fVectorProduct]
};
fQuaternionMultiply ={
	private["_quat1","_quat2","_a","_b","_v1","_v2","_vp1","_vp2","_cp"];
	_quat1 = _this select 0;
	_quat2 = _this select 1;
	_a = _quat1 select 0;
	_b = _quat2 select 0;
	_v1 = _quat1 select 1;
	_v2 = _quat2 select 1;
	_vp1 = [_v1,[_a]] call fVectorProduct;
	_vp2 = [_v2,[_b]] call fVectorProduct;
	_cp = [_v1,[_v2]] call fVectorProduct;
	[
		_a*_b - ([_v1,_v2,true] call fVectorProduct),
		[[_vp1,_vp2] call fVectorAdd,_cp] call fVectorAdd
	]
};
fQuaternionRotateVector ={
	private["_RotQuat","_vector","_RotQuatCon"];
	_RotQuat = _this select 0;
	_vector = _this select 1;
	_RotQuatCon = _RotQuat call fQuaternionConjugate;
	[([[_RotQuat,[0,_vector]] call fQuaternionMultiply,_RotQuatCon] call fQuaternionMultiply) select 1, [-1]] call fVectorProduct
}; 
fQuaternionYawPitchRoll ={
	private["_yaw","_pitch","_roll","_sinY","_cosY","_sinP","_cosP","_sinR","_cosR"];
	_yaw = (_this select 0)*(-1);
	_pitch = (_this select 1)*(-1);
	_roll = (_this select 2)*(-1);
	_sinY = sin _yaw;
	_cosY = cos _yaw;
	_sinP = sin _pitch;
	_cosP = cos _pitch;
	_sinR = sin _roll;
	_cosR = cos _roll;
	[
		_cosR*_cosP*_cosY+_sinR*_sinP*_sinY,
		[
			_sinR*_cosP*_cosY-_cosR*_sinP*_sinY,
			_cosR*_sinP*_cosY+_sinR*_cosP*_sinY,
			_cosR*_cosP*_sinY-_sinR*_sinP*_cosY
		]
	]
};
fSetYawPitchRoll ={
	private["_obj","_yaw","_pitch","_roll","_rotQuat","_vUp","_vDir","_vSide","_curPitch","_curRoll"];
	_obj = _this select 0;
	_yaw = _this select 1;
	_pitch = _this select 2;
	_roll = _this select 3;
	_rotQuat = [_yaw,_pitch,_roll] call fQuaternionYawPitchRoll;
	_vUp = [_rotQuat,[0,0,1]] call fQuaternionRotateVector;
	_vDir = [_rotQuat,[0,1,0]] call fQuaternionRotateVector;
	_obj setVectorDir _vDir;
	_obj setVectorUp _vUp;
};
fSetPitch ={
	private["_obj","_pitch","_rotQuat","_vUp"];
	_obj = _this select 0;
	_pitch = _this select 1;
	_rotQuat = [vectorDir _obj,_pitch] call fQuaternionCreate;
	_vUp = [_rotQuat,[0,0,1]] call fQuaternionRotateVector;
	_obj setVectorUp _vUp;
};
fSetRoll ={
	private["_obj","_roll","_rotQuat","_vSide","_vUp"];
	_obj = _this select 0;
	_roll = _this select 1;
	_vSide = _obj call fVectorSide;
	_rotQuat = [_vSide,_roll] call fQuaternionCreate;
	_vUp = [_rotQuat,[0,0,1]] call fQuaternionRotateVector;
	_obj setVectorUp _vUp;
};
fShowObjCoordSystem ={
	private["_pos","_vDir","_vUp","_vSide","_scale","_pos1","_pos2","_pos3"];
	_pos = position _this;
	_vDir = vectorDir _this;
	_vUp = vectorUp _this;
	_vSide = _this call fVectorSide;
	_scale = 3;
	_vDir = [_vDir,[_scale]] call fVectorProduct;
	_vUp = [_vUp,[_scale]] call fVectorProduct;
	_vSide = [_vSide,[_scale]] call fVectorProduct;
	_pos1 = [_pos,_vDir] call fVectorAdd;
	_pos2 = [_pos,_vUp] call fVectorAdd;
	_pos3 = [_pos,_vSide] call fVectorAdd;
	drop ["\Ca\data\kouleSvetlo", "", "Billboard", 0.2, 0.2, _pos, [0,0,0], 0,1.275, 1, 0,[2,2],[[1,1,1,1]],[0],0,0,"","",""];
	drop ["\Ca\data\kouleSvetlo", "", "Billboard", 0.2, 0.2, _pos1, [0,0,0], 0,1.275, 1, 0,[2,2],[[1,0,0,1]],[0],0,0,"","",""];
	drop ["\Ca\data\kouleSvetlo", "", "Billboard", 0.2, 0.2, _pos2, [0,0,0], 0,1.275, 1, 0,[2,2],[[0,1,0,1]],[0],0,0,"","",""];
	drop ["\Ca\data\kouleSvetlo", "", "Billboard", 0.2, 0.2, _pos3, [0,0,0], 0,1.275, 1, 0,[2,2],[[0,0,1,1]],[0],0,0,"","",""];
};
fShowVector ={
	private["_pos","_v","_scale","_pos1"];
	_v = _this select 0;
	_pos = _this select 1;
	_scale = 3;
	_v = [_v,[_scale]] call fVectorProduct;
	_pos1 = [_pos,_v] call fVectorAdd;
	drop ["\Ca\data\kouleSvetlo", "", "Billboard", 0.2, 0.2, _pos, [0,0,0], 0, 1.275, 1, 0,[2,2],[[1,1,1,1]],[0],0,0,"","",""];
	drop ["\Ca\data\kouleSvetlo", "", "Billboard", 0.2, 0.2, _pos1, [0,0,0], 0, 1.275, 1, 0,[2,2],[[1,0,0,1]],[0],0,0,"","",""];
};
fDrawLine ={
	private["_P1","_P2","_lifeTime","_color","_disStep","_vec","_len","_dis","_pos","_size"];
	_P1 = _this select 0;
	_P2 = _this select 1;
	_lifeTime = _this select 2;
	_color = _this select 3;
	_disStep = _this select 4;
  _size = 0.05; if (count _this > 5) then {_size = _this select 5};
  
	_vec = [_P1,_P2] call fVectorTo;
	_len = _vec call fVectorLength;
	_vec = _vec call fVectorNormalize;
	for "_dis" from 0 to (_len-_disStep) step _disStep do
	{
		_pos = [_P1,_vec,_dis] call fVectorAdd;
		drop ["\Ca\Data\Cl_basic.p3d", "", "Billboard", _lifeTime, _lifeTime, _pos, [0,0,0], 0, 1.275, 1, 0,[_size],_color,[0],0,0,"","",""];
	};
};
fDrawShape ={
	private["_Points","_lifeTime","_color","_disStep","_cntPoints","_i","_P1","_P2"];
	_Points = _this select 0;
	_lifeTime = _this select 1;
	_color = _this select 2;
	_disStep = _this select 3;
	_cntPoints = count _Points;
	for "_i" from 0 to (_cntPoints-1) do
	{
		_P1 = _Points select _i;
		_P2 = if(_i+1 == _cntPoints)then{_Points select 0}else{_Points select (_i+1)};
		[_P1,_P2,_lifeTime,_color,_disStep,1.5] call fDrawLine;
	};
};
fDrawRope =
{
	private["_P1","_P2","_lifeTime"];
  _P1 = _this select 0;
  _P2 = _this select 1;
  _lifeTime = _this select 2;
  //_color,_disStep,_size
  [_P1,_P2,_lifeTime,[[0,0,0,1]],0.02,0.09] call fDrawLine;
};
fDrawBall =
{
	private["_pos","_lifeTime","_size"];
  _pos = _this select 0;
  _lifeTime = _this select 1;
  _size = _this select 2;
  drop ["\Ca\Data\Cl_basic.p3d", "", "Billboard", _lifeTime, _lifeTime, _pos, [0,0,0], 0, 1.275, 1, 0,[_size],[[0,0,0,1]],[0],0,0,"","",""];
};

/* Refs:
http://community.bistudio.com/wiki/ArmA:_ParticleShape
http://community.bistudio.com/wiki/ParticleArray
http://community.bistudio.com/wiki/drop

drop[
  // ShapeName 
  // AnimationName 
  // Type 
  // TimerPeriod 
  // LifeTime 
  // Position 
  // MoveVelocity 
  // RotationVelocity 
  // Weight 
  // Volume 
  // Rubbing 
  // Size 
  // Color 
  // AnimationPhase 
  // RandomDirectionPeriod 
  // RandomDirectionIntensity 
  // OnTimer 
  // BeforeDestroy 
  // Object
];
*/