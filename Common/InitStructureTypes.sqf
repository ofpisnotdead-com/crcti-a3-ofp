//structDefs defines all buildable structures

alignDefs = [];
adCenter = 0;
adWidth = 1;

alignTypes = [];
structsFloat = [];
structDefs = [];

sdName = 0;
sdCost = 1;
sdSides = 2;
sdOnlyCO = 3;
sdOnlyMHQ = 4;
sdLimit = 5;
sdMaxRadius = 6;
sdDist = 7;
sdObjectsWest = 8;
sdObjectsEast = 9;
sdScriptsServer = 10;
sdScriptsPlayer = 11;
sdType = 12;
sdRearmTime = 13;
sdBuildCycleTime = 14;
sdBuildLimitTime = 15;

stNone = -6;

// structure types for unbuyable units (don't ask)
stPrebuiltBarracks = -5;
stPrebuiltLight = -4;
stPrebuiltHeavy = -3;
stPrebuiltAir = -2;
stPrebuiltMarina = -1;

// object format: [oName, nRot, aPos, upVec]

_type = 0;

structDefs set [_type, ["Barracks", 1000, siBoth, true, true, 4, 10, 15, [["Land_Cargo_House_V1_F", 0, []]], [["Land_Cargo_House_V1_F", 0, []]], ["InitPrimaryStructure.sqf","InitUnitFactory.sqf"], ["InitBarracks.sqf"],_type,0,5,0]];
stBarracks = _type;
_type = _type + 1;

structDefs set [_type, ["Light Vehicle Factory", 2000, siBoth, true, true, 4, 10, 20, [["Land_Cargo_House_V2_F", 0, []]], [["Land_Cargo_House_V2_F", 0, []]], ["InitPrimaryStructure.sqf","InitUnitFactory.sqf"], ["InitLightVehicleFactory.sqf"],_type,0,15,0]];
stLight = _type;
_type = _type + 1;

structDefs set [_type, ["Heavy Vehicle Factory", 4000, siBoth, true, true, 4, 15, 25, [["Land_Cargo_HQ_V1_F", 0, [1,0,0]]], [["Land_Cargo_HQ_V1_F", 0, [1,0,0]]], ["InitPrimaryStructure.sqf","InitUnitFactory.sqf"], ["InitHeavyVehicleFactory.sqf"],_type,0,30,0]];
stHeavy = _type;
_type = _type + 1;

structDefs set [_type, ["Aircraft Factory", 5000, siBoth, true, true, 4, 15, 30, [["Land_Cargo_Patrol_V1_F", 0, [0,0,0]]], [["Land_Cargo_Patrol_V1_F", 0, [0,0,0]]], ["InitPrimaryStructure.sqf","InitUnitFactory.sqf","InitAircraftFactory.sqf"], ["InitAircraftFactory.sqf"],_type,0,45,0]];
stAir = _type;
_type = _type + 1;

structDefs set [_type, ["Comm Center", 1200, siBoth, true, true, 2, 5, 15, [["Land_TTowerBig_2_F", 270, [],[0,0,1]]], [["Land_TTowerBig_2_F", 270, [],[0,0,1]]], ["InitPrimaryStructure.sqf", "InitRelay.sqf"], [],_type,0,0,0]];
stComm = _type;
_type = _type + 1;

_marina = [["Land_Lighthouse_small_F", -90, [0,0,0], [0,0,1]],
		   ["Land_Pier_small_F", 90, [-20,-5,-0.3], [0,0,1]],
		   ["Land_BuoyBig_F", -90, [-75,-5,0]]];

structDefs set [_type, ["Marina", 3000, siBoth, false, false, 3, 20, 20, _marina, _marina, ["InitPrimaryStructure.sqf","InitUnitFactory.sqf"], ["InitMarina.sqf"],_type,0,30,0] ];
stMarina = _type;
_type = _type + 1;

structDefs set [_type, ["Field Hospital", 200, siBoth, false, false, 10, 4, 15, [["Land_Medevac_house_V1_F", 180, []]], [["Land_Medevac_house_V1_F", 180, []]], ["InitSecondaryStructure.sqf"], ["InitHospital.sqf", "AddDeleteAction.sqf"],_type,0,0,0]];
_type = _type + 1;

structDefs set [_type, ["Radar Station", 1000, siBoth, false, false, 4, 5, 20, [["Land_Radar_Small_F", 90, [],[0,0,1]]], [["Land_Radar_Small_F", 90, [],[0,0,1]]], ["InitSecondaryStructure.sqf"], ["InitRadar.sqf", "AddDeleteAction.sqf"],_type,0,0,0]];
stAAradar = _type;
_type = _type + 1;

structDefs set [_type, ["Long Range Radar Station", 5000, siBoth, false, false, 4, 5, 20, [["Land_Radar_F", 90, [],[0,0,1]]], [["Land_Radar_F", 90, [],[0,0,1]]], ["InitSecondaryStructure.sqf"], ["InitRadar.sqf", "AddDeleteAction.sqf"],_type,0,0,0]];
stAAradarLR = _type;
_type = _type + 1;


if ( AcreAllowed ) then
{
	structDefs set [_type, ["Relay Station", 600, siBoth, false, false, 5, 5, 20, [["Land_TBox_F", 90, [],[0,0,1]],["Land_TTowerSmall_2_F", 90, [],[0,0,1]]], [["Land_TBox_F", 90, [],[0,0,1]],["Land_TTowerSmall_2_F", 90, [],[0,0,1]]], ["InitPrimaryStructure.sqf", "InitRelay.sqf"], [],_type,0,0,0]];
	_type = _type + 1;
};

_st_mg_pod = stNone;
if ( isClass (configFile >> "cfgVehicles" >> "B_HMG_01_F") && isClass (configFile >> "cfgVehicles" >> "O_HMG_01_F")) then
{
	structDefs set [_type, ["Mk30 HMG .50", 250, siBoth, false, false, 5, 4, 2.5, [["B_HMG_01_F", 0, []]], [["O_HMG_01_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf", "AddKickoutCrewAction.sqf"],_type,15,0,0] ];
	structsFloat set [count structsFloat, _type];
	_st_mg_pod = _type;
	_type = _type + 1;
};
_st_mg_pod2 = stNone;
if ( isClass (configFile >> "cfgVehicles" >> "B_HMG_01_high_F") && isClass (configFile >> "cfgVehicles" >> "O_HMG_01_high_F")) then
{
	structDefs set [_type, ["Mk30 HMG .50 (raised)", 250, siBoth, false, false, 5, 4, 2.5, [["B_HMG_01_high_F", 0, []]], [["O_HMG_01_high_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf", "AddKickoutCrewAction.sqf"],_type,15,0,0] ];
	structsFloat set [count structsFloat, _type];
	_st_mg_pod2 = _type;
	_type = _type + 1;
};
_st_mg_pod3 = stNone;
if ( isClass (configFile >> "cfgVehicles" >> "B_HMG_01_A_F") && isClass (configFile >> "cfgVehicles" >> "O_HMG_01_A_F")) then
{
	structDefs set [_type, ["Mk30A HMG .50", 250, siBoth, false, false, 5, 4, 2.5, [["B_HMG_01_A_F", 0, []]], [["O_HMG_01_A_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf"],_type,15,0,0] ];
	structsFloat set [count structsFloat, _type];
	_st_mg_pod3 = _type;
	_type = _type + 1;
};
_st_gl_pod = stNone;
if ( isClass (configFile >> "cfgVehicles" >> "B_GMG_01_F") && isClass (configFile >> "cfgVehicles" >> "O_GMG_01_F")) then
{
	structDefs set [_type, ["Mk32 GMG 20mm", 300, siBoth, false, false, 5, 4, 2.5, [["B_GMG_01_F", 0, []]], [["O_GMG_01_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf", "AddKickoutCrewAction.sqf"],_type,20,0,0] ];
	structsFloat set [count structsFloat, _type];
	_st_gl_pod = _type;
	_type = _type + 1;
};
_st_gl_pod2 = stNone;
if ( isClass (configFile >> "cfgVehicles" >> "B_GMG_01_high_F") && isClass (configFile >> "cfgVehicles" >> "O_GMG_01_high_F")) then
{
	structDefs set [_type, ["Mk32 GMG 20mm (raised)", 300, siBoth, false, false, 5, 4, 2.5, [["B_GMG_01_high_F", 0, []]], [["O_GMG_01_high_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf", "AddKickoutCrewAction.sqf"],_type,20,0,0] ];
	structsFloat set [count structsFloat, _type];
	_st_gl_pod2 = _type;
	_type = _type + 1;
};
_st_gl_pod3 = stNone;
if ( isClass (configFile >> "cfgVehicles" >> "B_GMG_01_A_F") && isClass (configFile >> "cfgVehicles" >> "O_GMG_01_A_F")) then
{
	structDefs set [_type, ["Mk32A GMG 20mm", 300, siBoth, false, false, 5, 4, 2.5, [["B_GMG_01_A_F", 0, []]], [["O_GMG_01_A_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf"],_type,20,0,0] ];
	structsFloat set [count structsFloat, _type];
	_st_gl_pod3 = _type;
	_type = _type + 1;
};

_st_aa_pod = stNone;
if ( isClass (configFile >> "cfgVehicles" >> "B_static_AA_F") && isClass (configFile >> "cfgVehicles" >> "O_static_AA_F")) then
{
	structDefs set [_type, ["Static Titan Launcher (AA)", 1000*AntiAirPodFactor, siBoth, false, false, 5, 4, 2.5, [["B_static_AA_F", 0, []]], [["O_static_AA_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf", "AddKickoutCrewAction.sqf"],_type,60,0,0] ];
	structsFloat set [count structsFloat, _type];
	_st_aa_pod = _type;
	_type = _type + 1;
};

_st_at_pod = stNone;
if ( isClass (configFile >> "cfgVehicles" >> "B_static_AT_F") && isClass (configFile >> "cfgVehicles" >> "O_static_AT_F")) then
{
	structDefs set [_type, ["Static Titan Launcher (AT)", 1500*AntiTankPodFactor, siBoth, false, false, 5, 4, 2.5, [["B_static_AT_F", 0, []]], [["O_static_AT_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf", "AddKickoutCrewAction.sqf"],_type,60,0,0] ];
	structsFloat set [count structsFloat, _type];
	_st_a_pod = _type;
	_type = _type + 1;
};

if ( ArtyAllowed > 0 && isClass (configFile >> "cfgVehicles" >> "B_Mortar_01_F") && isClass (configFile >> "cfgVehicles" >> "O_Mortar_01_F")) then
{
	structDefs set [_type, ["Mk6 Mortar", 5000*ArtyAllowed, siBoth, false, false, 5, 4, 2.5, [["B_Mortar_01_F", 0, []]], [["O_Mortar_01_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf", "AddKickoutCrewAction.sqf"],_type,300,0,300] ];
	structsFloat set [count structsFloat, _type];
	_type = _type + 1;
};

structDefs set [_type, ["Wall", 150, siBoth, false, false, 50, 2, 10, [["Land_HBarrierBig_F", 0, []]], [["Land_HBarrierBig_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf"],_type,0,0,0]];
stWall = _type;
_type = _type + 1;

structDefs set [_type, ["Heli H", 10, siBoth, false, false, 10, 5, 15, [["Land_HelipadSquare_F", 0, []]], [["Land_HelipadSquare_F", 0, []]], ["InitSecondaryStructure.sqf", "InitHeliH.sqf"], ["AddDeleteAction.sqf"],_type,0,0,0]];
_heliH = _type;
_type = _type + 1;

_heliHL = _heliH;
if ( isClass(configFile >> "cfgVehicles" >> "PortableHelipadLight_01_red_F") && isClass(configFile >> "cfgVehicles" >> "Windsock_01_F")) then
{
	structDefs set [_type, ["Heli H (Lights)", 10, siBoth, false, false, 10, 5, 15, [["Land_HelipadSquare_F", 0, []],
	["PortableHelipadLight_01_red_F", 0,[-7,-7,0]],
	["PortableHelipadLight_01_red_F", 0,[7,-7,0]],
	["PortableHelipadLight_01_red_F", 0,[-7,7,0]],
	["PortableHelipadLight_01_red_F", 0,[7,7,0]],
	["Windsock_01_F", 0,[10,10,0]]],
	[["Land_HelipadSquare_F", 0, []],
	["PortableHelipadLight_01_red_F", 0,[-7,-7,0]],
	["PortableHelipadLight_01_red_F", 0,[7,-7,0]],
	["PortableHelipadLight_01_red_F", 0,[-7,7,0]],
	["PortableHelipadLight_01_red_F", 0,[7,7,0]],
	["Windsock_01_F", 0,[10,10,0]]], ["InitSecondaryStructure.sqf", "InitHeliH.sqf"], ["AddDeleteAction.sqf"],_type,0,0,0]];
	_heliHL = _type;
	_type = _type + 1;
};

structDefs set [_type, ["Razorwire", 20, siBoth, false, false, 10, 5, 15, [["Land_Razorwire_F", 0, []]], [["Land_Razorwire_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf"],_type,0,0,0]];
_type = _type + 1;

structDefs set [_type, ["Bag Fence", 40, siBoth, false, false, 10, 5, 15, [["Land_BagFence_Long_F", 0, []]], [["Land_BagFence_Long_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf"],_type,0,0,0]];
_type = _type + 1;

structDefs set [_type, ["Bag Fence (round)", 40, siBoth, false, false, 10, 5, 15, [["Land_BagFence_Round_F", 180, []]], [["Land_BagFence_Round_F", 180, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf"],_type,0,0,0]];
_type = _type + 1;

structDefs set [_type, ["Small Bag Bunker", 100, siBoth, false, false, 10, 5, 15, [["Land_BagBunker_Small_F", 180, []]], [["Land_BagBunker_Small_F", 180, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf"],_type,0,0,0]];
_type = _type + 1;

structDefs set [_type, ["Camo Net Large", 20, siBoth, true, false, 10, 0, 15, [["CamoNet_BLUFOR_big_F", 0, []]], [["CamoNet_OPFOR_big_F", 0, []]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf"],_type,0,0,0]];
_camoNetLarge = _type;
_type = _type + 1;

structDefs set [_type, ["Lights", 10, siBoth, true, true, 10, 5, 15, [["Land_LampHalogen_F", 90, [],[0,0,1]]], [["Land_LampHalogen_F", 90, [],[0,0,1]]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf"],_type,0,0,0]];
_lights = _type;
_type = _type + 1;

structDefs set [_type, ["Live Feed Display", 100, siBoth, false, false, 10, 5, 15, [["Land_Billboard_F", 0, [],[0,0,1]]], [["Land_Billboard_F", 0, [],[0,0,1]]], ["InitSecondaryStructure.sqf"], ["AddDeleteAction.sqf", "InitLiveFeed.sqf"],_type,0,0,0]];
_type = _type + 1;

_chill =
[["Land_CampingTable_F", 0,[0,0,0]],
["Land_Sink_F", 0, [3,4,0]],
["Land_CampingChair_V2_F", 94,[1.5,0,0]],
["Land_CampingChair_V2_F", -93,[-1.5,0,0]],
["Land_CampingChair_V2_F", 2,[0.5,0.75,0]],
["Land_CampingChair_V2_F", -3,[-0.5,0.75,0]],
["Land_CampingChair_V2_F", 182,[0.5,-0.75,0]],
["Land_CampingChair_V2_F", 183,[-0.5,-0.75,0]],
["Land_Camping_Light_F", 0,[0,0,1.0]],
["Land_CampingTable_F", 0,[0,-3,0]],
["Land_CampingChair_V2_F", 94,[1.5,-3,0]],
["Land_CampingChair_V2_F", -93,[-1.5,-3,0]],
["Land_CampingChair_V2_F", 2,[0.5,-3 + 0.75,0]],
["Land_CampingChair_V2_F", -3,[-0.5,-3 + 0.75,0]],
["Land_CampingChair_V2_F", 182,[0.5,-3 -0.75,0]],
["Land_CampingChair_V2_F", 183,[-0.5,- 3-0.75,0]],
["Land_Camping_Light_F", 0,[0,-3,1.0]],

["Fridge_01_closed_F", 0,[1.5,4,0]],
["Fridge_01_closed_F", 0,[0.9,4,0]],
["Land_Portable_generator_F", 0,[0.9,5,0]],
["Land_TablePlastic_01_F", 0,[-2.0,4,0]],
["Land_WaterCooler_01_new_F",0, [-0.0,4,0.0]],
["Land_WaterCooler_01_new_F", 0,[-0.5,4,0.0]],
["Land_FlatTV_01_F", -20,[-2.5,4.2,1.0]],
["Land_Camping_Light_F", 0,[-1.7,4,1.0]],
["Land_Garbage_square5_F",0, [0,0,0.0]],
["Land_WheelieBin_01_F", 0,[-3.7,4,0.0]],
["Land_ClutterCutter_large_F", 0,[-3,-3,0.0]],
["Land_ClutterCutter_large_F", 0,[3,-3,0.0]],
["Land_ClutterCutter_large_F", 0,[-3,3,0.0]],
["Land_ClutterCutter_large_F", 0,[3,3,0.0]],
["Land_ClutterCutter_large_F", 0,[0,0,0.0]],
["Land_FieldToilet_F",180, [-4,6,0.0]],
["Land_Noticeboard_F",0, [-4,-6,0.0]],
["Land_PartyTent_01_F", 0, [0,0,0]]
];

structDefs set [_type, ["Tactical Chillout Zone", 100, siBoth, false, false, 10, 5, 15, _chill, _chill, ["InitSecondaryStructure.sqf", "InitChillout.sqf"], ["InitChillout.sqf","AddDeleteAction.sqf"],_type,0,0,0]];
_type = _type + 1;

structMatrix = [ [], [] ];
structsBuilt = [ [], [] ];
structTimes = [ [], [] ];

_index = 0;
_count = count structDefs;

for [ {_index=0}, {_index<(count structDefs)}, {_index=_index+1}] do
{
	(structMatrix select siWest) set [_index, []];
	(structMatrix select siEast) set [_index, []];
	(structsBuilt select siWest) set [_index, 0];
	(structsBuilt select siEast) set [_index, 0];
	(structTimes select siWest) set [_index, 0];
	(structTimes select siEast) set [_index, 0];
};

structsRespawn = [stComm, stBarracks, stLight, stHeavy, stAir, stMarina];
structsCritical = [stBarracks, stLight, stHeavy, stComm, stAir];
structsFactory = [stBarracks, stLight, stHeavy, stAir, stMarina];

structsAcronyms = [];
structsAcronyms set [stComm, "CC"];
structsAcronyms set [stBarracks, "B"];
structsAcronyms set [stLight, "LF"];
structsAcronyms set [stHeavy, "HF"];
structsAcronyms set [stAir, "AF"];
structsAcronyms set [stMarina, "MA"];

structsMarkers = ["mil_dot", "mil_warning"];

// do server stuff only
if ( isServer) then
{

	// BASE TEMPLATES
	// format [type, timeBuild, posRelMhq, dirBuilder]
	// dirBuilder is the direction the builder faces when building the structure
	// use negative timeBuild values to let AI comm decide by current income/money
	// e.g. -2 = build if income/totalmoney twice the average price of units/vehicles in factory

	bdType = 0;
	bdTime = 1;
	bdPos = 2;
	bdDir = 3;
	bdFindEmpty = 4;
	bdNightOnly = 5;

	baseDefs = [];

	_base = [];
	_prims = [];

	_prims set [count _prims, [stBarracks, 0, [-50, 0], 90, true, false]];
	_prims set [count _prims, [stComm, 0, [10, 25], 90, true, false]];
	_prims set [count _prims, [stLight, 0, [50, 0], 270, true, false]];
	_prims set [count _prims, [stHeavy, -1.0, [50, -50], 0, true, false]];
	_prims set [count _prims, [stAir, -1.0, [0, 50], 0, true, false]];
	_prims set [count _prims, [stHeavy, -3.0, [-50, -50], 0, true, false]];
	_base set [0, _prims];

	_secs = [];
	_secs set [count _secs, [_camoNetLarge, 0, [0, 0], 90, false, false]];
	_secs set [count _secs, [_lights, 1*60, [-30, -30], 45, false, true]];
	_secs set [count _secs, [_lights, 1*60, [30, -30], 315, false, true]];
	_secs set [count _secs, [_lights, 1*60, [-30, 30], 135, false, true]];
	_secs set [count _secs, [_lights, 1*60, [30, 30], 225, false, true]];

	_secs set [count _secs, [stwall, 1, [5, 0], 90, false, false]];
	_secs set [count _secs, [stwall, 1, [-7, 0], 90, false, false]];
	_secs set [count _secs, [stwall, 1, [0, 5], 0, false, false]];
	_secs set [count _secs, [stwall, 1, [0, -13], 0, false, false]];
	_secs set [count _secs, [_heliHL, 10*60, [-75, 40], 270, true, false]];
	_secs set [count _secs, [_heliHL, 10*60, [75, 40], 90, true, false]];
	_secs set [count _secs, [_heliHL, 10*60, [-50, 75], 270, true, false]];
	_secs set [count _secs, [_heliHL, 10*60, [50, 75], 90, true, false]];
	_secs set [count _secs, [stAARadar, 60*60, [150, 150], 0, true, false]];

	if (_st_mg_pod != stNone ) then
	{
		_secs set [count _secs, [_st_mg_pod, 15*60, [125, 0], 90, true, false]];
		_secs set [count _secs, [_st_mg_pod, 15*60, [-125, 0], 330, true, false]];
		_secs set [count _secs, [_st_mg_pod, 15*60, [0, -120], 180, true, false]];
		_secs set [count _secs, [_st_mg_pod, 15*60, [0, 120], 0, true, false]];
	};

	if ( _st_aa_pod != stNone ) then
	{
		_secs set [count _secs, [_st_aa_pod, 25*60, [-100, 100], 315, true, false]];
		_secs set [count _secs, [_st_aa_pod, 25*60, [100, 100], 45, true, false]];
		_secs set [count _secs, [_st_aa_pod, 25*60, [-100, -100], 225, true, false]];
		_secs set [count _secs, [_st_aa_pod, 25*60, [100, -100], 135, true, false]];
	};
	if ( _st_at_pod != stNone ) then
	{
		_secs set [count _secs, [_st_at_pod, 25*60, [-125, 125], 315, true, false]];
		_secs set [count _secs, [_st_at_pod, 25*60, [125, 125], 45, true, false]];
		_secs set [count _secs, [_st_at_pod, 25*60, [-125, -125], 225, true, false]];
		_secs set [count _secs, [_st_at_pod, 25*60, [125, -125], 135, true, false]];
	};

	_base set [1, _secs];

	baseDefs set [count baseDefs, _base];
};

