udName = 0;
udCost = 1;
udSide = 2;
udBuildTime = 3;
udModel = 4;
udFactoryType = 5;
udCrew = 6;
udMarkerType = 7;
udScriptsServer = 8;
udScriptsPlayer = 9;
udRearm = 10;

// udCrew = [number of crew, type, and for ArmA number of EXTRA TURRENTS]

// VEHICLE MARKERS

sQSoldier = "n_inf";
SQbike = "n_motor_inf";
SQCar = "n_motor_inf";
SQTruck = "n_support";
SQBoat= "n_motor_inf";
SQAPC = "n_mech_inf";
sqTank = "n_armor";
sQHeli = "n_air";
sQPlane = "n_plane";
sQSupport = "n_maint";
sQAmmo = "n_support";
SQFuel = "n_service";
SQMHQ = "o_hq";
sQAA = "n_armor";

// INFANTRY WEST

if ( isServer ) then
{
	startLoadingScreen["Populating Unitlist.","RscDisplayLoadMission"];
	unitDefs = [];

	if ( !AutoUnitList ) then
	{
		_type = 0;

		unitDefs set [_type, ["Worker", costWorker, siWest, 7, "FR_Light", stPrebuiltBarracks, [], sQSoldier, ["UpdateWorker.sqf"], [],[] ] ];
		utWorkerW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["M16 USMC", 100, siWest, 7, "USMC_Soldier", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["M16GL USMC", 150, siWest, 7, "USMC_Soldier_GL", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierWG = _type;
		_type = _type + 1;

		unitDefs set [_type, ["M249 USMC", 150, siWest, 7, "USMC_Soldier_AR", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierMG9 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["M240 USMC", 150, siWest, 7, "USMC_Soldier_MG", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierMG0 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["M40A3 Sniper USMC", 300, siWest, 7, "USMC_SoldierS_Sniper", stBarracks, [], sQSoldier, [], [],[] ] ];
		_sniperW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["M107 Sniper USMC", 600, siWest, 7, "USMC_SoldierS_SniperH", stBarracks, [], sQSoldier, [], [],[] ] ];
		_sniperWH = _type;
		_type = _type + 1;

		unitDefs set [_type, ["DMR Marksman USMC", 200, siWest, 7, "USMC_SoldierM_Marksman", stBarracks, [], sQSoldier, [], [],[] ] ];
		_sniperDMR = _type;
		_type = _type + 1;

		unitDefs set [_type, ["M136 USMC", 400, siWest, 7, "USMC_Soldier_LAT", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierLAWW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["SMAW USMC", 500, siWest, 7, "USMC_Soldier_AT", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierSMAW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["JAV USMC", 1200, siWest, 7, "USMC_Soldier_HAT", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierJAV = _type;
		_type = _type + 1;

		_soldierAAW = [];
		if ( AntiAirAllowed > 0) then
		{
			unitDefs set [_type, ["Stinger USMC", 400, siWest, 7, "USMC_Soldier_AA", stBarracks, [], sQSoldier, [], [],[] ] ];
			_soldierAAW = _type;
			_type = _type + 1;
		};

		medicWestClass = "USMC_Soldier_Medic";
		unitDefs set [_type, ["Medic USMC", 50, siWest, 7, medicWestClass,stBarracks, [], sQSoldier, [], [],[] ] ];
		_medicW = _type;

		_type = _type + 1;

		unitDefs set [_type, ["Crew USMC", 90, siWest, 7, "USMC_Soldier_Crew", stBarracks, [], sQSoldier, [], [],[] ] ];
		utCrewW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Pilot UCMC", 90, siWest, 7, "USMC_Soldier_Pilot", stBarracks, [], sQSoldier, [], [],[] ] ];
		_pilotW = _type;
		_type = _type + 1;

		// INFANTRY EAST

		unitDefs set [_type, ["Worker", costWorker, siEast,7, "RUS_Soldier1", stPrebuiltBarracks, [], sQSoldier, ["UpdateWorker.sqf"], [],[] ] ];
		utWorkerE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["AK107 RU", 50, siEast,7, "RU_Soldier", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["AK107GL RU", 150, siEast,7, "RU_Soldier_GL", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierEG = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Pecheneg RU", 150, siEast,7, "RU_Soldier_MG", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierMGE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["RPK_74 RU", 150, siEast,7, "RU_Soldier_AR", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierRPK = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Sniper RU", 200, siEast,7, "RU_Soldier_Sniper", stBarracks, [], sQSoldier, [], [],[] ] ];
		_sniperE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["KSVK Sniper RU", 400, siEast,7, "RU_Soldier_SniperH", stBarracks, [], sQSoldier, [], [],[] ] ];
		_sniperEH = _type;
		_type = _type + 1;

		unitDefs set [_type, ["SVD Marksman RU", 300, siEast,7, "RU_Soldier_Marksman", stBarracks, [], sQSoldier, [], [],[] ] ];
		_sniperEMark = _type;
		_type = _type + 1;

		unitDefs set [_type, ["RPG18 RU", 300, siEast,7, "RU_Soldier_LAT", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierLAWE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["RPG7v RU", 400, siEast,7, "RU_Soldier_AT", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierRPG7 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["AT13 RU", 1000, siEast,7, "RU_Soldier_HAT", stBarracks, [], sQSoldier, [], [],[] ] ];
		_soldierAT13 = _type;
		_type = _type + 1;

		_soldierAAE = [];
		if ( AntiAirAllowed > 0 ) then
		{
			unitDefs set [_type, ["Strela RU", 400, siEast,7, "RU_Soldier_AA", stBarracks, [], sQSoldier, [], [],[] ] ];
			_soldierAAE = _type;
			_type = _type + 1;
		};

		medicEastClass = "RU_Soldier_Medic";
		unitDefs set [_type, ["Medic RU", 50, siEast,7, medicEastClass,stBarracks, [], sQSoldier, [], [],[] ] ];
		_medicE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Crew RU", 90, siEast,7, "RU_Soldier_Crew", stBarracks, [], sQSoldier, [], [],[] ] ];
		utCrewE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Pilot RU", 90, siEast,7, "RU_Soldier_Pilot", stBarracks, [], sQSoldier, [], [],[] ] ];
		_pilotE = _type;
		_type = _type + 1;

		// VEHICLES WEST

		unitDefs set [_type, ["MHQ West", 50000, siWest, 10, "LAV25_HQ", stPrebuiltLight, [1, utCrewW,0], SQMHQ, ["InitMHQ.sqf"], ["InitMHQ.sqf"],[] ] ];
		utMHQWest = _type;
		_type = _type + 1;
		unitDefs set [_type, ["Fake MHQ West", 5000, siWest, 10, "LAV25_HQ", stLight, [1, utCrewW,0], SQAPC, [], [],[] ] ];
		FakeMHQWest = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Bicycle", 20, siWest, 20, "MMT_USMC", stLight, [1, _soldierW,0], SQbike, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_bikeW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Motorcycle", 100, siWest, 20, "M1030", stLight, [1, _soldierW,0], SQbike, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_M1030W = _type;
		_type = _type + 1;

		unitDefs set [_type, ["HMMWV", 150, siWest, 25, "HMMWV", stLight, [1, _soldierW,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_hummerW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["HMMWV with 50mm MG", 400, siWest, 30, "HMMWV_M2", stLight, [2, _soldierW,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_hummerWmg = _type;
		_type = _type + 1;

		unitDefs set [_type, ["HMMWV 240", 550, siWest, 30, "HMMWV_Armored",stLight, [2, _soldierW,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_hummerW240 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["HMMWV with TOW", 700, siWest, 30, "HMMWV_TOW", stLight, [2, _soldierW,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_hummerWtow = _type;
		_type = _type + 1;

		unitDefs set [_type, ["HMMWV with GL", 700, siWest, 30, "HMMWV_MK19", stLight, [2, _soldierW,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_hummerWgl = _type;
		_type = _type + 1;

		_hummerAvenger = [];
		_M6 = [];
		if ( AntiAirAllowed > 0 ) then
		{
			unitDefs set [_type, ["HMMWV Avenger", 1500, siWest, 30, "HMMWV_Avenger", stLight, [2, _soldierW,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
			_hummerAvenger = _type;
			_type = _type + 1;

			unitDefs set [_type, ["M6 Linebacker", 2500, siWest, 50, "M6_EP1", stHeavy, [3, utCrewW,0], sqTank, [], [],[] ] ];
			_M6 = _type;
			_type = _type + 1;

		};

		unitDefs set [_type, ["5t Truck", 300, siWest, 30, "MTVR", stLight, [1, _soldierW,0], SQTruck, ["InitTruck.sqf"], ["InitTruck.sqf"],[] ] ];
		utTruckWest = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Fuel 5t Truck", 500, siWest, 30, "MtvrRefuel", stLight, [1, _soldierW,0], SQFuel, [], [],[] ] ];
		_type = _type + 1;

		unitDefs set [_type, ["Support 5t Truck", 500, siWest, 30, "MtvrRepair", stLight, [1, _medicW,0], sQSupport, ["InitRearmVehicle.sqf","InitRepairVehicle.sqf","InitRefuelVehicle.sqf"], ["InitRearmVehicle.sqf","InitRepairVehicle.sqf","InitRefuelVehicle.sqf", "InitTransportTruck.sqf"],[] ] ];
		utSupportTruckWest = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Support BMP2", 700, siWest, 30, "BMP2_Ambul_CDF", stHeavy, [1, _medicW,0], sQSupport, ["InitRearmVehicle.sqf","InitRepairVehicle.sqf","InitRefuelVehicle.sqf"], ["InitRearmVehicle.sqf","InitRepairVehicle.sqf","InitRefuelVehicle.sqf", "InitTransportAPC.sqf"],[] ] ];
		utSupportAPCWest = _type;
		_type = _type + 1;

		_m1a1=[];
		_m1a2=[];
		_M2A2 = [];
		_StrMGS = [];
		if ( HeavyArmorAllowed > 0 ) then
		{
			unitDefs set [_type, ["M1A1", 5000, siWest, 50, "M1A1", stHeavy, [3, utCrewW,0], sqTank, [], [],[] ] ];
			_m1a1 = _type;
			_type = _type + 1;

			unitDefs set [_type, ["M1A2", 7000, siWest, 50, "M1A2_TUSK_MG", stHeavy, [3, utCrewW,0], sqTank, [], [],[] ] ];
			_m1a2 = _type;
			_type = _type + 1;

			//unitDefs set [_type, ["MLRS", 2500, siWest, 50, "MLRS", stHeavy, [2, utCrewW,0], sqTank, [], [],[] ] ];
			//_MLRS = _type;
			//_type = _type + 1;

			unitDefs set [_type, ["M2A2 Bradley", 3500, siWest, 50, "M2A2_EP1", stHeavy, [3, utCrewW,0], sqTank, [], [],[] ] ];
			_M2A2 = _type;
			_type = _type + 1;

			unitDefs set [_type, ["Stryker MGS", 1200, siWest, 50, "M1128_MGS_EP1", stHeavy, [2, utCrewW,0], sqTank, [], [],[] ] ];
			_StrMGS = _type;
			_type = _type + 1;

		};

		unitDefs set [_type, ["AAV", 1200, siWest, 50, "AAV", stHeavy, [2, utCrewW,0], sqTank, [], [],[] ] ];
		_AAV = _type;
		_type = _type + 1;

		unitDefs set [_type, ["LAV25", 1800, siWest, 50, "LAV25", stHeavy, [3, utCrewW,0], sqTank, [], [],[] ] ];
		_LAV25 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Stryker ICV M2", 800, siWest, 50, "M1126_ICV_M2_EP1", stHeavy, [2, utCrewW,0], sqTank, [], [],[] ] ];
		_StrICVM2 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Stryker ICV MK19", 900, siWest, 50, "M1126_ICV_mk19_EP1", stHeavy, [2, utCrewW,0], sqTank, [], [],[] ] ];
		_StrICVMK19 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Stryker TOW", 1200, siWest, 50, "M1135_ATGMV_EP1", stHeavy, [2, utCrewW,0], sqTank, [], [],[] ] ];
		_StrTOW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["M113A3", 1200, siWest, 50, "M113_UN_EP1", stHeavy, [2, utCrewW,0], sqTank, [], [],[] ] ];
		_M113A3 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Attack RHIB", 1000, siWest, 30, "RHIB2Turret", stMarina, [2, _soldierW,1], SQBoat, [], ["InitTransportBoat.sqf"],[] ] ];
		_boatW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["UH1Y", 6000, siWest, 60, "UH1Y", stAir, [2, _pilotW,0], sQHeli, [], [],[] ] ];
		_uh60 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["MH60S (Transport)", 2000, siWest, 60, "MH60S", stAir, [2, _pilotW,1], sQHeli, [], ["InitTransportChopper.sqf"],[] ] ];
		_uh60W = _type;
		_type = _type + 1;

		_AH1=[];
		_AH64D=[];
		_AH6 = [];
		if ( AttackChoppersAllowed > 0 ) then
		{
			unitDefs set [_type, ["AH1 Z", 18000, siWest, 90, "AH1Z", stAir, [2, _pilotW,0], sQHeli, [], [],[] ] ];
			_AH1 = _type;
			_type = _type + 1;

			unitDefs set [_type, ["AH-64D", 24000, siWest, 90, "AH64D", stAir, [2, _pilotW,0], sQHeli, [], [],[] ] ];
			_AH64D = _type;
			_type = _type + 1;

			unitDefs set [_type, ["AH-6 Little Bird", 8000, siWest, 90, "AH6J_EP1", stAir, [1, _pilotW,0], sQHeli, [], [],[] ] ];
			_AH6 = _type;
			_type = _type + 1;

		};

		if ( AttackPlanesAllowed > 0 ) then
		{
			unitDefs set [_type, ["A10", 20000, siWest, 90, "A10", stAir, [1, _pilotW,0], sQPlane, [], [],[] ] ];
			_type = _type + 1;
			unitDefs set [_type, ["AV8 B AA", 16000, siWest, 90, "AV8B2", stAir, [1, _pilotW,0], sQPlane, [], [],[] ] ];
			_type = _type + 1;
			unitDefs set [_type, ["AV8 B LGB", 25000, siWest, 90, "AV8B", stAir, [1, _pilotW,0], sQPlane, [], [],[] ] ];
			_type = _type + 1;
			unitDefs set [_type, ["F35B", 25000, siWest, 90, "F35B", stAir, [1, _pilotW,0], sQPlane, [], [],[] ] ];
			_type = _type + 1;
		};

		unitDefs set [_type, ["MV22", 6000, siWest, 90, "MV22", stAir, [1, _pilotW,0], sQPlane, [], [],[] ] ];
		_MV22 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["C130J", 9000, siWest, 90, "C130J",stAir, [1, _pilotW,0], sQPlane, [], [],[] ] ];
		_C130J = _type;
		_type = _type + 1;

		unitDefs set [_type, ["MH-6 Little Bird", 1000, siWest, 60, "MH6J_EP1", stAir, [1, _pilotW,0], sQHeli, [], ["InitTransportChopper.sqf"],[] ] ];
		_MH6 = _type;
		_type = _type + 1;

		// VEHICLES EAST

		unitDefs set [_type, ["MHQ East", 50000, siEast, 10, "BTR90_HQ", stPrebuiltLight, [1, utCrewE,0], SQMHQ, ["InitMHQ.sqf"], ["InitMHQ.sqf"],[] ] ];
		utMHQEast = _type;
		_type = _type + 1;
		unitDefs set [_type, ["Fake MHQ East", 5000, siEast, 10, "BTR90_HQ", stLight, [1, utCrewE,0], SQAPC, [], [],[] ] ];
		FakeMHQEast = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Bicycle", 20, siEast, 20, "MMT_Civ", stLight, [1, _soldierE,0], SQbike, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_bikeE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Motorcycle", 100, siEast, 20, "TT650_Ins", stLight, [1, _soldierE,0], SQbike, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_TT650GE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["UAZ", 200, siEast, 20, "UAZ_RU", stLight, [1, _soldierE,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_uazE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["UAZ SPG9", 700, siEast, 20, "UAZ_SPG9_INS", stLight, [2, _soldierE,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_uazSPG9 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["UAZ MG", 400, siEast, 20, "UAZ_MG_INS", stLight, [2, _soldierE,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_uazMG = _type;
		_type = _type + 1;

		unitDefs set [_type, ["UAZ with AGS", 700, siEast, 20, "UAZ_AGS30_RU", stLight, [2, _soldierE,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_uazAgs = _type;
		_type = _type + 1;

		//unitDefs set [_type, ["GRAD", 2500, siEast, 20, "GRAD_RU",   stLight, [2, _soldierE,0], SQCar, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		//_GRAD_RU = _type;
		//_type = _type + 1;

		unitDefs set [_type, ["GAZ Vodnik", 1200, siEast, 50, "GAZ_Vodnik", stHeavy, [3, _soldierE,0], SQAPC, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_GAZ_Vodnik = _type;
		_type = _type + 1;

		unitDefs set [_type, ["GAZ Vodnik HMG", 1500, siEast, 50, "GAZ_Vodnik_HMG", stHeavy, [2, _soldierE,0], SQAPC, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
		_GAZ_Vodnik_HMG = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Ural", 300, siEast, 30, "Kamaz", stLight, [1, _soldierE,0], SQTruck, ["InitTruck.sqf"], ["InitTruck.sqf"],[] ] ];
		utTruckEast = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Fuel Ural", 500, siEast, 30, "KamazRefuel", stLight, [1, _soldierE,0], SQFuel, [], [],[] ] ];
		_type = _type + 1;

		unitDefs set [_type, ["Support Ural", 500, siEast, 30, "KamazRepair", stLight, [1, _soldierE,0], sQSupport, ["InitRearmVehicle.sqf","InitRepairVehicle.sqf","InitRefuelVehicle.sqf"], ["InitRearmVehicle.sqf","InitRepairVehicle.sqf","InitRefuelVehicle.sqf","InitTransportTruck.sqf"],[] ] ];
		utSupportTruckEast = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Support BMP", 700, siEast, 30, "BMP2_Ambul_INS", stHeavy, [1, _medicE,0], sQSupport, ["InitRearmVehicle.sqf","InitRepairVehicle.sqf","InitRefuelVehicle.sqf"], ["InitRearmVehicle.sqf","InitRepairVehicle.sqf","InitRefuelVehicle.sqf","InitTransportAPC.sqf"],[] ] ];
		utSupportAPCEast = _type;
		_type = _type + 1;

		_Tunguska = [];
		if ( AntiAirAllowed > 0 ) then
		{
			unitDefs set [_type, ["2S6M Tunguska", 3000, siEast, 35, "2S6M_Tunguska", stHeavy, [3, utCrewE,0], SQAA, [], ["InitCar.sqf"],[] ] ];
			_Tunguska = _type;
			_type = _type + 1;
		};

		unitDefs set [_type, ["BRDM-2", 1800, siEast, 50, "BRDM2_CDF", stHeavy, [2, utCrewE,0], SQAPC, [], ["InitCar.sqf"],[] ] ];
		_BRDM2 = _type;
		_type = _type + 1;

		unitDefs set [_type, ["BMP-2", 2500, siEast, 50, "BMP2_CDF", stHeavy, [3, utCrewE,0], SQAPC, [], ["InitCar.sqf"],[] ] ];
		_BMP2 = _type;
		_type = _type + 1;

		_BMP3 = [];
		_BTR_90=[];
		_T72=[];
		_T72B=[];
		_T90=[];
		if ( HeavyArmorAllowed > 0 ) then
		{
			unitDefs set [_type, ["BMP-3", 3500, siEast, 50, "BMP3", stHeavy, [3, utCrewE,0], SQAPC, [], ["InitCar.sqf"],[] ] ];
			_BMP3 = _type;
			_type = _type + 1;

			unitDefs set [_type, ["BTR-90", 3000, siEast, 50, "BTR90",stHeavy, [3, _soldierE,0], SQAPC, ["InitCar.sqf"], ["InitCar.sqf"],[] ] ];
			_BTR_90 = _type;
			_type = _type + 1;

			unitDefs set [_type, ["T72", 4500, siEast, 40, "T72_RU", stHeavy, [3, utCrewE,0], sqTank, [], [],[] ] ];
			_T72 = _type;
			_type = _type + 1;

			unitDefs set [_type, ["T90", 6500, siEast, 40, "T90", stHeavy, [3, utCrewE,0], sqTank, [], [],[] ] ];
			_T90 = _type;
			_type = _type + 1;

			unitDefs set [_type, ["T72 TK", 4600, siEast, 40, "T72_TK_EP1", stHeavy, [3, utCrewE,0], sqTank, [], [],[] ] ];
			_T72B = _type;
			_type = _type + 1;

		};

		unitDefs set [_type, ["PBX", 1000, siEast, 30, "PBX", stMarina, [2, _soldierE,1], SQBoat, [], ["InitTransportBoat.sqf"],[] ] ];
		_BoatEast = _type;
		_type = _type + 1;

		_Mi24_P=[];
		_Mi24_V=[];
		_Mi17f=[];
		_V80=[];
		_V80Black=[];
		if ( AttackChoppersAllowed > 0 ) then
		{
			unitDefs set [_type, ["Mi24_P", 18000, siEast, 60, "Mi24_P", stAir, [2, _pilotE,0], sQHeli, [], [],[] ] ];
			_Mi24_P = _type;
			_type = _type + 1;

			unitDefs set [_type, ["Mi24_V", 18000, siEast, 60, "Mi24_V", stAir, [2, _pilotE,0], sQHeli, [], [],[] ] ];
			_Mi24_V = _type;
			_type = _type + 1;

			unitDefs set [_type, ["Mi17 FFAR", 12000, siEast, 60, "Mi17_rockets_RU", stAir, [2, _pilotE,2], sQHeli, [], [],[] ] ];
			_mi17f = _type;
			_type = _type + 1;

			unitDefs set [_type, ["Ka52", 25000, siEast, 90, "Ka52", stAir, [2, _pilotE,0], sQHeli, [], [],[] ] ];
			_V80 = _type;
			_type = _type + 1;

			unitDefs set [_type, ["Ka52 Black", 25000, siEast, 90, "Ka52Black",stAir, [2, _pilotE,0], sQHeli, [], [],[] ] ];
			_V80Black = _type;
			_type = _type + 1;

		};

		unitDefs set [_type, ["Mi17 MG (Transport)", 2000, siEast, 60, "Mi17_Ins", stAir, [2, _pilotE,2], sQHeli, [], ["InitTransportChopper.sqf"],[] ] ];
		_mi17 = _type;
		_type = _type + 1;

		if ( AttackPlanesAllowed > 0 ) then
		{
			unitDefs set [_type, ["Su25", 25000, siEast, 90, "Su25_Ins", stAir, [1, _pilotE,0], sQPlane, [], [],[] ] ];
			_type = _type + 1;

			unitDefs set [_type, ["Su39", 22000, siEast, 90, "Su39", stAir, [2, _pilotE,0], sQPlane, [], [],[] ] ];
			_type = _type + 1;
		};

		// RESISTANCE
		_st = stPrebuiltBarracks;

		// INFANTRY RES

		unitDefs set [_type, ["Soldier", 100, siRes, 0, "GUE_Soldier_AR", _st, [], sQSoldier, [], [],[] ] ];
		_soldierR = _type;
		_type = _type + 1;

		unitDefs set [_type, ["crew", 100, siRes, 0, "GUE_Commander", _st, [], sQSoldier, [], [],[] ] ];
		_soldierGR = _type;
		_type = _type + 1;

		unitDefs set [_type, ["PK", 150, siRes, 0, "GUE_Soldier_MG", _st, [], sQSoldier, [], [],[] ] ];
		_soldierMGR = _type;
		_type = _type + 1;

		unitDefs set [_type, ["RPG", 150, siRes, 0, "GUE_Soldier_AT", _st, [], sQSoldier, [], [],[] ] ];
		_soldierLAWR = _type;
		_type = _type + 1;

		_soldierAAR = [];
		if ( AntiAirAllowed > 0 ) then
		{
			unitDefs set [_type, ["Strela", 150, siRes, 0, "GUE_Soldier_AA", _st, [], sQSoldier, [], [],[] ] ];
			_soldierAAR = _type;
			_type = _type + 1;
		};

		unitDefs set [_type, ["Strela", 150, siRes, 0, "GUE_Soldier_Sniper", _st, [], sQSoldier, [], [],[] ] ];
		_sniperR = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Strela", 150, siRes, 0, "GUE_Soldier_Crew", _st, [], sQSoldier, [], [],[] ] ];
		_GCrew = _type;
		_type = _type + 1;

		_st = stPrebuiltHeavy;

		// ARMOR RES
		_T72_RACS = [];
		if ( HeavyArmorAllowed > 0 ) then
		{
			unitDefs set [_type, ["T72_RACS", 3500, siRes, 0, "T72_Gue", _st, [3, _GCrew,0], sqTank, [], [],[] ] ];
			_T72_RACS = _type;
			_type = _type + 1;
		};

		unitDefs set [_type, ["BMP2_Gue", 3000, siRes, 0, "BMP2_Gue", _st, [2, _GCrew,0], sqTank, [], [],[] ] ];
		_BMP2_Gue = _type;
		_type = _type + 1;

		unitDefs set [_type, ["BRDM2_Gue", 1000, siRes, 0, "BRDM2_Gue", _st, [2, _GCrew,0], sqCar, [], [],[] ] ];
		_BRDM2_Gue = _type;
		_type = _type + 1;

		_st = stPrebuiltLight;

		unitDefs set [_type, ["Pickup_PK_GUE", 500, siRes, 0, "Pickup_PK_GUE", _st, [2, _GCrew,0], sqCar, [], [],[] ] ];
		_Pickup_PK_Gue = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Offroad_DSHKM_Gue", 500, siRes, 0, "Offroad_DSHKM_Gue", _st, [2, _GCrew,0], sqCar, [], [],[] ] ];
		_Offroad_DSHKM_Gue = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Offroad_SPG9_Gue", 500, siRes, 0, "Offroad_SPG9_Gue", _st, [2, _GCrew,0], sqCar, [], [],[] ] ];
		_Offroad_SPG9_Gue = _type;
		_type = _type + 1;

		_st = stNone;

		unitDefs set [_type, ["DSHKM_CDF", 500, siRes, 0, "DSHKM_CDF", _st, [1, _GCrew,0], sqSoldier, [], [],[] ] ];
		_DSHKM = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Ins_WarfareBMGNest_PK", 500, siRes, 0, "Ins_WarfareBMGNest_PK", _st, [1, _GCrew,0], sqSoldier, [], [],[] ] ];
		_MGNest = _type;
		_type = _type + 1;

		unitDefs set [_type, ["SearchLight_CDF", 500, siRes, 0, "SearchLight_CDF", _st, [1, _GCrew,0], sqSoldier, [], [],[] ] ];
		_SearchLight = _type;
		_type = _type + 1;

		_st = stPrebuiltBarracks;

		//Civilians
		unitDefs set [_type, ["Civ1", -10000, siCiv, 0, "Citizen1", _st, [], sQSoldier, [], [],[] ] ];
		_Civ1 = _Type;
		_type = _type + 1;
		unitDefs set [_type, ["Civ2", -10000, siCiv, 0, "Citizen2", _st, [], sQSoldier, [], [],[] ] ];
		_Civ2 = _Type;
		_type = _type + 1;
		unitDefs set [_type, ["Civ3", -10000, siCiv, 0, "Citizen3", _st, [], sQSoldier, [], [],[] ] ];
		_Civ3 = _Type;
		_type = _type + 1;
		unitDefs set [_type, ["Civ4", -10000, siCiv, 0, "Citizen4", _st, [], sQSoldier, [], [],[] ] ];
		_Civ4 = _Type;
		_type = _type + 1;
		unitDefs set [_type, ["CivCar1", -1000, siCiv, 0, "car_hatchback", _st, [1, _Civ1,0], sqCar, [], [],[] ] ];
		_CivCar1 = _type;
		_type = _type + 1;
		unitDefs set [_type, ["CivCar2", -1000, siCiv, 0, "hilux1_civil_1_open", _st, [1, _Civ1,0], sqCar, [], [],[] ] ];
		_CivCar2 = _type;
		_type = _type + 1;
		unitDefs set [_type, ["CivCar3", -1000, siCiv, 0, "car_sedan", _st, [1, _Civ1,0], sqCar, [], [],[] ] ];
		_CivCar3 = _type;
		_type = _type + 1;

		typesRearm = [ [utSupportAPCWest,utSupportTruckWest], [utSupportAPCEast,utSupportTruckEast] ];
		typesRepair = typesRearm;
		typesRefuel = typesRearm;
		typesSupport = typesRearm;
		typesFakeMHQ = [[FakeMHQWest],[FakeMHQEast],[],[],[],[]];

		// TOWN UNITS
		infTown = [ [],[],[] ];
		carTown = [ [],[],[] ];
		apcTown = [ [],[],[] ];
		armorTown = [ [],[],[] ];
		staticTown = [ [],[],[] ];
		lightsTown = [ [],[],[] ];
		airTown = [ [],[],[] ];

		_si = siCiv;
		infTown set [_si, [ [_Civ1, 1.0],[_Civ2, 1.0],[_Civ3, 1.0],[_Civ4, 1.0]] ];
		carTown set [_si, [ [_CivCar1,1.0],[_CivCar2,1.0],[_CivCar3,1.0] ] ];

		_si = siwest;
		infTown set [_si, [ [_medicW, 0.1], [_sniperW, 0.5], [_soldierMG9, 0.5], [_soldierLAWW, 1], [_soldierAAW, 0.5], [_soldierWG, 0.5] ] ];
		apcTown set [_si, [ [_LAV25, 1.0] ] ];
		armorTown set [_si, [[]] ];
		carTown set [_si, [ [] ] ];
		staticTown set [_si, [ [] ] ];
		lightsTown set [_si, [ [] ] ];

		_si = sieast;
		infTown set [_si, [ [_medicE, 0.1], [_sniperE, 0.5], [_soldierMGE, 0.5], [_soldierLAWE, 1], [_soldierAAE, 0.5], [_soldierEG, 0.5] ] ];
		apcTown set [_si, [ [_BMP2,1.0] ] ];
		armorTown set [_si, [[]] ];
		carTown set [_si, [ [] ] ];
		staticTown set [_si, [ [] ] ];
		lightsTown set [_si, [ [] ] ];

		_si = siRes;
		infTown set [_si, [ [_soldierAAR, 0.3],[_sniperR, 0.3], [_soldierMGR, 0.8], [_soldierLAWR, 0.6], [_soldierGR, 1.0], [_soldierR, 1.0] ] ];

		_list = [ [_Pickup_PK_Gue,1.0],[_Offroad_SPG9_Gue,0.2],[_Offroad_DSHKM_Gue,0.3] ];
		carTown set [ _si, _list ];

		_list = [ [_BMP2_Gue, 0.7], [_BRDM2_Gue, 0.7] ];
		apcTown set [ _si, _list ];

		_list = [];
		if ( HeavyArmorAllowed > 0 ) then
		{
			_list = [ [_T72_RACS, 0.5 ] ];
		};

		armorTown set [ _si, _list ];

		_list = [[_DSHKM,1.0],[_MGNest,1.0]];
		staticTown set [_si, _list];
		_list = [[_SearchLight,1.0]];
		lightsTown set [_si, _list ];

		unitsBuilt = [ [], [], [],[] ];

		// TRANSPORT VEHICLES
		// ai groups will use (board) these if using transport vehicles
		// define which vehicles 8have the Eject Cargo action
		// ai co will only buy first type of air types for transport missions
		airTransport = [[], []];
		groundTransport = [[], []];

		_si = siwest;
		airTransport set [_si, [ _uh60W, _uh60, _C130J, _MV22] ];
		groundTransport set [_si, [utTruckWest, _hummerW, _boatW, _hummerWmg, _hummerWtow, _hummerWgl, _hummerW240, _AAV, _LAV25] ];
		_si = sieast;

		if ( AttackChoppersAllowed == 0 ) then
		{
			airTransport set [_si, [ _mi17, _mi17f] ];
		}
		else
		{
			airTransport set [_si, [ _mi17, _Mi24_P, _Mi24_V, _mi17f] ];
		};

		if ( HeavyArmorAllowed == 0 ) then
		{
			groundTransport set [_si, [ utTruckEast, _uazE, _uazSPG9, _BoatEast, _uazAgs] ];
		}
		else
		{
			groundTransport set [_si, [ utTruckEast, _uazE, _uazSPG9, _BoatEast, _BTR_90, _uazAgs, _BMP3] ];
		};

		// AI UNITS - units bought by ai leaders, this must match aisBuy in aiSettingDefs in init.sqf

		unitsBuyAI = [ [], [] ];
		unitsAvgPrice = [ [[]],[[]],[[]],[[]],[[]],[[]] ];
		unitsMaxPrice = [ [[]],[[]],[[]],[[]],[[]],[[]] ];
		factoryAvgPrice = [ [[]],[[]],[[]],[[]],[[]],[[]] ];
		_i = 0;

		utbNone = _i;
		_list = [];
		(unitsBuyAI select siwest) set [_i, _list];
		_list = [];
		(unitsBuyAI select sieast) set [_i, _list];
		_i = _i + 1;

		utbMixed = _i;
		_list = [ [_medicW, 0.1], [_sniperW, 0.4], [_soldierMG9, 0.7], [_soldierMG0, 0.7], [_soldierSMAW, 1], [_soldierWG, 1], [_soldierMG9, 1], [_soldierLAWW, 1], [_hummerW240, 0.5],[_hummerWmg, 0.5], [_hummerWtow, 0.5], [_hummerWgl, 0.5], [_AAV, 0.5], [_LAV25, 0.5]];
		if ( AntiAirAllowed > 0 ) then {_list = _list + [[_soldierAAW, 0.7], [_hummerAvenger, 0.5]];};
		(unitsBuyAI select siwest) set [_i, _list];

		_list = [ [_medicE, 0.1], [_sniperE, 0.4], [_soldierRPK, 0.7], [_sniperEMark, 0.7],[_soldierEG, 0.7], [_soldierMGE, 0.7], [_soldierLAWE, 1], [_soldierRPG7, 1], [_uazAgs, 0.5], [_uazSPG9,0.5],[_uazMG,0.5], [_GAZ_Vodnik, 0.5],[_GAZ_Vodnik_HMG, 0.5]];
		if ( AntiAirAllowed > 0 ) then {_list = _list + [[_soldierAAE, 0.7], [_Tunguska, 0.5]];};
		(unitsBuyAI select sieast) set [_i, _list];
		_i = _i + 1;

		utbInfMixed = _i;
		_list = [ [_medicW, 0.1], [_sniperW, 0.4], [_soldierMG9, 1], [_soldierWG, 0.5], [_soldierLAWW, 1], [_soldierMG9, 0.5], [_soldierMG0, 0.5], [_soldierSMAW, 1]];
		if ( AntiAirAllowed > 0 ) then {_list = _list + [[_soldierAAW, 0.5]];};
		(unitsBuyAI select siwest) set [_i, _list];
		_list = [ [_medicE, 0.1],[_sniperE, 0.4], [_soldierMGE, 1], [_soldierEG, 0.5], [_soldierLAWE, 1], [_soldierRPG7, 1], [_soldierRPK, 0.5], [_soldierRPG7, 0.5], [_sniperEMark, 1]];
		if ( AntiAirAllowed > 0 ) then {_list = _list + [[_soldierAAE, 0.5]];};
		(unitsBuyAI select sieast) set [_i, _list];
		_i = _i + 1;

		utbCars = _i;
		_list = [ [_hummerW240, 0.5],[_hummerWmg, 0.5], [_hummerWtow, 0.5], [_hummerWgl, 0.5] ];
		(unitsBuyAI select siwest) set [_i, _list];
		_list = [ [_uazAgs, 0.5], [_uazSPG9,0.5], [_uazMG,0.5] ];
		(unitsBuyAI select sieast) set [_i, _list];
		_i = _i + 1;

		utbTanksLight = _i;
		_list = [ [_AAV, 0.5], [_LAV25, 0.7], [_M113A3, 0.6],[_StrICVM2, 0.5], [_StrICVMK19, 0.5], [_StrTOW, 0.5]];
		if ( AntiAirAllowed > 0 ) then
		{
			_list = _list + [[_hummerAvenger,0.5],[_M6, 0.6]];
		};
		(unitsBuyAI select siwest) set [_i, _list];

		_list = [ [_GAZ_Vodnik, 0.5],[_GAZ_Vodnik_HMG, 0.5],[_BMP2,0.5], [_BRDM2,0.5] ];
		if ( AntiAirAllowed > 0 ) then {_list set [count _list,[_Tunguska,0.5]];};
		(unitsBuyAI select sieast) set [_i, _list];
		_i = _i + 1;

		utbTanksHeavy = _i;
		if ( HeavyArmorAllowed > 0 ) then
		{
			_list = [ [_m1a1, 0.5], [_m1a2, 0.5],[_M2A2, 0.5], [_StrMGS,0.2]];
			(unitsBuyAI select siwest) set [_i, _list];

			_list = [ [_BMP3, 0.5],[_BTR_90, 0.5],[_T72, 0.5], [_T90, 0.5],[_T72B, 0.5] ];
			(unitsBuyAI select sieast) set [_i, _list];
		}
		else
		{
			_list = [ ];
			(unitsBuyAI select siwest) set [_i, _list];
			(unitsBuyAI select sieast) set [_i, _list];
		};
		_i = _i + 1;

		utbAttackHeli = _i;
		if ( AttackChoppersAllowed > 0 ) then
		{
			_list = [ [_AH1, 0.5], [_AH64D,0.5],[_AH6, 0.5]];
			(unitsBuyAI select siwest) set [_i, _list];
			_list = [ [_MI24_V, 0.5], [_MI24_P,0.5], [_V80, 0.5], [_V80Black,0.5] ];
			(unitsBuyAI select sieast) set [_i, _list];
		}
		else
		{
			_list = [ ];
			(unitsBuyAI select siwest) set [_i, _list];
			(unitsBuyAI select sieast) set [_i, _list];
		};
		_i = _i + 1;

		utbAA = _i;
		if ( AntiAirAllowed > 0 ) then
		{
			_list = [ [_soldierAAW, 0.5], [_hummerAvenger, 1] ];
			(unitsBuyAI select siwest) set [_i, _list];
			_list = [ [_soldierAAE, 0.5], [_Tunguska, 1] ];
			(unitsBuyAI select sieast) set [_i, _list];
		}
		else
		{
			_list = [ ];
			(unitsBuyAI select siwest) set [_i, _list];
			(unitsBuyAI select sieast) set [_i, _list];
		};
		_i = _i + 1;

		utbTransport = _i;
		_list = [ [utTruckWest,0.3], [_uh60W, 0.7] ];
		(unitsBuyAI select siwest) set [_i, _list];
		_list = [ [utTruckEast, 0.3], [_mi17, 0.7] ];
		(unitsBuyAI select sieast) set [_i, _list];
		_i = _i + 1;

		utbTransportAir = _i;
		_list = [ [_uh60W, 1] ];
		(unitsBuyAI select siwest) set [_i, _list];
		_list = [ [_mi17, 1] ];
		(unitsBuyAI select sieast) set [_i, _list];
		_i = _i + 1;

		utbSupport = _i;
		_list = [ [utSupportAPCWest, 1] ];
		(unitsBuyAI select siwest) set [_i, _list];
		_list = [ [utSupportAPCEast, 1] ];
		(unitsBuyAI select sieast) set [_i, _list];
		_i = _i + 1;

		utbComm = _i;
		_list = [ [_soldierW, 0.5] ];
		if ( HeavyArmorAllowed > 0 ) then {_list = _list + [[_m1a1,0.7]];};
		if ( AntiAirAllowed > 0 ) then {_list = _list + [[_hummerAvenger,0.5]];};
		(unitsBuyAI select siwest) set [_i, _list];

		_list = [ [_soldierE, 0.5] ];
		if ( HeavyArmorAllowed > 0 ) then {_list = _list + [[_T72,0.7]];};
		if ( AntiAirAllowed > 0) then {_list = _list + [[_Tunguska,0.5]];};
		(unitsBuyAI select sieast) set [_i, _list];
		_i = _i + 1;
	}
	else
	{
		utbNone = 0;
		utbMixed = 1;
		utbInfMixed = 2;
		utbCars = 3;
		utbTanksLight = 4;
		utbTanksHeavy = 5;
		utbAttackHeli = 6;
		utbAA = 7;
		utbArtillery = 8;
		utbTransport = 9;
		utbTransportAir = 10;
		utbSupport = 11;
		utbDivers = 12;

		unitDefs = [];
		unitsBuyAI = [ [[]],[[]],[[]],[[]],[[]],[[]] ];
		unitsAvgPrice = [ [[]],[[]],[[]],[[]],[[]],[[]] ];
		unitsMaxPrice = [ [[]],[[]],[[]],[[]],[[]],[[]] ];
		factoryAvgPrice = [ [[]],[[]],[[]],[[]],[[]],[[]] ];

		{
			_side = _x;
			{
				_cat = _x;
				(unitsBuyAI select _side) set [_cat,[]];
			}forEach [utbNone, utbMixed, utbInfMixed, utbCars, utbTanksLight, utbTanksHeavy, utbAttackHeli, utbAA, utbArtillery, utbTransport, utbTransportAir, utbSupport, utbDivers];
		}forEach [siWest, siEast, siRes];

		airTransport = [ [], [],[],[],[],[] ];
		groundTransport = [ [], [],[],[],[],[] ];

		typesRearm = [ [], [],[],[],[],[] ];
		typesRepair = [ [], [],[],[],[],[] ];
		typesRefuel = [ [], [],[],[],[],[] ];
		typesSupport = [ [], [],[],[],[],[] ];

		infTown = [ [],[],[],[],[],[] ];
		carTown = [ [],[],[],[],[],[] ];
		apcTown = [ [],[],[],[],[],[] ];
		armorTown = [ [],[],[],[],[],[] ];
		staticTown = [ [],[],[],[],[],[] ];
		lightsTown = [ [],[],[],[],[],[] ];
		airTown = [ [],[],[],[],[],[] ];

		unitsBuilt = [ [], [], [], [] ];

		_type = 0;

		unitDefs set [_type, ["Crew BLUFOR", 90, siWest, 7, "B_Soldier_F", stPrebuiltBarracks, [], sQSoldier, [], [],[] ] ];
		utCrewW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Crew OPFOR", 90, siEast,7, "O_Soldier_F", stPrebuiltBarracks, [], sQSoldier, [], [],[] ] ];
		utCrewE = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Soldier", 100, siRes, 0, "C_man_1", stPrebuiltBarracks, [], sQSoldier, [], [],[] ] ];
		_crewR = _type;
		_type = _type + 1;

		unitDefs set [_type, ["MHQ West", 50000, siWest, 10, "B_APC_Wheeled_01_cannon_F", stPrebuiltLight, [1, utCrewW,0], SQMHQ, ["InitMHQ.sqf"], ["InitMHQ.sqf"],[] ] ];
		utMHQWest = _type;
		_type = _type + 1;
		unitDefs set [_type, ["Fake MHQ West", 5000, siWest, 10, "B_APC_Wheeled_01_cannon_F", stLight, [1, utCrewW,0], SQAPC, [], [],[] ] ];
		FakeMHQWest = _type;
		_type = _type + 1;

		unitDefs set [_type, ["MHQ East", 50000, siEast, 10, "O_APC_Wheeled_02_rcws_F", stPrebuiltLight, [1, utCrewE,0], SQMHQ, ["InitMHQ.sqf"], ["InitMHQ.sqf"],[] ] ];
		utMHQEast = _type;
		_type = _type + 1;
		unitDefs set [_type, ["Fake MHQ East", 5000, siEast, 10, "O_APC_Wheeled_02_rcws_F", stLight, [1, utCrewE,0], SQAPC, [], [],[] ] ];
		FakeMHQEast = _type;
		_type = _type + 1;

		typesFakeMHQ = [[FakeMHQWest],[FakeMHQEast],[],[],[],[]];

		unitDefs set [_type, ["Truck", 300, siWest, 30, "B_Truck_01_transport_F", stLight, [1, utCrewW,0], SQTruck, ["InitTruck.sqf"], ["InitTruck.sqf"],[] ] ];
		utTruckWest = _type;
		groundTransport set [siWest, [utTruckWest] ];
		_type = _type + 1;

		unitDefs set [_type, ["Truck", 300, siEast, 30, "O_Truck_02_transport_F", stLight, [1, utCrewE,0], SQTruck, ["InitTruck.sqf"], ["InitTruck.sqf"],[] ] ];
		utTruckEast = _type;
		groundTransport set [siEast, [utTruckEast] ];
		_type = _type + 1;

		unitDefs set [_type, ["Worker", costWorker, siWest, 7, "B_soldier_repair_F", stPrebuiltBarracks, [], sQSoldier, ["UpdateWorker.sqf"], [],[] ] ];
		utWorkerW = _type;
		_type = _type + 1;

		unitDefs set [_type, ["Worker", costWorker, siEast,7, "O_soldier_repair_F", stPrebuiltBarracks, [], sQSoldier, ["UpdateWorker.sqf"], [],[] ] ];
		utWorkerE = _type;
		_type = _type + 1;

		_availfactions = [];

		_BaseClasses = ["Man","LandVehicle", "Air", "Ship"];
		_ExcludeClasses = ["ParachuteBase"];

		_WestFactions = AutoFactionsWest;
		_EastFactions = AutoFactionsEast;
		_ResFactions = AutoFactionsRes;
		_CivFactions = AutoFactionsCiv;

		diag_log format["West Factions: %1", _WestFactions];
		diag_log format["East Factions: %1", _EastFactions];
		diag_log format["Res Factions: %1", _ResFactions];
		diag_log format["Civ Factions: %1", _CivFactions];

		// Sort Wieheikels
		_cfgVehicles = [];
		_cfgfile = configFile >> "CfgVehicles";
		_count = count(_cfgfile);

		for [ {_i=0}, {_i<_count}, {_i=_i+1}] do
		{
			_entry = (_cfgfile) select _i;

			if ( isClass _entry ) then
			{
				_class = configName _entry;
				_scope = getNumber(_entry >> "scope");
				_vehicleclass = getText(_entry >> "vehicleClass");

				if ( _vehicleclass == "MenVR" ) then {_scope = 0;};

				if ( _scope == 2 ) then
				{
					_name = getText(_entry >> "displayName");
					_cfgVehicles set [count(_cfgVehicles),[_class, _name, _name call funcStringHash]];
				};
			};
		};

		// Sort ...
		pvServerInfo = format["Server is sorting Unitlist ..."];
		_nul = [pvServerInfo] execVM "Player\MsgServerInfo.sqf";
		publicVariable "pvServerInfo";

		_cfgVehicles = [2,true, _cfgVehicles] call funcSortStrings;

		_manidx = [];
		_bikeidx = [];
		_caridx = [];
		_apcidx = [];
		_tankidx = [];
		_heliidx = [];
		_planeidx = [];
		_shipidx = [];
		_restidx = [];

		{
			_entry = configFile>>"CfgVehicles" >> (_x select 0);
			_class = configName _entry;

			_rest = true;
			if ( _class isKindOf "Man" ) then
			{
				_manidx = _manidx + [_forEachIndex];
				_rest = false;
			};

			if ( _class isKindOf "Motorcycle" || _class isKindOf "Quadbike_01_Base_F" ) then
			{
				_bikeidx = _bikeidx + [_forEachIndex];
				_rest = false;
			};

			if ( (_class isKindof "Car" || _class isKindof "Car_F") && !(_class isKindof "Wheeled_APC_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC" )) then
			{
				_caridx = _caridx + [_forEachIndex];
				_rest = false;
			};

			if ( _class isKindof "Wheeled_APC_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC" ) then
			{
				_apcidx = _apcidx + [_forEachIndex];
				_rest = false;
			};

			if ( (_class isKindof "Tank" || _class isKindof "Tank_F") && !(_class isKindof "Wheeled_APC_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC" )) then
			{
				_tankidx = _tankidx + [_forEachIndex];
				_rest = false;
			};

			if ( _class isKindOf "Helicopter" ) then
			{
				_heliidx = _heliidx + [_forEachIndex];
				_rest = false;
			};

			if ( _class isKindOf "Plane" ) then
			{
				_planeidx = _planeidx + [_forEachIndex];
				_rest = false;
			};

			if ( _class isKindOf "Ship" ) then
			{
				_shipidx = _shipidx + [_forEachIndex];
				_rest = false;
			};

			if ( _rest ) then
			{
				_restidx = _restidx + [_forEachIndex];
			};

		}forEach _cfgVehicles;

		_idxlist = _manidx + _bikeidx + _caridx + _apcidx + _tankidx + _heliidx + _planeidx + _shipidx + _restidx;

		{
			_class = (_cfgVehicles select _x) select 0;
			_entry = configFile >> "CfgVehicles" >> _class;
			_faction = getText(_entry >> "faction");
			_sidenum = getNumber(_entry >> "side");

			if ( !(_faction in _availfactions) ) then
			{
				_availfactions = _availfactions + [_faction];
			};

			_crew = getText(_entry >> "crew");
			_typicalCargo = getArray(_entry >> "typicalCargo");
			_cost = getNumber(_entry >> "cost");

			_weptmp = (_class call funcGetVehicleWeapons);

			_weapons = _weptmp select 0;
			_mags = _weptmp select 1;
			_turretcount = _weptmp select 2;
			_cargoturrets = _weptmp select 5;

			_hascommander = count(_weptmp select 4);
			_hasdriver = getNumber(_entry >> "hasDriver");

			_threat = getArray(_entry >> "threat");
			_armorBasic = getNumber(_entry >> "armor");

			_armorStructural = getNumber(_entry >> "armorStructural");
			_armorFuel = getNumber(_entry >> "armorFuel");
			_armorGlass = getNumber(_entry >> "armorGlass");
			_armorLights = getNumber(_entry >> "armorLights");
			_armorWheels = getNumber(_entry >> "armorWheels");
			_armorHull = getNumber(_entry >> "armorHull");
			_armorTurret = getNumber(_entry >> "armorTurret");
			_armorGun = getNumber(_entry >> "armorGun");
			_armorEngine = getNumber(_entry >> "armorEngine");
			_armorTracks = getNumber(_entry >> "armorTracks");
			_armorAvionics = getNumber(_entry >> "armorAvionics");
			_armorVRotor = getNumber(_entry >> "armorVRoto");
			_armorHRotor = getNumber(_entry >> "armorHRoto");
			_armorMissiles = getNumber(_entry >> "armorMissiles");

			if ( _armorStructural > 100 ) then {_armorStructural = _armorStructural * 0.01;};
			if ( _armorStructural > 10 ) then {_armorStructural = _armorStructural * 0.1;};

			_armor = 0;
			_armor = _armor + _armorBasic*_armorStructural;
			_armor = _armor + _armorBasic*_armorFuel;
			_armor = _armor + _armorBasic*_armorGlass;
			_armor = _armor + _armorBasic*_armorLights;
			_armor = _armor + _armorBasic*_armorWheels;
			_armor = _armor + _armorBasic*_armorHull;
			_armor = _armor + _armorBasic*_armorTurret;
			_armor = _armor + _armorBasic*_armorGun;
			_armor = _armor + _armorBasic*_armorEngine;
			_armor = _armor + _armorBasic*_armorTracks;
			_armor = _armor + _armorBasic*_armorAvionics;
			_armor = _armor + _armorBasic*_armorVRotor;
			_armor = _armor + _armorBasic*_armorHRotor;
			_armor = _armor + _armorBasic*_armorMissiles;

			_name = getText(_entry >> "displayName");
			_namestr = format["%1 (%2)", _name,_faction];

			_transportammo = getNumber(_entry >> "Transportammo");
			_transportfuel = getNumber(_entry >> "Transportfuel") + getNumber(_entry >> "ace_refuel_fuelCargo");
			_transportrepair = getNumber(_entry >> "Transportrepair") + getNumber(_entry >> "ace_repair_canRepair");
			_transportsoldier = getNumber(_entry >> "Transportsoldier") + count(_cargoturrets);
			_artyscanner = getNumber(_entry >> "Artilleryscanner");
			_isartyvehicle = getNumber(_entry >> "arty_isartyvehicle");
			_isaceartyvehicle = getNumber(_entry >> "ace_arty_isarty");
			_isattendant = getNumber(_entry >> "attendant");
			_isUAV = getNumber(_entry >> "isUAV");

			_isDiver = false;
			if ( _class isKindOf "B_Soldier_diver_base_F" || _class isKindOf "O_Soldier_diver_base_F" || _class isKindOf "I_Soldier_diver_base_F" ) then
			{
				_isDiver = true;
			};

			_isarty = false;
			if ( _artyscanner != 0 || _isartyvehicle != 0 || _isaceartyvehicle != 0) then
			{
				_isarty = true;
			};

			_buycat = [utbNone];
			_price = 0;
			_hit = 0;
			_side = siNone;
			_buildtime = 5;
			_factory = -1;
			_crewarray = [];
			_crewcount = 0;
			_marker = sqSoldier;
			_scriptServer = [];
			_scriptPlayer = [];
			_rearm = [];
			_probability = 1.0;

			_isBaseClass = false;
			{
				if ( _class isKindOf _x ) then
				{
					_isBaseClass = true;
				};
			}forEach _BaseClasses;

			{
				if ( _class isKindOf _x ) then
				{
					_isBaseClass = false;
				};
			}forEach _ExcludeClasses;

			if ( _isBaseClass ) then
			{
				{
					if( _x != "Throw" && _x != "Put") then
					{
						_hit = _hit + (_x call funcGetWeaponHitValue);
					};
				}forEach _weapons;

				{
					if ( _faction == _x && _sidenum == 1) then
					{
						_side = siWest;
					};
				}forEach _WestFactions;
				{
					if ( _faction == _x && _sidenum == 0) then
					{
						_side = siEast;
					};
				}forEach _EastFactions;
				{
					if ( _faction == _x && _sidenum == 2) then
					{
						_side = siRes;
					};
				}forEach _ResFactions;
				{
					if ( _faction == _x && _sidenum == 3) then
					{
						_side = siCiv;
					};
				}forEach _CivFactions;

				if ( call compile format["!isNil ""auto_unit_%1"";", _crew]) then
				{
					call compile format ["auto_crewtype = auto_unit_%1;", _crew];
					//diag_log format ["auto_crewtype = auto_unit_%1;", _crew];
				}
				else
				{
					auto_crewtype = _crewR;
					if ( _side == siWest ) then
					{
						auto_crewtype = utCrewW;

					};
					if ( _side == siEast ) then
					{
						auto_crewtype = utCrewE;
					};
					//diag_log format ["auto_crewtype = crew from side %1", _side];
				};

				_crewcount = 0;

				if ( _hasDriver == 1 ) then
				{
					_crewcount = _crewcount + 1;
				};

				if ( _turretcount > 0 ) then
				{
					_crewcount = _crewcount + 1;
				};

				if ( _hascommander > 0 ) then
				{
					_crewcount = _crewcount + 1;
				};

				_crewarray = [_crewcount, auto_crewtype,0];

				//diag_log format["%1 hit: %2 armor: %3", _namestr, _hit, _armor];
				//diag_log format["---------"];

				if ( _class isKindof "Man" ) then
				{

					if ( _hit < 100 ) then
					{
						_price = 50 + (_hit*10);
					}
					else
					{
						_price = 200 + _hit;
					};

					_buildtime = 5;
					_factory = stBarracks;
					_marker = sqSoldier;
					_crewarray = [];
					_crewcount = 0;

					_buycat = [utbInfMixed, utbMixed];

					if ( _isDiver ) then
					{
						_factory = stMarina;
						_buycat = [utbDivers];
					};

				};

				if ( _class isKindof "StaticWeapon" ) then
				{
					_price = 500 + _hit + _armor;

					_buildtime = 30;
					_factory = -1;
					_marker = sqSoldier;

					_buycat = [utbNone];
				};

				if ( _class isKindof "Motorcycle" || _class isKindOf "Quadbike_01_Base_F") then
				{
					_price = 50 + _hit + _armor;

					_buildtime = 10;
					_factory = stLight;
					_marker = SQBike;
					_buycat = [utbNone];
				};

				if ( (_class isKindof "Car" || _class isKindof "Car_F" ) && !(_class isKindof "Wheeled_APC_F" || _class isKindOf "Quadbike_01_Base_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC")) then
				{
					_price = 500 + _hit*5 + _armor/10;

					if ( _hit > 0 ) then
					{
						_price = _price * CarsAllowed;
					};

					_buildtime = 15;
					_factory = stLight;
					_marker = SQCar;
					_scriptServer = ["InitCar.sqf"];
					_scriptPlayer = ["InitCar.sqf"];

					_buycat = [utbCars,utbMixed];
				};

				if ( (_class isKindof "Tank" || _class isKindof "Tank_F") && !(_class isKindof "Wheeled_APC_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC")) then
				{
					_price = 2000 + _hit + _armor;

					if ( _hit > 0 ) then
					{
						_price = _price * HeavyArmorAllowed;
					};

					_buildtime = 45;
					_factory = stHeavy;
					_marker = SQTank;

					_buycat = [utbTanksHeavy];
				};

				if ( (_class isKindof "Wheeled_APC_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC") ) then
				{
					_price = 1000 + _hit + _armor;

					if ( _hit > 0 ) then
					{
						_price = _price * LightArmorAllowed;
					};

					_buildtime = 30;
					_factory = stLight;
					_marker = SQAPC;

					_buycat = [utbTanksLight,utbMixed];
				};

				if ( _class isKindof "Helicopter" ) then
				{
					_price = 4000 + _transportsoldier*100 + _hit*4 + _armor;

					_buildtime = 30;
					_factory = stAir;
					_marker = sqHeli;

					if ( _hit > 100 ) then
					{
						_buildtime = 90;
						_buycat = [utbAttackHeli];
						_price = _price * AttackChoppersAllowed;
					};
				};

				if ( _class isKindof "Plane" ) then
				{
					_price = 6000 + _hit*4 + _armor;
					_buildtime = 45;

					if ( _hit > 100 ) then
					{
						_buildtime = 90;
						_price = _price * AttackPlanesAllowed;
					};

					_factory = stAir;
					_marker = sqPlane;

				};

				if ( _class isKindof "Ship" ) then
				{
					_price = 400 + _hit + _armor;
					_scriptServer = _scriptServer + ["InitShip.sqf"];
					//_scriptPlayer = _scriptPlayer + ["InitTransportBoat.sqf"];
					_buildtime = 30;
					_factory = stMarina;
					_marker = SQBoat;

				};

				if ( _transportammo > 0 ) then
				{
					_scriptServer = _scriptServer - ["InitCar.sqf"] - ["InitTruck.sqf"];
					_scriptPlayer = _scriptPlayer - ["InitCar.sqf"] - ["InitTruck.sqf"];

					_scriptServer = _scriptServer+["InitRearmVehicle.sqf"];
					_scriptPlayer = _scriptPlayer+["InitRearmVehicle.sqf"];
					_marker = sqAmmo;
					(typesRearm select _side) set [count(typesRearm select _side),_type];
					(typesSupport select _side) set [count(typesSupport select _side),_type];
					_buycat = [utbSupport];
					_probability = 1.0;
				};
				if ( _transportfuel > 0 ) then
				{
					_scriptServer = _scriptServer - ["InitCar.sqf"] - ["InitTruck.sqf"];
					_scriptPlayer = _scriptPlayer - ["InitCar.sqf"] - ["InitTruck.sqf"];

					_scriptServer = _scriptServer+["InitRefuelVehicle.sqf"];
					_scriptPlayer = _scriptPlayer+["InitRefuelVehicle.sqf"];
					_marker = sqFuel;
					(typesRefuel select _side) set [count(typesRefuel select _side),_type];
					(typesSupport select _side) set [count(typesSupport select _side),_type];
					_buycat = [utbSupport];
					_probability = 0.1;
				};
				if ( _transportrepair > 0 ) then
				{
					_scriptServer = _scriptServer - ["InitCar.sqf"] - ["InitTruck.sqf"];
					_scriptPlayer = _scriptPlayer - ["InitCar.sqf"] - ["InitTruck.sqf"];

					_scriptServer = _scriptServer+["InitRepairVehicle.sqf"];
					_scriptPlayer = _scriptPlayer+["InitRepairVehicle.sqf"];
					_scriptPlayer = _scriptPlayer+["InitTransportTruck.sqf"];
					_marker = sqSupport;
					(typesRepair select _side) set [count(typesRepair select _side),_type];
					(typesSupport select _side) set [count(typesSupport select _side),_type];
					_buycat = [utbSupport];
					_probability = 0.25;
				};

				if ( _transportsoldier > 0 ) then
				{
					if ( _class isKindOf "LandVehicle" ) then
					{
						(groundTransport select _side) set [count(groundTransport select _side),_type];

						if ( _transportsoldier > 4 && _hit < 100 && _isattendant == 0) then
						{
							_buycat = _buycat + [utbTransport];
						};
					};
					if ( _class isKindOf "Air" && _transportsoldier > 4 && _isattendant == 0) then
					{
						_scriptPlayer = _scriptPlayer + ["InitTransportChopper.sqf"];
						(airTransport select _side) set [count(airTransport select _side),_type];
						_buycat = _buycat + [utbTransportAir];
					};
				};

				if ( (_threat select 2) > 0.85 && !(_class isKindOf "Air") ) then
				{
					if ( AntiAirAllowed == 0 ) then
					{
						_side = siNone;
						_factory = -1;
						_buycat = [utbNone];
					}
					else
					{
						_buycat = _buycat + [utbAA];
						_marker = sqAA;
						_price = _price * AntiAirAllowed;
					};
				};

				if ( _hit > 0 && (_class isKindOf "Car" || _class isKindOf "Car_F") && CarsAllowed == 0 && !_isarty ) then
				{
					_side = siNone;
					_factory = -1;
					_buycat = [utbNone];
				};

				if ( _hit > 0 && (_class isKindof "Wheeled_APC_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC") && LightArmorAllowed == 0 && !_isarty) then
				{
					_side = siNone;
					_factory = -1;
					_buycat = [utbNone];
				};

				if ( (_class isKindof "Tank" || _class isKindof "Tank_f") && !(_class isKindof "Wheeled_APC_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC") && HeavyArmorAllowed == 0 && !_isarty) then
				{
					_side = siNone;
					_factory = -1;
					_buycat = [utbNone];
				};

				if ( _hit > 100 && (_class isKindOf "Helicopter") && AttackChoppersAllowed == 0 ) then
				{
					_side = siNone;
					_factory = -1;
					_buycat = [utbNone];
				};

				if ( _hit > 100 && (_class isKindOf "Plane") && AttackPlanesAllowed == 0 ) then
				{
					_side = siNone;
					_factory = -1;
					_buycat = [utbNone];
				};

				if ( _isarty && ! (_class isKindof "StaticWeapon") ) then
				{
					if ( ArtyAllowed == 0 ) then
					{
						_side = siNone;
						_factory = -1;
						_buycat = [utbNone];
					}
					else
					{
						_factory = stHeavy;
						_buycat = [utbArtillery];
						_price = (_price + 20000)*ArtyAllowed;
						_scriptPlayer = _scriptPlayer + ["InitArtillery.sqf"];
					};
				};

				// Don't let AI buy drones
				if ( _isUAV > 0 ) then
				{
					_buycat = [utbNone];
				};

				if ( _side == siCiv ) then
				{
					_price = -_price;
					if (_class isKindOf "Man") then
					{
						_price = -10000;
					};
				};

				if (call compile format["isNil ""auto_unit_%1"";", _class] ) then
				{

					{
						if ( (_hit > 1 || (_x == utbTransport || _x == utbTransportAir) || _transportammo > 0 || _transportfuel > 0 || _transportrepair > 0) && _x > 0 && (_crewcount > 0 || (_class isKindof "Man"))) then
						{

							_blist = [];
							if (count(unitsBuyAI select _side) > _x ) then
							{
								_blist = (unitsBuyAI select _side) select _x;
							};
							if ( !isNil "_blist" ) then
							{
								_blist = _blist + [[_type,_probability]];
							}
							else
							{
								_blist = [[_type,_probability]];
							};
							(unitsBuyAI select _side) set [_x, _blist];
						};
					}forEach _buycat;

					if ( CRCTIDEBUG) then
					{
						_buildtime = 0;
					};

					// Towns
					if ( (_hit > 1 || _side == siCiv || _class isKindOf "StaticSearchLight") && (_isUAV == 0) ) then
					{
						if ( _class isKindOf "Kart_01_Base_F" ) then {_probability = 0.2;};

						if ( _class isKindof "Man" && !_isDiver) then
						{
							(infTown select _side) set [count(infTown select _side), [_type,_probability]];
						};
						if ( _class isKindof "StaticWeapon" && (!_isArty || ArtyAllowed > 0)) then
						{
							if (_class isKindof "StaticSearchLight") then
							{
								(lightsTown select _side) set [count(lightsTown select _side), [_type,_probability]];
							}
							else
							{
								(staticTown select _side) set [count(staticTown select _side), [_type,_probability]];
							};
						};
						if ( (_class isKindof "Car" || _class isKindof "Car_F" || _class isKindof "Motorcycle" ) && !(_class isKindof "Wheeled_APC_F" ||_class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC") && (CarsAllowed > 0 || _side == siCiv)) then
						{
							(carTown select _side) set [count(carTown select _side), [_type,_probability]];
						};
						if ( (_class isKindof "Tank" || _class isKindof "Tank_F") && !(_class isKindof "Wheeled_APC_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC") && HeavyArmorAllowed > 0) then
						{
							(armorTown select _side) set [count(armorTown select _side), [_type,_probability]];
						};
						if ( (_class isKindof "Wheeled_APC_F" || _class isKindof "Wheeled_APC" || _class isKindof "Tracked_APC" || _class isKindOf "APC") && LightArmorAllowed > 0) then
						{
							(apcTown select _side) set [count(apcTown select _side), [_type,_probability]];
						};
						if ( _class isKindof "Helicopter" ) then
						{
							(airTown select _side) set [count(airTown select _side), [_type,_probability]];
						};
					};

					if ( _price >= 100 && _price < 1000 ) then {_price = round(_price/10) * 10;};
					if ( _price >= 1000 && _price < 10000 ) then {_price = round(_price/100) * 100;};
					if ( _price >= 10000 ) then {_price = round(_price/1000) * 1000;};

					call compile format["auto_unit_%1 = %2;", _class, _type];
					unitDefs set [_type, [_namestr, round(_price), _side, _buildtime, _class, _factory, _crewarray, _marker, _scriptServer, _scriptPlayer,_rearm] ];
					//diag_log str(unitDefs select _type);
					_type = _type +1;
					//diag_log format["%1 %2 %3 %4", _faction, _namestr, _hit, _threat];
					//diag_log format["%1 (%2) %3 %4 %5 %6 %7 %8 %9", _class, _name, _faction, _crew, _sidenum, _cargo, _cost, _weapons, _turrets];
					//diag_log "---";

					pvServerInfo = format["Server is populating Unitlist\n%1", _class];
					_nul = [pvServerInfo] execVM "Player\MsgServerInfo.sqf";
					publicVariable "pvServerInfo";

				};

			};
		}forEach _idxlist;

		diag_log format["Available Factions: %1", _availfactions];

		if ( count(typesRearm select siWest) == 0 ) then
		{
			unitDefs set [_type, ["Ammo Truck", 500, siWest, 30, "B_Truck_01_ammo_F", stLight, [1, utCrewW,0], SQTruck, ["InitRearmVehicle.sqf"], ["InitRearmVehicle.sqf"],[] ] ];
			typesRearm set [siWest, [_type]];
			typesSupport set [siWest, (typesSupport select siWest) + [_type]];
			(unitsBuyAI select siWest) set [utbSupport, ((unitsBuyAI select siWest) select utbSupport) + [[_type,1.0]]];
			_type = _type + 1;
		};
		if ( count(typesRearm select siEast) == 0 ) then
		{
			unitDefs set [_type, ["Ammo Truck", 500, siEast, 30, "O_Truck_03_ammo_F", stLight, [1, utCrewE,0], SQTruck, ["InitRearmVehicle.sqf"], ["InitRearmVehicle.sqf"],[] ] ];
			typesRearm set [siEast, [_type]];
			typesSupport set [siEast, (typesSupport select siEast) + [_type]];
			(unitsBuyAI select siEast) set [utbSupport, ((unitsBuyAI select siEast) select utbSupport) + [[_type,1.0]]];
			_type = _type + 1;
		};
		if ( count(typesRefuel select siWest) == 0 ) then
		{
			unitDefs set [_type, ["Fuel Truck", 500, siWest, 30, "B_Truck_01_fuel_F", stLight, [1, utCrewW,0], SQTruck, ["InitRefuelVehicle.sqf"], ["InitRefuelVehicle.sqf"],[] ] ];
			typesRefuel set [siWest, [_type]];
			typesSupport set [siWest, (typesSupport select siWest) + [_type]];
			(unitsBuyAI select siWest) set [utbSupport, ((unitsBuyAI select siWest) select utbSupport) + [[_type,1.0]]];
			_type = _type + 1;
		};
		if ( count(typesRefuel select siEast) == 0 ) then
		{
			unitDefs set [_type, ["Ammo Truck", 500, siEast, 30, "O_Truck_03_fuel_F", stLight, [1, utCrewE,0], SQTruck, ["InitRefuelVehicle.sqf"], ["InitRefuelVehicle.sqf"],[] ] ];
			typesRefuel set [siEast, [_type]];
			typesSupport set [siEast, (typesSupport select siEast) + [_type]];
			(unitsBuyAI select siEast) set [utbSupport, ((unitsBuyAI select siEast) select utbSupport) + [[_type,1.0]]];
			_type = _type + 1;
		};
		if ( count(typesRepair select siWest) == 0 ) then
		{
			unitDefs set [_type, ["Repair Truck", 500, siWest, 30, "B_Truck_01_repair_F", stLight, [1, utCrewW,0], SQTruck, ["InitRepairVehicle.sqf"], ["InitRepairVehicle.sqf"],[] ] ];
			typesRepair set [siWest, [_type]];
			typesSupport set [siWest, (typesSupport select siWest) + [_type]];
			(unitsBuyAI select siWest) set [utbSupport, ((unitsBuyAI select siWest) select utbSupport) + [[_type,1.0]]];
			_type = _type + 1;
		};
		if ( count(typesRepair select siEast) == 0 ) then
		{
			unitDefs set [_type, ["Repair Truck", 500, siEast, 30, "O_Truck_03_repair_F", stLight, [1, utCrewE,0], SQTruck, ["InitRepairVehicle.sqf"], ["InitRepairVehicle.sqf"],[] ] ];
			typesRepair set [siEast, [_type]];
			typesSupport set [siEast, (typesSupport select siEast) + [_type]];
			(unitsBuyAI select siEast) set [utbSupport, ((unitsBuyAI select siEast) select utbSupport) + [[_type,1.0]]];
			_type = _type + 1;
		};
	};

	// Compile Initscripts
	pvServerInfo = "Server is compiling Initscripts ...";
	_nul = [pvServerInfo] execVM "Player\MsgServerInfo.sqf";
	publicVariable "pvServerInfo";

	{
		_scriptsServer = _x select udScriptsServer;
		_scriptsPlayer = _x select udScriptsPlayer;

		{
			_scriptsServer set [_forEachIndex, compile preProcessFileLineNumbers format["Server\%1", _x]];
		}forEach _scriptsServer;
		{
			_scriptsPlayer set [_forEachIndex, compile preProcessFileLineNumbers format["Player\%1", _x]];
		}forEach _scriptsPlayer;

		_x set [udScriptsServer, _scriptsServer];
		_x set [udScriptsPlayer, _scriptsPlayer];

	}forEach unitDefs;

	_count = count unitDefs;
	for [ {_index=0}, {_index<(count unitDefs)}, {_index=_index+1}] do
	{
		(unitsBuilt select siWest) set [_index, 0];
		(unitsBuilt select siEast) set [_index, 0];
		(unitsBuilt select siRes) set [_index, 0];
		(unitsBuilt select siCiv) set [_index, 0];
	};

	CommUnits = [];
	typesCleanup = ["WeaponHolder", "SecondaryWeaponHolder"];

// add west and east vehicles
	{
		if ( count (_x select udCrew) > 0 ) then
		{
			typesCleanup set [count typesCleanup, _x select udModel];
		};
	}foreach unitDefs;

	publicVariable "unitsBuilt";
	publicVariable "CommUnits";
	publicVariable "typesCleanup";

	publicVariable "utbNone";
	publicVariable "utbMixed";
	publicVariable "utbInfMixed";
	publicVariable "utbCars";
	publicVariable "utbTanksLight";
	publicVariable "utbTanksHeavy";
	publicVariable "utbAA";
	publicVariable "utbAttackHeli";
	publicVariable "utbArtillery";
	publicVariable "utbTransport";
	publicVariable "utbTransportAir";
	publicVariable "utbSupport";
	publicVariable "utbDivers";

	publicVariable "unitDefs";
	publicVariable "unitsBuyAI";

	publicVariable "utMHQWest";
	publicVariable "utMHQEast";
	publicVariable "utTruckWest";
	publicVariable "utTruckEast";
	publicVariable "utWorkerW";
	publicVariable "utWorkerE";
	publicVariable "utCrewW";
	publicVariable "utCrewE";

	publicVariable "airTransport";
	publicVariable "groundTransport";
	publicVariable "typesRearm";
	publicVariable "typesRepair";
	publicVariable "typesRefuel";
	publicVariable "typesSupport";
	publicVariable "typesFakeMHQ";

// Calc average Cost per Buylist (for Ai Comm and adaptive town values)
	{
		_side = _x;
		{
			_cat = _x;

			(unitsAvgPrice select _side) set [_cat, 0];
			(unitsMaxPrice select _side) set [_cat, 0];

			_catlist = (unitsBuyAI select _side) select _cat;
			if ( !isNil "_catlist") then
			{
				if ( count _catlist > 0 ) then
				{
					_count = 0;
					_total = 0;
					_max = 0;
					{
						_type = _x select 0;
						_cost = ((unitDefs select _type) select udCost) + 1000;

						if ( _cost > _max ) then {_max = _cost;};

						_count = _count + 1;
						_total = _total + _cost;
					}forEach _catlist;

					_avg = _total / _count;

					(unitsAvgPrice select _side) set [_cat, _avg];
					(unitsMaxPrice select _side) set [_cat, _max];
				};
			};
		}forEach [utbNone, utbMixed, utbInfMixed, utbCars, utbTanksLight, utbTanksHeavy, utbAttackHeli, utbAA, utbArtillery, utbTransport, utbTransportAir, utbSupport, utbDivers];
	}forEach [siWest, siEast, siRes];

// Calc average unit price per factory (for AI Comm)
	{
		_side = _x;
		{
			_facType = _x;
			(factoryAvgPrice select _side) set [_facType, 0];
			_prices = [];

			{
				_us = _x select udSide;
				_ft = _x select udFactoryType;
				_cost = (_x select udCost) + 1000;

				if ( _us == _side && _ft == _facType ) then
				{
					_prices = _prices + [[_cost]];
				};
			}forEach unitDefs;

			if ( count(_prices) > 0 ) then
			{
				// ignore upper quartil
				_prices = [0, true, _prices] call funcSort;
				_quartil = floor(count(_prices) * 0.25);

				_count=0;
				_total=0;

				for [ {_i=0}, {_i<(count(_prices)-_quartil)}, {_i=_i+1}] do
				{
					_total = _total + ((_prices select _i) select 0);
					_count = _count + 1;
				};

				if ( _count > 0 ) then
				{
					(factoryAvgPrice select _side) set [_facType, _total / _count];
				};
			};

		}forEach structsFactory;
	}forEach [siWest, siEast];

//diag_log str(factoryAvgPrice);
//diag_log str(unitsAvgPrice);
//diag_log str(unitsMaxPrice);

	UnitsPublished = true;
	publicVariable "UnitsPublished";
	endLoadingScreen;

	if ( CRCTIDEBUG ) then
	{
		{
			_cat = _x;
			diag_log str "***";
			{
				_side = _x;
				diag_log str "---";
				{
					_type = _x select 0;
					_p = _x select 1;
					diag_log format["* %1 %2", str((unitDefs select _type) select 0), _p];
				}forEach ((unitsBuyAI select _side) select _cat);
			}forEach [siWest, siEast];
		}forEach [utbMixed, utbInfMixed, utbCars, utbTanksLight,utbTanksHeavy,utbAttackHeli, utbSupport, utbDivers, utbAA, utbArtillery, utbTransportAir, utbTransport];

		{
			_t = _x select 0;
			_d = unitDefs select _t;
			diag_log str(_d);
		}forEach (infTown select siRes)+(carTown select siRes)+(apcTown select siRes)+(armorTown select siRes)+(airTown select siRes);

		{
			_t = _x select 0;
			_d = unitDefs select _t;
			diag_log str(_d);
		}forEach (infTown select siCiv)+(carTown select siCiv)+(apcTown select siCiv)+(armorTown select siCiv)+(airTown select siCiv);

	};
};
waitUntil {!isNil "UnitsPublished"};
waitUntil {UnitsPublished};
