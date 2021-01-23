class Params
{
	class p_GameMode
	{
		title = "Game Mode";
		values[] = { 0, 1, 2 };
		texts[] = { "BLUFOR vs. OPFOR", "COOP WEST", "COOP EAST" };
		default = 0;
	};

	class p_CommSlots
	{
		title = "Commander Slots";
		values[] = { 0, 1 };
		texts[] = { "Playable", "AI Only" };
		default = 0;
	};

	class p_StartPos
	{
		title = "Start Positions";
		values[] = { 0, 1, 2, 3, 4, 5, 6 };
		texts[] = { "Fixed", "Airfields", "Random", "Near", "Medium", "Far", "Maximum Separation" };
		default = 5;
	};

	class p_StartMoneyWest
	{
		title = "Start Money West";
		values[] = { 15000, 30000, 50000, 100000, 200000, 1000000 };
		texts[] = { "15000$", "30000$", "50000$", "100000$", "200000$", "1000000$" };
		default = 15000;
	};

	class p_StartMoneyEast
	{
		title = "Start Money East";
		values[] = { 15000, 30000, 50000, 100000, 200000, 1000000 };
		texts[] = { "15000$", "30000$", "50000$", "100000$", "200000$", "1000000$" };
		default = 15000;
	};

	class p_Towns
	{
		title = "Towns";
		values[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 20, 25, 50, -1 };
		texts[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "12", "15", "20", "25", "50", "All" };
		default = -1;
	};

	class p_Distribution
	{
		title = "Towns Distribution";
		values[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8 };
		texts[] = { "Random", "Compact", "2 Clusters", "3 Clusters", "4 Clusters", "Circular", "Along Axis", "String", "Evenly Distributed" };
		default = 1;
	};

	class p_TownValues
	{
		title = "Town Values";
		values[] = { 0, 1 };
		texts[] = { "Map Defaults", "Adapt to Resistance Strength" };
		default = 1;
	};

	class p_TownIncome
	{
		title = "Town Income";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800, 1000, 10000 };
		texts[] = { "No Town Income", "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "8x", "10x", "100x" };
		default = 100;
	};

	class p_IncomeLimit
	{
		title = "Town Income Limit";
		values[] = { 0, 500, 1000, 1500, 2000, 2500, 5000, 7500, 10000, 15000, 20000, 30000 };
		texts[] = { "Unlimited", "500$", "1000$", "1500$", "2000$", "2500$", "5000$", "7500$", "10000$", "15000$", "20000$", "30000$" };
		default = 0;
	};

	class p_ScoreMoneyFactor
	{
		title = "Score Money";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "0x", "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "8x" };
		default = 100;
	};

	class p_DeathPenaltyFactor
	{
		title = "Death Penalty";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "0x", "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "8x" };
		default = 0;
	};

	class p_RepairCost
	{
		title = "Repair/Rearm Cost";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "0x", "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "8x" };
		default = 100;
	};

	class p_BuildTimes
	{
		title = "Unit Build Times";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "0x", "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "8x" };
		default = 100;
	};

	class p_PrepareTimes
	{
		title = "Factory Cleanup Times";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "0x", "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "8x" };
		default = 100;
	};

	class p_Month
	{
		title = "Month";
		values[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, -1 };
		texts[] = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December",
				"Month of the Kastenbier (TM)", "Random" };
		default = 10;
	};

	class p_StartTime
	{
		title = "Start Time";
		values[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, -1 };
		texts[] = { "0:00", "1:00", "2:00", "3:00", "4:00", "5:00", "6:00", "7:00", "8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00",
				"16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "Random" };
		default = 8;
	};

	class p_SkipTimeFactor
	{
		title = "Skip Time";
		values[] = { 1, 2, 4, 6, 12, 24 };
		texts[] = { "1:1", "2:1", "4:1", "6:1", "12:1", "24:1" };
		default = 1;
	};

	class p_TimeLimit
	{
		title = "Time Limit";
		values[] = { 0, 1800, 3600, 7200, 10800, 14400, 18000, 21600, 25200, 28800, 32400, 36000 };
		texts[] =
				{ "Unlimited", "30 Minutes", "1 Hour", "2 Hours", "3 Hours", "4 Hours", "5 Hours", "6 Hours", "7 Hours", "8 Hours", "9 Hours", "10 Hours" };
		default = 0;
	};

	class p_Weather
	{
		title = "Weather";
		values[] = { -1, 0, 1, 2, 3, 4, 5 };
		texts[] = { "Random", "Clear", "Sunny", "Cloudy", "Rainy", "Poor", "Inclement" };
		default = -1;
	};

	class p_Fog
	{
		title = "Fog";
		values[] = { 0, 25, 50, 75, 100 };
		texts[] = { "Disabled", "25%", "50%", "75%", "100%" };
		default = 25;
	};

	class p_WeatherTime
	{
		title = "Minimum Weather Change Duration";
		values[] = { 15, 30, 45, 60, 90, 120, 240 };
		texts[] = { "15 Minutes", "30 Minutes", "45 Minutes", "60 Minutes", "90 Minutes", "2 Hours", "4 Hours" };
		default = 30;
	};

	class p_GroupSize
	{
		title = "Group Size";
		values[] = { 1, 2, 3, 4, 5, 8, 10, 12, 15, 20 };
		texts[] = { "1 Man", "2 Men", "3 Men", "4 Men", "5 Men", "8 Men", "10 Men", "12 Men", "15 Men", "20 Men" };
		default = 10;
	};

	class p_MaxViewDistance
	{
		title = "Max ViewDistance";
		values[] = { 500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 7500, 10000 };
		texts[] = { "500 m", "750 m", "1000 m", "1500 m", "2000 m", "2500 m", "3000 m", "3500 m", "4000 m", "4500 m", "5000 m", "7500 m", "10000 m" };
		default = 2000;
	};

	class p_MinViewDistance
	{
		title = "Min ViewDistance";
		values[] = { 500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 7500, 10000 };
		texts[] = { "500 m", "750 m", "1000 m", "1500 m", "2000 m", "2500 m", "3000 m", "3500 m", "4000 m", "4500 m", "5000 m", "7500 m", "10000 m" };
		default = 750;
	};

	class p_ObjectViewDistance
	{
		title = "Max Object ViewDistance";
		values[] = { 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 7500, 10000 };
		texts[] = { "500 m", "1000 m", "1500 m", "2000 m", "2500 m", "3000 m", "3500 m", "4000 m", "4500 m", "5000 m", "7500 m", "10000 m" };
		default = 2000;
	};

	class p_TerrainGrid
	{
		title = "Min Terrain Detail";
		values[] = { 0, 1, 2, 3, 4 };
		texts[] = { "Very Low (No Grass)", "Low", "Normal", "High", "Very High" };
		default = 2;
	};

	class p_Formation
	{
		title = "AI Groups default Formation";
		values[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
		texts[] = { "Off", "Column", "Staggered Column", "Wedge", "Echelon Left", "Echeclon Right", "Vee", "Line", "File", "Diamond",
				"Mixed Staggered Column / Line" };
		default = 0;
	};

	class p_Speed
	{
		title = "AI Groups default Speedmode";
		values[] = { 0, 1, 2 };
		texts[] = { "Limited", "Normal", "Full" };
		default = 2;
	};

	class p_Difficulty
	{
		title = "AI Skill";
		values[] = { 20, 40, 60, 80, 100 };
		texts[] = { "Don't get too rough!", "Yeah, Piece of Cake!", "Come Get Some!", "Damn I'm Good!", "Nightmare" };
		default = 80;
	};

	class p_Accuracy
	{
		title = "AI Aiming Accuracy and Speed";
		values[] = { 20, 40, 60, 80, 100 };
		texts[] = { "Duuuuuuh. Wah?", "Like your mom.", "Not bad.", "Deadly", "Elite Sniper" };
		default = 40;
	};

	class p_ResistanceInf
	{
		title = "Resistance Amount Infantry";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "Off", "Pff, you little baby. (0.25x)", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "Blow it out their asses! (8x)" };
		default = 100;
	};

	class p_ResistanceCar
	{
		title = "Resistance Amount Cars";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "Off", "Pff, you little baby. (0.25x)", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "Blow it out their asses! (8x)" };
		default = 100;
	};

	class p_ResistanceApc
	{
		title = "Resistance Amount Light Armor";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "Off", "Pff, you little baby. (0.25x)", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "Blow it out their asses! (8x)" };
		default = 100;
	};

	class p_ResistanceTank
	{
		title = "Resistance Amount Heavy Armor";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "Off", "Pff, you little baby. (0.25x)", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "Blow it out their asses! (8x)" };
		default = 100;
	};

	class p_ResistanceAir
	{
		title = "Resistance Amount Air";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "Off", "Pff, you little baby. (0.25x)", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "Blow it out their asses! (8x)" };
		default = 0;
	};

	class p_ResistanceStatic
	{
		title = "Resistance Amount Static";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400, 800 };
		texts[] = { "Off", "Pff, you little baby. (0.25x)", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x", "Blow it out their asses! (8x)" };
		default = 100;
	};

	class p_ResPatrol
	{
		title = "Resistance Patrol Groups";
		values[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
		texts[] = { "Off", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10 WTF?!" };
		default = 0;
	};

	class p_ResAmmoCrates
	{
		title = "Resistance Weapons Caches";
		values[] = { 0, 1 };
		texts[] = { "Off", "On" };
		default = 0;
	};

	class p_TownGroups
	{
		title = "Town Groups Reinforcement";
		values[] = { -100, 0, 5, 10, 25, 50, 75, 100 };
		texts[] = { "Off", "Support Trucks Only", "5% of Towns", "10% of Towns", "25% of Towns", "50% of Towns", "75% of Towns", "All Towns" };
		default = -100;
	};

	class p_Cars
	{
		title = "Cars";
		values[] = { 0, 25, 50, 75, 100, 150, 200, 400, 600, 800, 1600 };
		texts[] =
				{ "Off", "Price 0.25x", "Price 0.5x", "Price 0.75x", "Price 1x", "Price 1.5x", "Price 2x", "Price 4x", "Price 6x", "Price 8x", "Price 16x" };
		default = 100;
	};

	class p_LightArmor
	{
		title = "Light Armor";
		values[] = { 0, 25, 50, 75, 100, 150, 200, 400, 600, 800, 1600 };
		texts[] =
				{ "Off", "Price 0.25x", "Price 0.5x", "Price 0.75x", "Price 1x", "Price 1.5x", "Price 2x", "Price 4x", "Price 6x", "Price 8x", "Price 16x" };
		default = 100;
	};

	class p_HeavyArmor
	{
		title = "Heavy Armor";
		values[] = { 0, 25, 50, 75, 100, 150, 200, 400, 600, 800, 1600 };
		texts[] =
				{ "Off", "Price 0.25x", "Price 0.5x", "Price 0.75x", "Price 1x", "Price 1.5x", "Price 2x", "Price 4x", "Price 6x", "Price 8x", "Price 16x" };
		default = 100;
	};

	class p_AttackChoppers
	{
		title = "Attack Choppers";
		values[] = { 0, 25, 50, 75, 100, 150, 200, 400, 600, 800, 1600 };
		texts[] =
				{ "Off", "Price 0.25x", "Price 0.5x", "Price 0.75x", "Price 1x", "Price 1.5x", "Price 2x", "Price 4x", "Price 6x", "Price 8x", "Price 16x" };
		default = 100;
	};

	class p_AttackPlanes
	{
		title = "Attack Planes";
		values[] = { 0, 25, 50, 75, 100, 150, 200, 400, 600, 800, 1600 };
		texts[] =
				{ "Off", "Price 0.25x", "Price 0.5x", "Price 0.75x", "Price 1x", "Price 1.5x", "Price 2x", "Price 4x", "Price 6x", "Price 8x", "Price 16x" };
		default = 100;
	};

	class p_AntiAir
	{
		title = "Anti Air Units";
		values[] = { 0, 25, 50, 75, 100, 150, 200, 400, 600, 800, 1600 };
		texts[] =
				{ "Off", "Price 0.25x", "Price 0.5x", "Price 0.75x", "Price 1x", "Price 1.5x", "Price 2x", "Price 4x", "Price 6x", "Price 8x", "Price 16x" };
		default = 100;
	};

	class p_Arty
	{
		title = "Artillery";
		values[] = { 0, 25, 50, 75, 100, 150, 200, 400, 600, 800, 1600 };
		texts[] =
				{ "Off", "Price 0.25x", "Price 0.5x", "Price 0.75x", "Price 1x", "Price 1.5x", "Price 2x", "Price 4x", "Price 6x", "Price 8x", "Price 16x" };
		default = 0;
	};

	class p_SatcamPrice
	{
		title = "SatCam Price";
		values[] = { -1, 0, 1000, 10000, 50000, 100000, 800000 };
		texts[] = { "Off", "0$", "1000$", "10000$", "50000$", "100000$", "800000$" };
		default = 100000;
	};

	class p_TIE
	{
		title = "Vehicle Thermal Imaging Equipment";
		values[] = { 0, 1 };
		texts[] = { "Disabled", "Enabled" };
		default = 1;
	};

	class p_TeamSwitch
	{
		title = "Side Switch OPFOR/BLUFOR";
		values[] = { 0, 1 };
		texts[] = { "Disabled", "Allowed" };
		default = 1;
	};

	class p_UnitSwitch
	{
		title = "Unit Switch";
		values[] = { 0, 1 };
		texts[] = { "Disabled", "Allowed" };
		default = 1;
	};

	class p_MHQRepairCost
	{
		title = "MHQ Repair Cost";
		values[] = { 0, 1000, 10000, 50000, 200000, 1000000, 10000000 };
		texts[] = { "0$", "1000$", "10000$", "50000$", "200000$", "1000000$", "10000000$" };
		default = 200000;
	};

	class p_Ambciv
	{
		title = "Civilians";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400 };
		texts[] = { "Off", "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x" };
		default = 0;
	};

	class p_AmbcivVeh
	{
		title = "Civilian Vehicles";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400 };
		texts[] = { "Off", "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x" };
		default = 100;
	};

	class p_AmbCivTraffic
	{
		title = "Civilian Traffic";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 200, 400 };
		texts[] = { "Off", "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x", "4x" };
		default = 0;
	};

	class p_Map
	{
		title = "Map Updates";
		values[] = { 0, 1, 2, 3 };
		texts[] = { "Manual", "Semi (Leaders Only)", "Semi (All)", "Realtime" };
		default = 3;
	};

	class p_GPS
	{
		title = "GPS";
		values[] = { 0, 1 };
		texts[] = { "Unavailable", "Available" };
		default = 1;
	};

	class p_Leaderboard
	{
		title = "In-game Leaderboard";
		values[] = { 0, 1, 2 };
		texts[] = { "No Scores", "Own side only", "Both sides" };
		default = 2;
	};

	class p_Fatigue
	{
		title = "Fatigue / Stamina";
		values[] = { 0, 1, 2, 3 };
		texts[] = { "Disabled", "AI Only", "Players Only", "Enabled" };
		default = 3;
	};

	class p_FatigueLimit
	{
		title = "Fatigue Limit";
		values[] = { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
		texts[] = { "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" };
		default = 50;
	};

	class p_WeaponSway
	{
		title = "Weapon Sway Factor";
		values[] = { 0, 25, 50, 75, 100, 125, 150, 175, 200, 300, 400 };
		texts[] = { "0x", "0.25x", "0.5x", "0.75x", "1.0x", "1.25x", "1.5x", "1.75x", "2.0x", "3.0x", "4.0x" };
		default = 100;
	};

	/*class p_AceWounds
	 {
	 title = "ACE Wounds";
	 values[] = { 0, 1 };
	 texts[] = { "Disabled", "Enabled" };
	 default = 0;
	 };

	 class p_AceWoundsAI
	 {
	 title = "ACE Wounds for AI";
	 values[] = { 0, 1 };
	 texts[] = { "Disabled", "Enabled" };
	 default = 0;
	 };

	 class p_AceDamage
	 {
	 title = "ACE Vehicle Damage System";
	 values[] = { 0, 1 };
	 texts[] = { "Disabled", "Enabled" };
	 default = 0;
	 };*/

	class p_AcreChannel
	{
		title = "ACRE Channel ID";
		values[] = { -1,
				0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
				10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
				20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
				30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
				40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
				50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
				60, 61, 62, 63, 64, 65, 66, 67, 68, 69,
				70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
				80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
				90, 91, 92, 93, 94, 95, 96, 97, 98, 99
		};
		texts[] = { "Disabled" };
		default = -1;
	};

	class p_AcreLossModelScale
	{
		title = "ACRE / TFR Terrain Interference";
		values[] = { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
		texts[] = { "0% No Terrain Interference", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100% Full Interference" };
		default = 100;
	};

	class p_ClearBase
	{
		title = "Clear Base Area";
		values[] = { 0, 1 };
		texts[] = { "Disabled", "Enabled" };
		default = 1;
	};

	class p_BuildInTowns
	{
		title = "Build Structures near Townflags";
		values[] = { 0, 1, 2 };
		texts[] = { "Forbidden", "Statics only", "Allowed" };
		default = 2;
	};

	class p_Intro
	{
		title = "Intro Sequence";
		values[] = { 0, 1, 2 };
		texts[] = { "Disabled", "Cinematic", "Chopper Insertion" };
		default = 1;
	};

	class p_NoPlayerTimeout
	{
		title = "No Player Timeout";
		values[] = { 0, 5, 15, 30, 60, 120, 240 };
		texts[] = { "No Limit", "5 Minutes", "15 Minutes", "30 Minutes", "60 Minutes", "120 Minutes", "240 Minutes" };
		default = 30;
	};

	class p_AdminFunctions
	{
		title = "Admin Functions";
		values[] = { 0, 1 };
		texts[] = { "Disabled", "Enabled" };
		default = 1;
	};
};
