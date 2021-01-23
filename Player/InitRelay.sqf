_relay = _this select 0;
_si = _this select 2;

waitUntil {!isNil "crcti_kb_initPlayerDone"};
waitUntil {crcti_kb_initPlayerDone};

if ( _si == playerSideIndex ) then
{
	_chan0 = 2;
	_chan1 = 4;

	_freq0 = (pvAcreFreq select _si) select _chan0;
	_freq1 = (pvAcreFreq select _si) select _chan1;

	_pos = position _relay;

	_marker = format["radarmarker_%1", str(_relay)];
	relayMarkers = relayMarkers + [[_relay,_marker]];

	createMarkerLocal [_marker, _pos];
	_marker setMarkerPosLocal _pos;
	_marker setMarkerTypeLocal "n_mortar";
	_marker setMarkerColorLocal "ColorBlack";
	_marker setMarkerTextLocal format["Ch%1 <=> Ch%2 (%3 <=> %4)", _chan0+1, _chan1+1, _freq0, _freq1];
	_marker setMarkerSizeLocal [0.75,0.75];
};