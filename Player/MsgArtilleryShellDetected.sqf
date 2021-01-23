_pvArt = _this select 0;

_si = _pvArt select 0;
_pos = _pvArt select 1;
_detections = _pvArt select 2;

if ( _si != playerSideIndex ) then
{
	if ( (((upgMatrix select playerSideIndex) select upgRadarArtillery) select 3) == 2 && count ([playerSideIndex, stComm] call funcGetWorkingStructures) > 0 ) then
	{
		if ( time - lastArtyMessage > 60 ) then
		{
			player sidechat format["Artillery detected! Estimated pos: %1", _pos call funcCalcMapPos];
			lastArtyMessage = time;
		};

		_marker = format["arty_%1%2", str(_pos select 0), str(_pos select 1)];
		createMarkerLocal [_marker, _pos];
		_marker setMarkerPosLocal _pos;
		_marker setMarkerTypeLocal "n_art";
		_marker setMarkerColorLocal "colorRed";
		_marker setMarkerTextLocal "";
		_marker setMarkerSizeLocal [1.0,1.0];

		sleep 120;
		deleteMarkerLocal _marker;
	};
};