_radar = _this select 0;
_type = _this select 1;
_si = _this select 2;

waitUntil {!isNil "crcti_kb_initPlayerDone"};
waitUntil {crcti_kb_initPlayerDone};

if ( _si == playerSideIndex ) then
{
	_range = radarRange;
	if ( _type == stAAradarLR ) then {_range = radarRangeLR;};

	_pos = getPos _radar;

	_marker = format["radarmarker_%1", str(_radar)];
	_circle = format["radarcircle_%1", str(_radar)];

	createMarkerLocal [_marker, _pos];
	_marker setMarkerAlphaLocal 1;
	_marker setMarkerPosLocal _pos;
	_marker setMarkerTypeLocal "n_recon";
	_marker setMarkerColorLocal "ColorBlack";
	_marker setMarkerTextLocal "";
	_marker setMarkerSizeLocal [0.75,0.75];

	createMarkerLocal [_circle, _pos];
	_circle setMarkerAlphaLocal 0;
	_circle setMarkerShapeLocal "ELLIPSE";
	_circle setMarkerBrushLocal "BORDER";
	_circle setMarkerSizeLocal [_range, _range];
	_circle setMarkerColorLocal "ColorBlack";

	_points = [];
	for[ {_angle=0}, {_angle<=360}, {_angle=_angle+5}] do
	{
		_up = [0,1,0];
		_dir = [_up, _angle] call fVectorRot;

		_pos0 = _pos;
		_pos0 set [2,getTerrainHeightASL(_pos0)+ radarHeight];

		_r = 0;
		_pos1 = [_pos0, _dir, _r] call fVectorAdd;
		_pos1 set [2,getTerrainHeightASL(_pos1) + 5];

		_pos2 = _pos0;

		while {_r < _range}do
		{
			_pos1 = [_pos0, _dir, _r] call fVectorAdd;
			_pos1 set [2,getTerrainHeightASL(_pos1)+ 5];
			_r = _r + 50;

			if ( !(terrainIntersectASL[_pos0, _pos1]) ) then
			{
				_pos2 = _pos1;
			};
		};

		_points = _points + [_pos2];
	};

	_rangeMarkers = [];
	for[ {_i=0}, {_i<(count(_points)-1)}, {_i=_i+1}] do
	{
		_p0 = _points select _i;
		_p1 = _points select _i+1;

		_rangemarker = format["radarcircle_%1_%2", str(_radar), str(_i)];

		[_rangemarker, _p0, _p1, "ColorBlack"] call funcDrawMapLine;
		_rangemarker setMarkerAlphaLocal 0;
		_radius = (_p0 distance _p1)/2.0;
		_rangemarker setMarkerSizeLocal [_radius, 4.0];

		_rangeMarkers = _rangeMarkers + [_rangemarker];
	};

	radarMarkers = radarMarkers + [[_radar,_marker,_circle, _rangeMarkers]];
};