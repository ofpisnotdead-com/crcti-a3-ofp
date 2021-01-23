private ["_markerName", "_pos1", "_pos2", "_color", "_lineMidPos", "_radius", "_Azimuth"];

_markerName = _this select 0;
_pos1 = _this select 1;
_pos2 = _this select 2;
_color = _this select 3;

_lineMidPos = [((_pos1 select 0)+(_pos2 select 0)) / 2.0,((_pos1 select 1)+(_pos2 select 1)) / 2.0, 0];
_radius = ([_pos1, _pos2] call funcDistH) / 2.0;

// don't draw line if either pos is zero
if (( (_pos1 select 0) == 0 && (_pos1 select 1) == 0 ) || ( (_pos2 select 0) == 0 && (_pos2 select 1) == 0 )) then 
{ 
  _radius = 0; 
};

_Azimuth = [_pos1, _pos2] call funcCalcAzimuth;

createMarkerLocal [_markerName, _lineMidPos];
_markerName setMarkerPosLocal _lineMidPos; // in case it already exists
//_markerName setMarkerTextLocal "";
_markerName setMarkerShapeLocal "RECTANGLE";
//_markerName setMarkerTypeLocal "Dot";
_markerName setMarkerDirLocal +90+_Azimuth;
_markerName setMarkerColorLocal _color;
_markerName setMarkerSizeLocal [_radius, .7];


