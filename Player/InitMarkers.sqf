// args: [si]

vehicleMarkerMapping = [ [], [],[],[],[],[] ];
freeVehicleMarkers = [ [], [],[],[],[],[] ];
radarMarkers = [];
relayMarkers = [];

_si = _this select 0;
_gi = _this select 1;

hiddenMarkerPos = [0, 0];

// ACRE Frequency
if ( AcreAllowed ) then
{
	_fm = "ACRE_Frequency";
	createMarkerLocal [_fm, [1000,1000] ];
	_fm setMarkerColorLocal "ColorBlack";
	_fm setMarkerTypeLocal "waypoint";
	_fm setMarkerSizeLocal [1.0, 1.0];
	_fm setMarkerTextLocal format["Radio Frequency Channel 1: %1 MHz", str((pvAcreFreq select _si) select 0)];

	{
		_c0 = _forEachIndex;
		_c1 = _forEachIndex + 1;
		_freq0 = (pvAcreFreq select _si) select _c0;
		_freq1 = (pvAcreFreq select _si) select _c1;

		_rm = format["relaymarker_%1", _forEachIndex];
		createMarkerLocal [_rm, hiddenMarkerPos];
		_rm setMarkerPosLocal hiddenMarkerPos;
		_rm setMarkerTypeLocal "n_mortar";
		_rm setMarkerColorLocal "ColorBlack";
		_rm setMarkerTextLocal format["Ch%1 <=> Ch%2 (%3 <=> %4)", _c0+1, _c1+1, _freq0, _freq1];
		_rm setMarkerSizeLocal [0.0, 0.0];
	}forEach (pvAcreRelays select _si);
};

// RESPAWN MARKERS
_siEnemy = -1;
if (_si == siWest) then
{
	_siEnemy = siEast;
	"Respawn_east" setMarkerTypeLocal "empty";
	"Respawn_west" setMarkerPosLocal hiddenMarkerPos;
};
if (_si == siEast) then
{
	_siEnemy = siWest;
	"Respawn_west" setMarkerTypeLocal "empty";
	"Respawn_east" setMarkerPosLocal hiddenMarkerPos;
};
if (_si == siCiv) then
{
	_siEnemy = siCiv;
	"Respawn_east" setMarkerTypeLocal "empty";
	"Respawn_west" setMarkerPosLocal hiddenMarkerPos;
	"Respawn_west" setMarkerTypeLocal "empty";
	"Respawn_east" setMarkerPosLocal hiddenMarkerPos;
};

// TOWN SIDE/AREA MARKERS
_index = 0;
{
	_townside = _x select 3;
	_town = _x select 0;

	_marker = format["Town_%1", _index];
	createMarkerLocal [_marker, getPos _town ];

	_marker setMarkerAlphaLocal 0.8;
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "SOLIDBORDER";
	_marker setMarkerSizeLocal [townRadius, townRadius];
	_marker setMarkerColorLocal "ColorBlack";

	if (_townside == _si && _townside == siWest) then
	{
		_marker setMarkerColorLocal "colorBlue";
	};
	if (_townside == _si && _townside == siEast) then
	{
		_marker setMarkerColorLocal "colorRed";
	};

	_marker setMarkerPosLocal getPos _town;

	_circle = format["TownCircle_%1", _index];
	createMarkerLocal [_circle, getPos _town ];

	_circle setMarkerAlphaLocal 1.0;
	_circle setMarkerShapeLocal "ELLIPSE";
	_circle setMarkerBrushLocal "BORDER";
	_circle setMarkerSizeLocal [flagRadius, flagRadius];
	_circle setMarkerColorLocal "colorOrange";

	_index = _index + 1;
}forEach towns;

{
	if ( _forEachIndex > 0 ) then
	{
		_p0 = _x;
		_p1 = TownLine select (_forEachIndex - 1);

		_m = format["TownLinePoint_%1", _forEachIndex];
		[_m, _p0, _p1, "ColorGreen"] call funcDrawMapLine;

		_radius = (_p0 distance _p1)/2.0;
		_m setMarkerSizeLocal [_radius, 10.0];
	};
}forEach TownLine;

if ( !isNil "TownAxis") then
{
	_p0 = TownAxis select 0;
	_p1 = TownAxis select 1;

	["TownAxisMarker", _p0, _p1, "ColorGreen"] call funcDrawMapLine;
	_radius = (_p0 distance _p1)/2.0;
	"TownAxisMarker" setMarkerSizeLocal [_radius, 10.0];
};

// VEHICLE MARKERS
maxVehicleMarkers = 100;
{
	_msi = _x;
	for[ {_index=0}, {_index<maxVehicleMarkers}, {_index=_index+1}] do
	{
		_marker = format["%1 Vehicle %2", str(_msi), _index];
		createMarkerLocal [_marker, hiddenMarkerPos];
		_marker setMarkerPosLocal hiddenMarkerPos;

		_colors = ["ColorGreen","ColorRed","ColorOrange", "ColorWhite", "ColorBlue", "ColorGrey"];

		_marker setMarkerColorLocal (_colors select _msi);

		if ( _msi == playerSideIndex ) then {_marker setMarkerColorLocal "ColorGreen";};
		if ( _msi == _siEnemy ) then {_marker setMarkerColorLocal "ColorRed";};

		(freeVehicleMarkers select _msi) set [_index, _index];
	};
}forEach [siWest, siEast, siRes, siBoth, siCiv, siNone];

// LEADER MARKERS
_teamDesignations = groupNames;

{
	_teamName = _x;

	_marker = Format["West %1 Marker", _teamName];

	createMarkerLocal [_marker, hiddenMarkerPos];
	_marker setMarkerTypeLocal "empty";
	_marker setMarkerPosLocal hiddenMarkerPos;
	_marker setMarkerSizeLocal [0.5,0.5];
	_marker setMarkerColorLocal "ColorBlue";

	_marker2 = Format["West %1 Marker_1", _teamName];
	createMarkerLocal [_marker2, hiddenMarkerPos];
	_marker2 setMarkerSizeLocal [0,0];
	_marker2 setMarkerTextLocal "";

	_marker = Format["East %1 Marker", _teamName];

	createMarkerLocal [_marker, hiddenMarkerPos];
	_marker setMarkerTypeLocal "empty";
	_marker setMarkerPosLocal hiddenMarkerPos;
	_marker setMarkerSizeLocal [0.5,0.5];
	_marker setMarkerColorLocal "ColorBlue";

	_marker2 = Format["East %1 Marker_1", _teamName];
	createMarkerLocal [_marker2, hiddenMarkerPos];
	_marker2 setMarkerSizeLocal [0,0];
	_marker2 setMarkerTextLocal "";

	if (_si == siCiv) then
	{
		_marker setMarkerColorLocal "ColorRed";
	};

}forEach _teamDesignations;

// GROUP MEMBER MARKERS

for[ {_gi=0}, {_gi<(count (groupMatrix select _si))}, {_gi=_gi+1}] do
{
	for[ {_index=0}, {_index<maxGroupSize+5}, {_index=_index+1}] do
	{

		_marker = Format["UnitMarker_0_%1_%2", _gi, _index];
		createMarkerLocal [_marker, hiddenMarkerPos];
		_marker setMarkerPosLocal hiddenMarkerPos;
		_marker setMarkerColorLocal "ColorOrange";
		_marker setMarkerSizeLocal [0.25,0.25];
		_marker setMarkerTypeLocal "n_inf";

		if (_si == siCiv) then {_marker setMarkerColorLocal "ColorBlue";};
		if (_si == siWest && _gi == playerGroupIndex) then {_marker setMarkerColorLocal "ColorRed";};

		_marker = Format["UnitMarker_1_%1_%2", _gi, _index];
		createMarkerLocal [_marker, hiddenMarkerPos];
		_marker setMarkerPosLocal hiddenMarkerPos;
		_marker setMarkerColorLocal "ColorOrange";
		_marker setMarkerSizeLocal [0.25,0.25];
		_marker setMarkerTypeLocal "n_inf";
		if (_si == siCiv) then {_marker setMarkerColorLocal "ColorRed";};
		if (_si == siEast && _gi == playerGroupIndex) then {_marker setMarkerColorLocal "ColorRed";};

	};
};

// NUMBERED PLAYER AI MARKERS
for [ {_i=2}, {_i<maxGroupSize+5}, {_i=_i+1}] do
{
	_text = format ["%1", _i];
	_m = createMarkerLocal [format["PlayerUnit_%1", _i], hiddenMarkerPos];
	_m setMarkerTextLocal _text;
	_m setMarkerColorLocal "ColorRed";
	_m setMarkerTypeLocal "n_inf";
	_m setMarkerSizeLocal [0.25,0.25];
};

// WAYPOINTS

for[ {_i=0}, {_i<countWP}, {_i=_i+1}] do
{
	_cowp = format ["co%1", _i];
	_marker = createMarkerLocal [ format ["co_%1", _i], hiddenMarkerPos ];
	_marker setMarkerTextLocal _cowp;
	_marker setMarkerColorLocal "ColorRed";
	_marker setMarkerTypeLocal "waypoint";
	_marker setMarkerSizeLocal [0.5, 0.5];

	_wpos = (wpCO select PlayerSideIndex) select _i;

	if ( (_wpos select 0) != -1 || (_wpos select 1) != -1 ) then
	{
		_marker setMarkerPosLocal _wpos;
	};
};

for[ {_i=0}, {_i<countWP}, {_i=_i+1}] do
{
	_wp = format["wp%1", _i];
	_marker = createMarkerLocal [ format["wp_%1", _i], hiddenMarkerPos ];
	_marker setMarkerTextLocal _wp;
	_marker setMarkerColorLocal "ColorBlack";
	_marker setMarkerTypeLocal "waypoint";
	_marker setMarkerSizeLocal [0.5, 0.5];
};

// Rally WAYPOINT

"rally" setMarkerSizeLocal [0.5, 0.5];
"rally" setMarkerPosLocal hiddenMarkerPos;
"CO_rally" setMarkerSizeLocal [1, 1];
"CO_rally" setMarkerPosLocal hiddenMarkerPos;

// ARTILLERY
artMarkers = [0,1,2,3,4,5,6,7,8,9];
{
	format["Art%1", _x] setMarkerPosLocal hiddenMarkerPos;
}foreach artMarkers;

// Enemy Spotted
enemyMarkers = [0,1,2,3,4,5,6,7,8,9];
{
	format["EnemySpotted_%1", _x] setMarkerPosLocal hiddenMarkerPos;
}foreach enemyMarkers;

_m = createMarkerLocal ["Base1", hiddenMarkerPos];
_m setMarkerTextLocal "Base1";
_m setMarkerColorLocal "ColorRed";
_m setMarkerTypeLocal "b_hq";
_m setMarkerSizeLocal [1, 1];
_m = createMarkerLocal ["Base2", hiddenMarkerPos];
_m setMarkerTextLocal "Base2";
_m setMarkerColorLocal "ColorRed";
_m setMarkerTypeLocal "b_hq";
_m setMarkerSizeLocal [1, 1];

_m = createMarkerLocal ["SQU_temp", hiddenMarkerPos];
_m setMarkerTextLocal "Temp WP";
_m setMarkerColorLocal "ColorRed";
_m setMarkerTypeLocal "mil_dot";
_m setMarkerSizeLocal [1, 1];

if (_si != siciv) then
{
	if((_si == siwest) and (count (BaseMatrix select _si))>= 1)then {pvbase1W = true;};
	if((_si == sieast) and (count (BaseMatrix select _si))>= 1)then {pvbase1E = true;};
	if((_si == siwest) and (count (BaseMatrix select _si))== 2)then {pvbase2W = true;};
	if((_si == sieast) and (count (BaseMatrix select _si))== 2)then {pvbase2E = true;};
};