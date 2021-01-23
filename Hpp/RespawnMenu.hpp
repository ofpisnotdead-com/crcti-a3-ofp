class RespawnMenu: Menu
{
	idd = IDD_RespawnMenu;
	movingEnable = true;
	controlsBackground[] = { RespawnBackgroundWindow };
	objects[] = { };
	controls[] = { RespawnTitle, SelectedRespawnType, SelectedRespawnPos,
			TimeToRespawn, RespawnMHQ, RespawnMHQPos, RespawnStruct0,
			RespawnStruct0Pos, RespawnStruct1, RespawnStruct1Pos,
			RespawnStruct2, RespawnStruct2Pos, RespawnStruct3,
			RespawnStruct3Pos, RespawnStruct4, RespawnStruct4Pos,
			RespawnStruct5, RespawnStruct5Pos, RespawnStruct6,
			RespawnStruct6Pos };

	class RespawnBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.02;
		y = 0.05;
		w = 0.63;
		h = 0.7;
	};

	class RespawnTitle: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		x = 0.02;
		y = 0.05;
		w = 0.63;
		style = ST_LEFT;
		text = "Current Respawn";
	};
	class SelectedRespawnType: DataText
	{
		idc = IDC_TEXT_RESPAWN_TYPE;
		style = ST_LEFT;
		x = 0.035;
		y = 0.14;
		w = 0.4;
		text = "SelectedRespawnType";
	};
	class SelectedRespawnPos: DataText
	{
		idc = IDC_TEXT_RESPAWN_POS;
		style = ST_LEFT;
		x = 0.035;
		y = 0.17;
		w = 0.4;
		text = "SelectedRespawnPos";
	};
	class TimeToRespawn: Label
	{
		idc = IDC_TEXT_MENU_STATUS;
		style = ST_LEFT;
		x = 0.035;
		y = 0.20;
		w = 0.4;
		text = "TimeToRespawn";
	};
	class RespawnMHQ: RscButtonLarge
	{
		idc = IDC_BTN_RESPAWN_MHQ;
		x = 0.035;
		y = 0.28;
		w = 0.273;
		text = "MHQ";
		action = "buttonPressedSetRespawnType = 10";
	};
	class RespawnMHQPos: DataText
	{
		idc = IDC_TEXT_RESPAWN_MHQ;
		x = 0.325;
		y = 0.28;
		w = 0.3;
		text = "MHQ";
	};
	class RespawnStruct0: RscButtonLarge
	{
		idc = IDC_BTN_RESPAWN_STRUCT + 0;
		x = 0.035;
		y = 0.33;
		w = 0.273;
		text = "";
		action = "buttonPressedSetRespawnType = 0";
	};
	class RespawnStruct0Pos: RscCombo
	{
		idc = IDC_CB_RESPAWN_STRUCT + 0;
		x = 0.325;
		y = 0.335;
		w = 0.3;
	};
	class RespawnStruct1: RscButtonLarge
	{
		idc = IDC_BTN_RESPAWN_STRUCT + 1;
		x = 0.035;
		y = 0.38;
		w = 0.273;
		text = "";
		action = "buttonPressedSetRespawnType = 1";

	};
	class RespawnStruct1Pos: RscCombo
	{
		idc = IDC_CB_RESPAWN_STRUCT + 1;
		x = 0.325;
		y = 0.385;
		w = 0.3;
	};
	class RespawnStruct2: RscButtonLarge
	{
		idc = IDC_BTN_RESPAWN_STRUCT + 2;
		x = 0.035;
		y = 0.43;
		w = 0.273;
		text = "";
		action = "buttonPressedSetRespawnType = 2";
	};
	class RespawnStruct2Pos: RscCombo
	{
		idc = IDC_CB_RESPAWN_STRUCT + 2;
		x = 0.325;
		y = 0.435;
		w = 0.3;
	};
	class RespawnStruct3: RscButtonLarge
	{
		idc = IDC_BTN_RESPAWN_STRUCT + 3;
		x = 0.035;
		y = 0.48;
		w = 0.273;
		text = "";
		action = "buttonPressedSetRespawnType = 3";
	};
	class RespawnStruct3Pos: RscCombo
	{
		idc = IDC_CB_RESPAWN_STRUCT + 3;
		x = 0.325;
		y = 0.485;
		w = 0.3;
	};
	class RespawnStruct4: RscButtonLarge
	{
		idc = IDC_BTN_RESPAWN_STRUCT + 4;
		x = 0.035;
		y = 0.53;
		w = 0.273;
		text = "";
		action = "buttonPressedSetRespawnType = 4";
	};
	class RespawnStruct4Pos: RscCombo
	{
		idc = IDC_CB_RESPAWN_STRUCT + 4;
		x = 0.325;
		y = 0.535;
		w = 0.3;
	};
	class RespawnStruct5: RscButtonLarge
	{
		idc = IDC_BTN_RESPAWN_STRUCT + 5;
		x = 0.035;
		y = 0.58;
		w = 0.273;
		text = "";
		action = "buttonPressedSetRespawnType = 5";
	};
	class RespawnStruct5Pos: RscCombo
	{
		idc = IDC_CB_RESPAWN_STRUCT + 5;
		x = 0.325;
		y = 0.585;
		w = 0.3;
	};
	class RespawnStruct6: RscButtonLarge
	{
		idc = IDC_BTN_RESPAWN_STRUCT + 6;
		x = 0.035;
		y = 0.63;
		w = 0.273;
		text = "";
		action = "buttonPressedSetRespawnType = 6";
	};
	class RespawnStruct6Pos: RscCombo
	{
		idc = IDC_CB_RESPAWN_STRUCT + 6;
		x = 0.325;
		y = 0.635;
		w = 0.3;
	};
};

