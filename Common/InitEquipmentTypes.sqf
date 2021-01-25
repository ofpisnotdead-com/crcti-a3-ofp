edName = 0;
edCost = 1;
edSides = 2;
edSlotType = 3;
edSlots = 4;
edObject = 5;
edIsAutoMag = 6;

cdName = 0;
cdCost = 1;
cdSides = 2;
cdObject = 3;

// inventory slot types;
isGeneral = 0;
isHandgun = 1;
isOptics = 2;
isEquipment = 3;

wdName = 0;
wdCost = 1;
wdSides = 2;
wdType = 3;
wdObject = 4;
wdAmmoTypes = 5;

// weapon types
wtPrimary = 0;
wtPrimaryOnly = 1;
wtSecondary = 2;
wtHandgun = 3;

// ACRE
AcreRadioClasses = ["ACRE_PRC148", "ACRE_PRC148_UHF", "ACRE_PRC152", "ACRE_PRC343", "ACRE_PRC119",
"ACRE_PRC117F", "ACRE_MC220R", "ACE_ANPRC77", "ACE_PRC119", "ACE_PRC119_MAR",
"ACE_PRC119_ACU", "ACE_P159_RD90", "ACE_P159_RD54", "ACE_P159_RD99", "ACE_P168_RD90",
"tf_pnr1000a", "tf_anprc154", "tf_rf7800str", "tf_fadak", "tf_anprc148jem", "tf_anprc152",
"tf_mr3000", "tf_anprc155", "tf_rt1523g", "tf_mr6000l", "tf_anarc164", "tf_anarc210"];

publicVariable "AcreRadioClasses";

_classRadioWest = "ItemRadio";
_classRadioEast = "ItemRadio";

if ( AcreAllowed ) then
{
	_classRadioWest = "ACRE_PRC148";
	_classRadioEast = "ACRE_PRC148";
};

if ( TFRAllowed ) then
{
	_classRadioWest = "tf_anprc152";
	_classRadioEast = "tf_fadak";
};

// addon specific equipment used in scripts
magMine = "Mine";
ammoMine = "Mine";
magTimeBomb = "TimeBomb";
magSatchel = "PipeBomb";
weaponPut = "Put";
cargoCarWest = [];
cargoCarEast = [];
cargoTruckWest = [];
cargoTruckEast = [];

weaponsRespawnPlayerWest = ["rhs_weap_m16a4_imod", "rhsusf_weap_m9", "rhs_weap_M136","Binocular", "NVGoggles"];
weaponsRespawnPlayerEast = ["arifle_Katiba_ARCO_pointer_F", "hgun_Rook40_F", "launch_RPG32_F","Binocular", "NVGoggles"];

magsRespawnPlayerWest = [
  "rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag",
  "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP",
  "rhs_mag_an_m8hc", "rhs_mag_m67", "rhs_mag_m67",
  "rhs_m136_mag"
];

magsRespawnPlayerEast = ["30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green_mag_Tracer", "30Rnd_65x39_caseless_green_mag_Tracer", "16Rnd_9x21_Mag", "16Rnd_9x21_Mag", "16Rnd_9x21_Mag", "HandGrenade", "HandGrenade", "SmokeShell", "SmokeShellRed", "SmokeShellOrange", "SmokeShellYellow", "Chemlight_red", "Chemlight_red","RPG32_F","RPG32_F"];

assignedItemsRespawnPlayerWest = ["ItemMap", "ItemCompass", "ItemWatch", _classRadioWest];
assignedItemsRespawnPlayerEast = ["ItemMap", "ItemCompass", "ItemWatch", _classRadioEast];

itemsRespawnPlayerWest = ["FirstAidKit","FirstAidKit", "rhsusf_acc_anpeq15A", "rhsusf_acc_ACOG_USMC"];
itemsRespawnPlayerEast = ["FirstAidKit","FirstAidKit"];

backPackRespawnPlayerWest = "rhsusf_falconii_coy";
backPackRespawnPlayerEast = "B_AssaultPack_khk";

if ( GPSAvailable > 0 ) then
{
	assignedItemsRespawnPlayerWest = assignedItemsRespawnPlayerWest + ["ItemGPS"];
	assignedItemsRespawnPlayerEast = assignedItemsRespawnPlayerEast + ["ItemGPS"];
};

weaponsRespawnPlayer = [ weaponsRespawnPlayerWest, weaponsRespawnPlayerEast];
weaponsRespawnAI = [ weaponsRespawnPlayerWest, weaponsRespawnPlayerEast];

magsRespawnPlayer = [ magsRespawnPlayerWest, magsRespawnPlayerEast];
magsRespawnAI = [ magsRespawnPlayerWest, magsRespawnPlayerEast];

assignedItemsRespawnPlayer = [assignedItemsRespawnPlayerWest, assignedItemsRespawnPlayerEast];
assignedItemsRespawnAI = [assignedItemsRespawnPlayerWest, assignedItemsRespawnPlayerEast];

itemsRespawnPlayer = [itemsRespawnPlayerWest, itemsRespawnPlayerEast];
itemsRespawnAI = [itemsRespawnPlayerWest, itemsRespawnPlayerEast];

backPacksRespawnPlayer = [backPackRespawnPlayerWest, backPackRespawnPlayerEast];
backPacksRespawnAI = [backPackRespawnPlayerWest, backPackRespawnPlayerEast];

// Default equipment for Equipment Menu "Clear"
defaultWeapons = [["Binocular", "NVGoggles"],["Binocular", "NVGoggles"]];
defaultUniform = ["rhs_uniform_FROG01_wd","rhs_uniform_vdv_emr"];
defaultVest = ["rhsusf_mbav_light", "V_TacVest_khk"];
defaultBackPack = ["rhsusf_falconii_coy","B_AssaultPack_khk"];
defaultHeadgear = ["rhsusf_lwh_helmet_marpatwd", "H_HelmetLeaderO_ocamo"];
defaultGoggles = ["rhs_googles_yellow", "G_Combat"];
defaultAssignedItems = [["ItemMap", "ItemCompass", "ItemWatch", "ItemGPS", _classRadioWest],["ItemMap", "ItemCompass", "ItemWatch", "ItemGPS",_classRadioEast]];
defaultItems = [["FirstAidKit"],["FirstAidKit"]];

// EQUIP (ammo followed by equipment)
// IMPORTANT - primary and secondary mag names must be same as weapon name to make template names look good

if ( isServer ) then
{
	startLoadingScreen["Populating Equipmentlist.","RscDisplayLoadMission"];
	equipDefs = [];
	weaponDefs = [];
	clothesDefs = [];

	if ( !AutoEquipmentList ) then
	{
		_type = 0;

		// WEST AMMO
		_SMAW_SPOTTING = [];
		_G3Mag = [];
		_G36Tracer = [];
		if ( AceModelsAllowed ) then
		{
			equipDefs set [_type, ["SMAW Spotting",5, siWest, isHandgun, 1, "ACE_SMAW_Spotting" ]];
			_SMAW_SPOTTING = _type;
			_type = _type + 1;

			equipDefs set [_type, ["G36 Tracer",18, siWest, isGeneral, 1, "ACE_30Rnd_556x45_T_G36" ]];
			_G36Tracer = _type;
			_type = _type + 1;

			equipDefs set [_type, ["G3",15, siWest, isGeneral, 1, "ACE_20Rnd_762x51_B_G3" ]];
			_G3Mag = _type;
			_type = _type + 1;

		};

		equipDefs set [_type, ["74Slug",15, siWest, isGeneral, 1, "8Rnd_B_Beneli_74Slug" ]];
		_74SlugW = _type;
		_type = _type + 1;

		equipDefs set [_type, ["74Slug",15, siEast, isGeneral, 1, "8Rnd_B_Saiga12_74Slug" ]];
		_74SlugE = _type;
		_type = _type + 1;

		equipDefs set [_type, ["BetaCMAG",55, siWest, isGeneral, 1, "100Rnd_556x45_BetaCMag" ]];
		_BetaCMAG = _type;
		_type = _type + 1;

		equipDefs set [_type, ["G36",15, siWest, isGeneral, 1, "30Rnd_556x45_G36" ]];
		_G36 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["G36SD",25, siWest, isGeneral, 1, "30Rnd_556x45_G36SD" ]];
		_G36SD = _type;
		_type = _type + 1;

		equipDefs set [_type, ["M4",10, siWest, isGeneral, 1, "30Rnd_556x45_Stanag" ]];
		_M4 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["M4SD",20, siWest, isGeneral, 1, "30Rnd_556x45_StanagSD" ]];
		_M4SD = _type;
		_type = _type + 1;

		equipDefs set [_type, ["M240",100, siWest, isGeneral, 2, "100Rnd_762x51_M240"]];
		_M240 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["M249",90, siWest, isGeneral, 2, "200Rnd_556x45_M249" ]];
		_M249 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["DNR",25, siWest, isGeneral, 1, "20Rnd_762x51_DMR" ]];
		_DMR = _type;
		_type = _type + 1;

		equipDefs set [_type, ["HMR",10, siBoth, isGeneral, 1, "5x_22_LR_17_HMR" ]];
		_HMR = _type;
		_type = _type + 1;

		equipDefs set [_type, ["107 10rds",80, siWest, isGeneral, 1, "10Rnd_127x99_M107"]];
		_M107 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["M24",45, siWest, isGeneral, 1, "5Rnd_762x51_M24" ]];
		_M24 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["MP5",10, siWest, isGeneral, 1, "30Rnd_9x19_MP5"]];
		_atMP5 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["MP5SD",20, siWest, isGeneral, 1, "30Rnd_9x19_MP5SD"]];
		_atMP5SD = _type;
		_type = _type + 1;

		equipDefs set [_type, ["M136",100, siWest, isGeneral, 2, "M136" ]];
		_atM136 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMAWDP",100, siWest, isGeneral, 2, "SMAW_HEDP" ]];
		_SMAW_HEDP = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMAWAA",150, siWest, isGeneral, 2, "SMAW_HEAA" ]];
		_SMAW_HEAA = _type;
		_type = _type + 1;

		equipDefs set [_type, ["JAVELIN",275, siWest, isGeneral, 6, "Javelin"]];
		_atJAVELIN = _type;
		_type = _type + 1;

		equipDefs set [_type, ["STINGER",200, siWest, isGeneral, 6, "STINGER"]];
		_atStinger = _type;
		_type = _type + 1;

		equipDefs set [_type, ["M9",5, siWest, isHandgun, 1, "15Rnd_9x19_M9" ]];
		_atM9 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["M9SD",5, siWest, isHandgun, 1, "15Rnd_9x19_M9SD" ]];
		_atM9SD = _type;
		_type = _type + 1;

		// EAST ammo
		equipDefs set [_type, ["RPK",10, siEast, isGeneral, 1, "75Rnd_545x39_RPK" ]];
		_RPK = _type;
		_type = _type + 1;

		equipDefs set [_type, ["VSS",10, siEast, isGeneral, 1, "20Rnd_9x39_SP5_VSS" ]];
		_VSS = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Bizon",10, siEast, isGeneral, 1, "64Rnd_9x19_Bizon" ]];
		_Bizon = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Bizon SD",10, siEast, isGeneral, 1, "64Rnd_9x19_SD_Bizon" ]];
		_Bizonsd = _type;
		_type = _type + 1;

		equipDefs set [_type, ["AK 47",10, siEast, isGeneral, 1, "30Rnd_762x39_AK47" ]];
		_AK47 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["AK74",10, siEast, isGeneral, 1, "30Rnd_545x39_AK"]];
		_AK74 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["AK74SD",10, siEast, isGeneral, 1, "30Rnd_545x39_AKSD"]];
		_AK74SD = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SVD",45, siEast, isGeneral, 1, "10Rnd_762x54_SVD"]];
		_SVD = _type;
		_type = _type + 1;

		equipDefs set [_type, ["KSVK",90, siEast, isGeneral, 1, "5Rnd_127x108_KSVK" ]];
		_KSVK = _type;
		_type = _type + 1;

		equipDefs set [_type, ["PK",100, siEast, isGeneral, 2, "100Rnd_762x54_PK" ]];
		_PK = _type;
		_type = _type + 1;

		equipDefs set [_type, ["PG7V",200, siEast, isGeneral, 2, "PG7V" ]];
		_atPG7V = _type;
		_type = _type + 1;

		equipDefs set [_type, ["PG7VR",250, siEast, isGeneral, 2, "PG7VR" ]];
		_atPG7VR = _type;
		_type = _type + 1;

		equipDefs set [_type, ["PG7VL",220, siEast, isGeneral, 2, "PG7VL" ]];
		_atPG7VL = _type;
		_type = _type + 1;

		equipDefs set [_type, ["RPG18",150, siEast, isGeneral, 2, "RPG18" ]];
		_atRPG18 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["OG7",120, siEast, isGeneral, 2, "OG7" ]];
		_atOG7 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["metis",350, siEast, isGeneral, 2, "AT13" ]];
		_atmetis = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Strela",300, siEast, isGeneral, 6, "Strela"]];
		_atStrela = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Igla",350, siEast, isGeneral, 3, "Igla" ]];
		_atIgla = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Makarov",5, siEast, isHandgun, 1, "8Rnd_9x18_Makarov" ]];
		_atMakarov = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Makarov",5, siEast, isHandgun, 1, "8Rnd_9x18_MakarovSD" ]];
		_atMakarovSD = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Colt",35, siBoth, isHandgun, 1, "7Rnd_45ACP_1911" ]];
		_Colt = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Rifle Grenade",30, siWest, isHandgun, 1, "1Rnd_HE_M203" ]];
		_HEGrenadeW = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Rifle Grenade",30, siEast, isHandgun, 1, "1Rnd_HE_GP25"]];
		_HEGrenadeE = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Flare",15, siWest, isHandgun, 1, "FlareWhite_M203"]];
		_atFlareW = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Flare",15, siEast, isHandgun, 1, "FlareWhite_GP25" ]];
		_atFlareE = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Flare Green",15, siWest, isHandgun, 1, "FlareGreen_M203" ]];
		_atFlareGreenW = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Flare Green",15, siEast, isHandgun, 1, "FlareGreen_GP25" ]];
		_atFlareGreenE = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Flare Red",15, siWest, isHandgun, 1, "FlareRed_M203"]];
		_atFlareRedW = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Flare Red",15, siEast, isHandgun, 1, "FlareRed_GP25" ]];
		_atFlareRedE = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Flare Yellow",15, siWest, isHandgun, 1, "FlareYellow_M203" ]];
		_atFlareYellowW = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Flare Yellow",15, siEast, isHandgun, 1, "FlareYellow_GP25" ]];
		_atFlareYellowE = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMOKE GP25",15, siEast, isHandgun, 1, "1Rnd_SMOKE_GP25" ]];
		_atSMOKEGP25 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMOKE GREEN GP25",15, siEast, isHandgun, 1, "1Rnd_SMOKEGREEN_GP25" ]];
		_atSMOKEGREENGP25 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMOKE RED GP25",15, siEast, isHandgun, 1, "1Rnd_SMOKERED_GP25" ]];
		_atSMOKEredGP25 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMOKE YELLOW GP25",15, siEast, isHandgun, 1, "1Rnd_SMOKEYELLOW_GP25" ]];
		_atSMOKEYELLOWGP25 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMOKE 203",15, siEast, isHandgun, 1, "1Rnd_SMOKE_M203" ]];
		_atSMOKE203 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMOKE GREEN 203",15, siEast, isHandgun, 1, "1Rnd_SMOKEGREEN_M203" ]];
		_atSMOKEGREEN203 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMOKE RED 203",15, siEast, isHandgun, 1, "1Rnd_SMOKERED_M203" ]];
		_atSMOKEred203 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["SMOKE YELLOW 203",15, siEast, isHandgun, 1, "1Rnd_SMOKEYELLOW_M203" ]];
		_atSMOKEYELLOW203 = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Laser",75, siBoth, isGeneral, 1, "Laserbatteries" ]];
		_atLaser = _type;
		_type = _type + 1;

		firstEquip = _type;

		equipDefs set [_type, ["Binoculars",40, siBoth, isOptics, 1, "Binocular"]];
		_type = _type + 1;

		equipDefs set [_type, ["NV Goggles",45, siBoth, isOptics, 1, "NVGoggles"]];
		_type = _type + 1;

		equipDefs set [_type, ["Hand Grenade",25, siBoth, isHandgun, 1, "HandGrenade" ]];
		_type = _type + 1;

		equipDefs set [_type, ["Mine",55, siBoth, isGeneral, 2, magMine ]];
		etMine = _type;
		_type = _type + 1;

		equipDefs set [_type, ["Satchel",80, siBoth, isGeneral, 2, "Pipebomb" ]];
		_type = _type + 1;

		//equipDefs set [_type, ["TimeBomb",80, siBoth, isGeneral, 2, magTimeBomb]];
		//_type = _type + 1;

		equipDefs set [_type, ["Smoke Shell",15, siBoth, isHandgun, 1, "SmokeShell" ]];
		_type = _type + 1;

		equipDefs set [_type, ["Smoke Shell Green",15, siBoth, isHandgun, 1, "SmokeShellGreen" ]];
		_type = _type + 1;

		equipDefs set [_type, ["Smoke Shell Red",15, siBoth, isHandgun, 1, "SmokeShellRed" ]];
		_type = _type + 1;

		if ( AceWoundingEnabled > 0 ) then
		{
			equipDefs set [_type, ["Small Bandage",5, siBoth, isHandgun, 1, "ACE_Bandage" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Large Bandage",5, siBoth, isHandgun, 1, "ACE_LargeBandage" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Tourniquet",5, siBoth, isHandgun, 1, "ACE_Tourniquet" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Morphine",5, siBoth, isHandgun, 1, "ACE_Morphine" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Epinephrine",5, siBoth,isHandgun, 1, "ACE_Epinephrine" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Splint",5, siBoth, isHandgun, 1, "ACE_Splint" ]];
			_type = _type + 1;
			equipDefs set [_type, ["IV",15, siBoth, isHandgun, 1, "ACE_IV" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Plasma",30, siBoth, isHandgun, 1, "ACE_Plasma" ]];
			_type = _type + 1;
		};

		if ( AceModelsAllowed ) then
		{
			equipDefs set [_type, ["Earplugs",1, siBoth, isEquipment, 1, "ACE_Earplugs" ]];
			_type = _type + 1;

			equipDefs set [_type, ["Sunglasses",10, siBoth, isEquipment, 1, "ACE_GlassesSunglasses" ]];
			_type = _type + 1;

			equipDefs set [_type, ["Tactical Googles",10, siBoth, isEquipment, 1, "ACE_GlassesTactical" ]];
			_type = _type + 1;

			equipDefs set [_type, ["Parachute",200, siBoth, isEquipment, 1, "ACE_ParachutePack" ]];
			_type = _type + 1;

			equipDefs set [_type, ["Chemlight Red",2, siBoth, isHandgun, 1, "ACE_Knicklicht_R" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Chemlight White",2, siBoth, isHandgun, 1, "ACE_Knicklicht_W" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Chemlight Green",2, siBoth, isHandgun, 1, "ACE_Knicklicht_G" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Chemlight Yellow",2, siBoth, isHandgun, 1, "ACE_Knicklicht_Y" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Chemlight Blue",2, siBoth, isHandgun, 1, "ACE_Knicklicht_B" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Chemlight IR",2, siBoth, isHandgun, 1, "ACE_Knicklicht_IR" ]];
			_type = _type + 1;
			equipDefs set [_type, ["Map tools",5, siBoth, isEquipment, 1, "ACE_Map_Tools" ]];
			_type = _type + 1;

		};

		equipDefs set [_type, ["Map",5, siBoth, isEquipment, 1, "ItemMap" ]];
		_type = _type + 1;
		equipDefs set [_type, ["Compass",5, siBoth, isEquipment, 1, "ItemCompass" ]];
		_type = _type + 1;
		equipDefs set [_type, ["Watch",5, siBoth, isEquipment, 1, "ItemWatch" ]];
		_type = _type + 1;
		equipDefs set [_type, ["Radio",5, siWest, isEquipment, 1, _classRadioWest ]];
		_type = _type + 1;
		equipDefs set [_type, ["Radio",5, siEast, isEquipment, 1, _classRadioEast ]];
		_type = _type + 1;

		if ( GPSAvailable > 0 ) then
		{
			equipDefs set [_type, ["GPS",5, siBoth, isEquipment, 1, "ItemGPS" ]];
			_type = _type + 1;
		};

		// WEAPONS

		_type = 0;

		///////RIFLES////////////
		//////////WEST////////////////
		//////////////////////////////
		weaponDefs set [_type, ["ShotGun",100, siWest, wtPrimary, "M1014", [[_74SlugW,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M4A1",110, siWest, wtPrimary, "M4A1", [[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,4],[_M4SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M4A1 Aim",130, siWest, wtPrimary, "M4A1_Aim", [[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,4],[_M4SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M4A1 Aim Camo",135, siWest, wtPrimary, "M4A1_Aim_camo", [[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,4],[_M4SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M4A1 AIM SD Camo",140, siWest, wtPrimary, "M4A1_AIM_SD_camo", [[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,0],[_M4SD,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M4A1 RCO GL",190, siWest, wtPrimary, "M4A1_RCO_GL", [[_M4,4],[_HEGrenadeW,4],[_atFlareW,0],[_atFlareGreenW,0],[_atFlareRedW,0],[_atFlareYellowW,0],[_atSMOKE203,0],[_atSMOKEYELLOW203,0],[_atSMOKERED203,0],[_atSMOKEGREEN203,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M4A1 HWS GL",190, siWest, wtPrimary, "M4A1_HWS_GL", [[_M4,0],[_M4SD,4],[_HEGrenadeW,4],[_atFlareW,0],[_atFlareGreenW,0],[_atFlareRedW,0],[_atFlareYellowW,0],[_atSMOKE203,0],[_atSMOKEYELLOW203,0],[_atSMOKERED203,0],[_atSMOKEGREEN203,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M4A1 HWS GL camo",230, siWest, wtPrimary, "M4A1_HWS_GL_camo", [[_M4,0],[_M4SD,4],[_HEGrenadeW,4],[_atFlareW,0],[_atFlareGreenW,0],[_atFlareRedW,0],[_atFlareYellowW,0],[_atSMOKE203,0],[_atSMOKEYELLOW203,0],[_atSMOKERED203,0],[_atSMOKEGREEN203,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M4A1 HWS GL SD Camo",240, siWest, wtPrimary, "M4A1_HWS_GL_SD_camo", [[_M4,0],[_M4SD,4],[_HEGrenadeW,4],[_atFlareW,0],[_atFlareGreenW,0],[_atFlareRedW,0],[_atFlareYellowW,0],[_atSMOKE203,0],[_atSMOKEYELLOW203,0],[_atSMOKERED203,0],[_atSMOKEGREEN203,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["MP5A5",75, siWest, wtPrimary, "MP5A5", [[_atMP5,4],[_atMP5SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["MP5SD",110, siWest, wtPrimary, "MP5SD", [[_atMP5,0],[_atMP5SD,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M16A4",125, siWest, wtPrimary, "m16a4",[[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,4],[_M4SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M16A4 GL",175, siWest, wtPrimary, "m16a4_GL",[[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,4],[_M4SD,0],[_HEGrenadeW,4],[_atFlareW,0],[_atFlareGreenW,0],[_atFlareRedW,0],[_atFlareYellowW,0],[_atSMOKEYELLOW203,0],[_atSMOKERED203,0],[_atSMOKEGREEN203,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M16A4 Acog",200, siWest, wtPrimary, "M16A4_ACG", [[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,4],[_M4SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M16A4 GL Acog",280, siWest, wtPrimary, "M16A4_ACG_GL", [[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,4],[_M4SD,0],[_HEGrenadeW,4],[_atFlareW,0],[_atFlareGreenW,0],[_atFlareRedW,0],[_atFlareYellowW,0],[_atSMOKE203,0],[_atSMOKEYELLOW203,0],[_atSMOKERED203,0],[_atSMOKEGREEN203,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["G36a",200, siWest, wtPrimary, "G36a", [[_BetaCMAG,0], [_G36,4], [_G36SD,0],[_M4,0],[_M4SD,0],[_G36Tracer,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["G36C",200, siWest, wtPrimary, "G36C", [[_BetaCMAG,0], [_G36,4], [_G36SD,0],[_M4,0],[_M4SD,0],[_G36Tracer,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["G36C eotech",250, siWest, wtPrimary, "G36_C_SD_eotech", [[_G36SD,0], [_G36,4],[_G36Tracer,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["G36C SD eotech",260, siWest, wtPrimary, "G36_C_SD_eotech", [[_G36SD,4], [_G36,0],[_G36Tracer,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["G36K",200, siWest, wtPrimary, "G36K", [[_BetaCMAG,0], [_G36,4], [_G36SD,0],[_M4,0],[_M4SD,0],[_G36Tracer,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M8_carbine",250, siWest, wtPrimary, "M8_carbine", [[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,4],[_M4SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M8_carbineGL",260, siWest, wtPrimary, "M8_carbineGL", [[_M4SD,4],[_HEGrenadeW,4],[_atFlareW,0],[_atFlareGreenW,0],[_atFlareRedW,0],[_atFlareYellowW,0],[_atSMOKE203,0],[_atSMOKEYELLOW203,0],[_atSMOKERED203,0],[_atSMOKEGREEN203,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M8_compact",200, siWest, wtPrimary, "M8_compact", [[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,4],[_M4SD,0]] ]];
		_type = _type + 1;

		if ( AceModelsAllowed ) then
		{
			weaponDefs set [_type, ["G3A3",200, siWest, wtPrimary, "ACE_G3A3", [[_G3Mag,4]] ]];
			_type = _type + 1;
			weaponDefs set [_type, ["G3SG1",250, siWest, wtPrimary, "ACE_G3SG1", [[_G3Mag,4]] ]];
			_type = _type + 1;
		};

		//////////EAST////////////////
		//////////////////////////////
		weaponDefs set [_type, ["ShotGun",100, siEast, wtPrimary, "Saiga12K", [[_74SlugE,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AK47M",100, siEast, wtPrimary, "AK_47_M", [[_AK47,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AK47S",100, siEast, wtPrimary, "AK_47_S",[[_AK47,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AKS_GOLD",200, siEast, wtPrimary, "AKS_GOLD", [[_AK47,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AK107 kobra",155, siEast, wtPrimary, "AK_107_kobra", [[_AK74,4],[_AK74SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AK107 GL kobra",255, siEast, wtPrimary, "AK_107_GL_kobra", [[_AK74,4],[_AK74SD,0],[_HEGrenadeE,4],[_atFlareE,0],[_atFlareGreenE,0],[_atFlareRedE,0],[_atFlareYellowE,0],[_atSMOKEGP25,0],[_atSMOKEYELLOWGP25,0],[_atSMOKEREDGP25,0],[_atSMOKEGREENGP25,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AK107 PSO",180, siEast, wtPrimary, "AK_107_pso", [[_AK74,4],[_AK74SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AK107 GL PSO",280, siEast, wtPrimary, "AK_107_GL_pso", [[_AK74,4],[_AK74SD,0],[_HEGrenadeE,4],[_atFlareE,0],[_atFlareGreenE,0],[_atFlareRedE,0],[_atFlareYellowE,0],[_atSMOKEGP25,0],[_atSMOKEYELLOWGP25,0],[_atSMOKEREDGP25,0],[_atSMOKEGREENGP25,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AK74",100, siEast, wtPrimary, "AK_74", [[_AK74,4],[_AK74SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AK74 GL",175, siEast, wtPrimary, "AK_74_GL", [[_AK74,4],[_AK74SD,0],[_HEGrenadeE,4],[_atFlareE,0],[_atFlareGreenE,0],[_atFlareRedE,0],[_atFlareYellowE,0],[_atSMOKEGP25,0],[_atSMOKEYELLOWGP25,0],[_atSMOKEREDGP25,0],[_atSMOKEGREENGP25,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AKS74 kobra",100, siEast, wtPrimary, "AKS_74_kobra", [[_AK74,4],[_AK74SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AKS74 pso",100, siEast, wtPrimary, "AKS_74_pso", [[_AK74,4],[_AK74SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AKS74 U",100, siEast, wtPrimary, "AKS_74_U", [[_AK74,0],[_AK74SD,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["AKS74 UN kobra",100, siEast, wtPrimary, "AKS_74_UN_kobra", [[_AK74,0],[_AK74SD,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["VSS",100, siEast, wtPrimary, "VSS_vintorez", [[_VSS,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["Bizon",100, siEast, wtPrimary, "Bizon", [[_Bizon,4],[_BizonSD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["Bizon SD",100, siEast, wtPrimary, "bizon_silenced", [[_Bizon,0],[_BizonSD,4]] ]];
		_type = _type + 1;
		//////////BOTH////////////////

		if ( AceModelsAllowed ) then
		{
			weaponDefs set [_type, ["Rucksack",20, siWest, wtSecondary, "ACE_Rucksack_MOLLE_Green", [] ]];
			_type = _type + 1;
			weaponDefs set [_type, ["Rucksack",20, siEast, wtSecondary, "ACE_Rucksack_EAST", [] ]];
			_type = _type + 1;
			weaponDefs set [_type, ["Wirecutter",29.95, siBoth, wtSecondary, "ACE_Wirecutter", [] ]];
			_type = _type + 1;

		};

		///////Machineguns////////////
		//////////WEST////////////////
		//////////////////////////////
		weaponDefs set [_type, ["MG36",200, siWest, wtPrimary, "MG36", [[_BetaCMAG,4], [_G36,0], [_G36SD,0],[_M4,0],[_M4SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M240",250, siWest, wtPrimaryOnly, "M240", [[_M240,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["Mk_48",250, siWest, wtPrimaryOnly, "Mk_48", [[_M240,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M249",250, siWest, wtPrimaryOnly, "M249", [[_M249,4],[_BetaCMAG,0], [_G36,0], [_G36SD,0],[_M4,0],[_M4SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M8 SAW",300, siWest, wtPrimaryOnly, "M8_SAW", [[_BetaCMAG,4], [_G36,0], [_G36SD,0],[_M4,0],[_M4SD,0]] ]];
		_type = _type + 1;

		//////////EAST////////////////
		weaponDefs set [_type, ["Pecheneg",350, siEast, wtPrimaryOnly, "Pecheneg", [[_PK,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["PK",250, siEast, wtPrimaryOnly, "PK", [[_PK,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["RPK_74",250, siEast, wtPrimaryOnly, "RPK_74", [[_RPK,4], [_AK74,0], [_AK74SD,0]] ]];
		_type = _type + 1;
		//////////BOTH////////////////

		///////SNIPER RIFLES////////////
		//////////WEST////////////////
		//////////////////////////////
		weaponDefs set [_type, ["DMR",150, siWest, wtPrimary, "DMR", [[_DMR,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M24",200, siWest, wtPrimary, "M24", [[_M24,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M40A3",220, siWest, wtPrimary, "M40A3", [[_M24,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M4SPR",250, siWest, wtPrimary, "M4SPR", [[_M4,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M107",300, siWest, wtPrimaryOnly, "m107", [[_M107,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M8",350, siWest, wtPrimary, "M8_sharpshooter", [[_BetaCMAG,4], [_G36,0], [_G36SD,0],[_M4,0],[_M4SD,0]] ]];
		_type = _type + 1;

		//////////EAST////////////////
		weaponDefs set [_type, ["SVD",250, siEast, wtPrimary, "SVD", [[_SVD,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["SVD Camo",250, siEast, wtPrimary, "SVD_CAMO", [[_SVD,4]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["KSVK",350, siEast, wtPrimaryOnly, "ksvk", [[_KSVK,4]] ]];
		_type = _type + 1;
		//////////BOTH////////////////
		weaponDefs set [_type, ["Huntingrifle",110, siBoth, wtPrimary, "Huntingrifle", [[_HMR,4]] ]];
		_type = _type + 1;

		///////PISTOLS////////////
		//////////WEST////////////////
		//////////////////////////////
		weaponDefs set [_type, ["M9",40, siWest, wtHandgun, "M9", [[_atM9,4],[_atM9SD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M9SD",45, siWest, wtHandgun, "M9SD", [[_atM9,0],[_atM9SD,4]] ]];
		_type = _type + 1;

		//////////EAST////////////////
		weaponDefs set [_type, ["Makarov",40, siEast, wtHandgun, "Makarov", [[_atMakarov,4],[_atMakarovSD,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["Makarov SD",45, siEast, wtHandgun, "MakarovSD", [[_atMakarov,0],[_atMakarovSD,4]] ]];
		_type = _type + 1;
		//////////BOTH////////////////
		weaponDefs set [_type, ["Colt",60, siBoth, wtHandgun, "Colt1911", [[_Colt,4]] ]];
		_type = _type + 1;

		///////Launchers//////////////
		//////////WEST////////////////
		//////////////////////////////

		weaponDefs set [_type, ["Javelin",1800, siWest, wtSecondary, "Javelin", [[_atJAVELIN,1]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["M136",200, siWest, wtSecondary, "M136", [[_atM136,3]] ]];
		_type = _type + 1;

		_list = [[_SMAW_HEDP,0],[_SMAW_HEAA,3]];
		if ( AceModelsAllowed ) then {_list = _list + [[_SMAW_SPOTTING,0]];};

		weaponDefs set [_type, ["SMAW",400, siWest, wtSecondary, "SMAW", _list ]];
		_type = _type + 1;

		weaponDefs set [_type, ["Stinger",350, siWest, wtSecondary, "Stinger", [[_atStinger,1]] ]];
		_type = _type + 1;

		//////////EAST////////////////

		weaponDefs set [_type, ["RPG7V",250, siEast, wtSecondary, "RPG7V", [[_atPG7V,0], [_atPG7VR,3],[_atPG7VL,0], [_atOG7,0]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["RPG18",200, siEast, wtSecondary, "RPG18", [[_atRPG18,3]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["MetisLauncher",1300, siEast, wtSecondary, "MetisLauncher", [[_atmetis,3]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["Strela",350, siEast, wtSecondary, "Strela", [[_atStrela,1]] ]];
		_type = _type + 1;

		weaponDefs set [_type, ["Igla",450, siEast, wtSecondary, "Igla", [[_atIgla,2]] ]];
		_type = _type + 1;

		/////other//////

		weaponDefs set [_type, ["Laser",80, siBoth, isOptics, "Laserdesignator", [[_atLaser,1]] ]];
		_type = _type + 1;

		//// Add Backpacks / Vests / Uniform etc. here
		_type = 0;
		clothesDefs set [_type, ["Backpack",15, siBoth, "B_AssaultPack_khk"]];
		_type = _type + 1;
		clothesDefs set [_type, ["Backpack 2",15, siBoth, "B_AssaultPack_khk"]];
		_type = _type + 1;

	}
	else
	{

		// Sort Magazines
		_cfgMags = [];
		_cfgfile = configFile >> "CfgMagazines";
		_count = count(_cfgfile);

		for [ {_i=0}, {_i<_count}, {_i=_i+1}] do
		{
			_entry = (_cfgfile) select _i;

			if ( isClass _entry ) then
			{
				_class = configName _entry;
				_scope = getNumber(_entry >> "scope");

				{
					_baseClass = configName(inheritsFrom _entry);
					if ( _baseClass == _x && _x != _class ) then
					{
						_scope = 0;
					};
				}forEach AcreRadioClasses;

				if ( _scope == 2 ) then
				{
					_name = getText(_entry >> "displayName");
					if ( _name != "" ) then
					{
						_cfgMags set [count(_cfgMags),[_class, _name, _name call funcStringHash]];
					};
				};
			};
		};

		// Sort Weapons
		_cfgWeapons = [];
		_cfgfile = configFile >> "CfgWeapons";
		_count = count(_cfgfile);

		for [ {_i=0}, {_i<_count}, {_i=_i+1}] do
		{
			_entry = (_cfgfile) select _i;

			if ( isClass _entry ) then
			{
				_class = configName _entry;
				_scope = getNumber(_entry >> "scope");

				{
					_baseClass = configName(inheritsFrom _entry);
					if ( _baseClass == _x && _x != _class ) then
					{
						_scope = 0;
					};
				}forEach AcreRadioClasses;

				if ( isText (_entry >> "ItemInfo" >> "uniformclass")||isText (_entry >> "ItemInfo" >> "uniformmodel") ) then {_scope = 0;};
				if ( isClass (_entry >> "LinkedItems") ) then {_scope = 0;};

				if ( _scope == 2 ) then
				{
					_name = getText(_entry >> "displayName");
					if ( _name != "" ) then
					{
						_cfgWeapons set [count(_cfgWeapons),[_class, _name, _name call funcStringHash]];
					};
				};
			};
		};

		// Sort Clothes
		_cfgClothes = [];
		_cfgfile = configFile >> "CfgWeapons";
		_count = count(_cfgfile);

		for [ {_i=0}, {_i<_count}, {_i=_i+1}] do
		{
			_entry = (_cfgfile) select _i;

			if ( isClass _entry ) then
			{
				_class = configName _entry;
				_scope = getNumber(_entry >> "scope");

				if ( (isText (_entry >> "ItemInfo" >> "uniformclass") || isText (_entry >> "ItemInfo" >> "uniformmodel")) && _scope == 2 ) then
				{
					_name = getText(_entry >> "displayName");
					if ( _name != "" ) then
					{
						_cfgClothes set [count(_cfgClothes),[_class, _name, _name call funcStringHash]];
					};
				};
			};
		};

		// Sort Backpacks
		_cfgBackPacks = [];
		_cfgfile = configFile >> "CfgVehicles";
		_count = count(_cfgfile);

		for [ {_i=0}, {_i<_count}, {_i=_i+1}] do
		{
			_entry = (_cfgfile) select _i;

			if ( isClass _entry ) then
			{
				_class = configName _entry;
				_scope = getNumber(_entry >> "scope");

				if ( isClass (_entry >> "AssembleInfo") ) then {_scope = 0;};

				if ( _scope == 2 && _class isKindOf "Bag_Base") then
				{
					_name = getText(_entry >> "displayName");
					if ( _name != "" ) then
					{
						_cfgBackPacks set [count(_cfgBackPacks),[_class, _name, _name call funcStringHash]];
					};
				};
			};
		};

		// Sort Glasses
		_cfgGlasses= [];
		_cfgfile = configFile >> "CfgGlasses";
		_count = count(_cfgfile);

		for [ {_i=0}, {_i<_count}, {_i=_i+1}] do
		{
			_entry = (_cfgfile) select _i;

			if ( isClass _entry ) then
			{
				_class = configName _entry;
				_scope = getNumber(_entry >> "scope");

				if ( _scope == 2 ) then
				{
					_name = getText(_entry >> "displayName");
					if ( _name != "" && _name != "None") then
					{
						_cfgGlasses set [count(_cfgGlasses),[_class, _name, _name call funcStringHash]];
					};
				};
			};
		};

		// Sort ...

		_cfgMags = [2, true, _cfgMags] call funcSortStrings;
		_cfgWeapons = [2, true, _cfgWeapons] call funcSortStrings;
		_cfgBackPacks = [2, true, _cfgBackPacks] call funcSortStrings;
		_cfgClothes = [2, true, _cfgClothes] call funcSortStrings;
		_cfgGlasses = [2, true, _cfgGlasses] call funcSortStrings;

		firstEquip = 0;
		_type = 0;
		_cfgfile = configFile >> "CfgMagazines";

		{

			_entry = _cfgfile >> (_x select 0);
			_class = configName _entry;
			_name = getText(_entry >> "displayName");
			_magtype = getNumber(_entry >> "type");
			_ammoname = getText(_entry >> "ammo");
			_ammocount = getNumber(_entry >> "count");
			_ammo = (configFile >> "cfgAmmo" >> _ammoname);
			_hit = getNumber(_ammo >> "hit") + getNumber(_ammo >> "indirecthit")*(sqrt(1.0 + getNumber(_ammo >> "indirecthitrange")));

			_magkind = -1;
			_magprice = round(_hit + _hit * 0.25 * _ammocount);

			if ( _magprice == 0 ) then {_magprice = 15;};

			_slots = 1;
			if ( _magtype / 16 >= 1.0 ) then
			{
				_magkind = isHandgun;
				_slots = _magtype / 16;
			};
			if ( _magtype / 256 >= 1.0 ) then
			{
				_magkind = isGeneral;
				_slots = _magtype / 256;
			};

			if ( _magtype / 4096 >= 1.0 ) then
			{
				_magkind = isOptics;
				_slots = _magtype / 4096;
			};
			if ( _magtype / 131072 >= 1.0 ) then
			{
				_magkind = isEquipment;
				_slots = _magtype / 131072;
			};

			if ( _magkind != -1 )then
			{
				if ( _magprice >= 100 && _magprice < 1000 ) then {_magprice = round(_magprice/10) * 10;};
				if ( _magprice >= 1000 && _magprice < 10000 ) then {_magprice = round(_magprice/100) * 100;};
				if ( _magprice >= 10000 ) then {_magprice = round(_magprice/1000) * 1000;};

				call compile format["auto_mag_%1 = %2;",_class,_type];
				equipDefs set [_type, [_name,_magprice, siBoth, _magkind, _slots, _class]];
				_type = _type + 1;
			};

		}forEach _cfgMags;

		_cfgfile = configFile >> "CfgWeapons";

		{

			_entry = _cfgfile >> (_x select 0);
			_class = configName _entry;
			_name = getText(_entry >> "displayName");
			_wtype = getNumber(_entry >> "type");

			_wkind = -1;
			_wprice = 0;
			_slots = 1;

			if ( _wtype == 4096 ) then
			{
				_wkind = isOptics;
				_wprice = 30;
			};
			if ( _wtype == 131072) then
			{
				_wkind = isEquipment;
				_wprice = 15;
			};

			if ( _wkind != -1 && (_class != "ItemGPS" || GPSAvailable == 1)) then
			{
				if ( _wprice >= 100 && _wprice < 1000 ) then {_wprice = round(_wprice/10) * 10;};
				if ( _wprice >= 1000 && _wprice < 10000 ) then {_wprice = round(_wprice/100) * 100;};
				if ( _wprice >= 10000 ) then {_wprice = round(_wprice/1000) * 1000;};

				equipDefs set [_type, [_name,_wprice, siBoth, _wkind, _slots, _class ]];
				_type = _type + 1;
			};

		}forEach _cfgWeapons;

		_type = 0;
		_cfgfile = configFile >> "CfgWeapons";

		{
			_entry = _cfgfile >> (_x select 0);
			_class = configName _entry;
			_name = getText(_entry >> "displayName");
			_wtype = getNumber(_entry >> "type");
			_muzzles = getArray(_entry >> "muzzles");
			_wmags = getArray(_entry >> "magazines");

			{
				_mmags = getArray(_entry >> _x >> "magazines");

				{
					if ( !(_x in _wmags) ) then
					{
						_wmags = _wmags + [_x];
					};
				}forEach _mmags;
			}forEach _muzzles;

			_hit = _class call funcGetWeaponHitValue;

			_wprice = 0;

			if ( _hit < 100 ) then
			{
				_wprice = 100 + (_hit*10);
			};

			if ( _hit < 2 ) then
			{
				_wprice = 15;
			};

			if ( _hit >= 100 ) then
			{
				_wprice = 200 + _hit;
			};

			_wkind = -1;

			if ( _wtype == 1 ) then
			{
				_wkind = wtPrimary;
			};
			if ( _wtype == 5 ) then
			{
				_wkind = wtPrimaryOnly;
			};

			if ( _wtype == 2 ) then
			{
				_wkind = wtHandgun;
			};

			if ( _wtype == 4 ) then
			{
				_wkind = wtSecondary;
			};

			if ( _wkind != -1 )then
			{
				_mags = [];
				{
					if ( !isNil format["auto_mag_%1",_x]) then
					{
						call compile format["auto_magtype = auto_mag_%1;", _x];
						_ed = equipDefs select auto_magtype;
						_ed set [edIsAutoMag, "automag"];
						equipDefs set [auto_magtype, _ed];

						_slotsNeeded = _ed select edSlots;

						_slots = 1;
						_amount = 0;

						if ( _wkind == wtPrimary ) then {_slots = 6;};
						if ( _wkind == wtPrimaryOnly ) then {_slots = 12;};
						if ( _wkind == wtSecondary ) then {_slots = 6;};
						if ( _wkind == wtHandgun ) then {_slots = 8;};

						if ( _forEachIndex == 0 ) then
						{
							_amount = floor(_slots / _slotsNeeded);
						};

						_mags set [count(_mags), [auto_magtype, _amount]];

					};
				}forEach _wmags;

				if ( _wprice >= 100 && _wprice < 1000 ) then {_wprice = round(_wprice/10) * 10;};
				if ( _wprice >= 1000 && _wprice < 10000 ) then {_wprice = round(_wprice/100) * 100;};
				if ( _wprice >= 10000 ) then {_wprice = round(_wprice/1000) * 1000;};

				call compile format["auto_weapon_%1 = %2;", _class,_type];
				weaponDefs set [_type, [_name, round(_wprice), siBoth, _wkind, _class, _mags ]];
				_type = _type + 1;
			};
		}forEach _cfgWeapons;

		// Packs and Clothes
		_type = 0;
		_cfgfile = configFile >> "CfgVehicles";
		{
			_entry = _cfgfile >> (_x select 0);
			_class = configName _entry;
			_name = getText(_entry >> "displayName");
			_wprice = 15;

			clothesDefs set [_type, [_name, round(_wprice), siBoth, _class]];
			_type = _type + 1;
		}forEach _cfgBackPacks;

		_cfgfile = configFile >> "CfgWeapons";
		{
			_entry = _cfgfile >> (_x select 0);
			_class = configName _entry;
			_name = getText(_entry >> "displayName");
			_wprice = 15;
			_side = siBoth;

			if ( isText(_entry >> "ItemInfo" >> "uniformclass")) then
			{
				_uniformClass = getText(_entry >> "ItemInfo" >> "uniformclass");
				if ( isNumber(configFile >> "cfgVehicles" >> _uniformClass >> "side")) then
				{
					_classSide = getNumber(configFile >> "cfgVehicles" >> _uniformClass >> "side");
					_side = -1;
					if ( _classSide == 1 ) then {_side = siWest;};
					if ( _classSide == 0 ) then {_side = siEast;};
				};
			};

			if ( _side != -1 ) then
			{
				clothesDefs set [_type, [_name, round(_wprice), _side, _class]];
				_type = _type + 1;
			};
		}forEach _cfgClothes;

		_cfgfile = configFile >> "cfgGlasses";
		{
			_entry = _cfgfile >> (_x select 0);
			_class = configName _entry;
			_name = getText(_entry >> "displayName");
			_wprice = 5;

			clothesDefs set [_type, [_name, round(_wprice), siBoth, _class]];
			_type = _type + 1;
		}forEach _cfgGlasses;

	};

	publicVariable "equipDefs";
	publicVariable "weaponDefs";
	publicVariable "clothesDefs";
	publicVariable "firstEquip";

	EquipmentPublished = true;
	publicVariable "EquipmentPublished";
	endLoadingScreen;
};

waitUntil {!isNil "EquipmentPublished"};
waitUntil {EquipmentPublished};
