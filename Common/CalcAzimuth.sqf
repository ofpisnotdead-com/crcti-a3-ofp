// Desc: Calculate Azimuth between 2 (objects) positions
//-----------------------------------------------------------------------------
//---- obtain parameters
/*
_ObjA = _this select 0;
_ObjB = _this select 1;

//---- obtain position info, for calculating Azimuth
_posA = getPos _ObjA;
_posB = getPos _ObjB;
*/
_posA = _this select 0;
_posB = _this select 1;

_Cx = _posA select 0;
_Cy = _posA select 1;
//_Cz = _posA select 2;

_Kx = _posB select 0;
_Ky = _posB select 1;
//_Kz = _posB select 2;

// calc offset & use normalized coord system
_dx = -(_Cx - _Kx);
_dy = -(_Cy - _Ky);

if (_dx == 0) then 
{
  _dx = 0.001; // prevent possible div by 0
};

//---- calc Azimuth, using basic trig. 
// Result is: -180 < Azimuth <= 180
_Azimuth = round(_dx atan2 _dy);

// adjust to compass angle: 0 <= Azimuth < 360
if (_Azimuth < 0) then 
{
  _Azimuth = 360+_Azimuth;
};

// Result
_Azimuth;
