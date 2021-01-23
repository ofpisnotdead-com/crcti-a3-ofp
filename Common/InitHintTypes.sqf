HintTimeOut = 10;

htGeneral = 0;
htScore = 1;
htBuildStruct = 2;
htBuildStructError = 3;
htRepairStruct = 4;
htHealRepair = 5;
htCommanderTimeout = 6;
htTownSideChange = 7;
htEquipmentCost = 8;
htServerInfo = 9;
htRank = 10;
htBuyUnit = 11;
htBuyUnitCancel = 12;
htTownWin = 13;
htTimeLimit = 14;
htTip = 15;
htRearm = 16;
htRearmFail = 17;
htUnlockFail = 18;
htQueueCancel = 19;
htRearmPrice = 20;
htRepairPrice = 21;
htTimeLimitExtend = 22;
htExtensionRequest = 23;
htDediWarn = 24;
htVehicleMessage = 25;
htMoneyRequest = 26;
htMoneyRequestFail = 27;
htVersionMismatch = 28;
htBAC = 29;
htRenegade = 30;
htPlayerKilled = 31;
htPlayerRespawn = 32;

hintTexts = [];

hintTypes = [htGeneral, htScore, htBuildStruct, htBuildStructError, htRepairStruct, htHealRepair, htCommanderTimeout, htTownSideChange, htEquipmentCost, htRank, htServerInfo,
			 htBuyUnit, htBuyUnitCancel, htTownWin, htTimeLimit, htTip, htRearm, htRearmFail, htUnlockFail, htQueueCancel, htPlayerKilled, htPlayerRespawn,
			 htRearmPrice, htRepairPrice, htTimeLimitExtend, htExtensionRequest, htDediWarn, htVehicleMessage, htMoneyRequest,htMoneyRequestFail,htVersionMismatch, htBAC, htRenegade];

{
	hintTexts set [_x, []];
}forEach hintTypes;

