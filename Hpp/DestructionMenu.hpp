class DestructionMenu: Menu
{
	idd = IDD_DestructMenu;
	movingEnable = true;
	controlsBackground[] = { DestructBackgroundWindow };
	objects[] = { };
	controls[] = { DestructTitle, SelectedDestructType, SelectedDestructPos,
			DestructMHQ, DestructMHQPos, DestructStruct0, DestructStruct0Pos,
			DestructStruct1, DestructStruct1Pos, DestructStruct2,
			DestructStruct2Pos, DestructStruct3, DestructStruct3Pos,
			DestructStruct4, DestructStruct4Pos, DestructStruct5,
			DestructStruct5Pos, DestructStruct6, DestructStruct6Pos, Exit };

	class DestructBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.02;
		y = 0.05;
		w = 0.625;
		h = 0.75;
	};

	class DestructTitle: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		x = 0.02;
		y = 0.05;
		w = 0.625;
		style = ST_LEFT;
		text = "Current Destroy Target:";
	};
	class SelectedDestructType: DataText
	{
		idc = IDC_TEXT_DESTRUCT_TYPE;
		style = ST_LEFT;
		x = 0.035;
		y = 0.14;
		w = 0.4;
		text = "SelectedDestructType";
	};
	class SelectedDestructPos: DataText
	{
		idc = IDC_TEXT_DESTRUCT_POS;
		style = ST_LEFT;
		x = 0.035;
		y = 0.17;
		w = 0.4;
		text = "SelectedDestructPos";
	};
	class DestructMHQ: RscButtonLarge
	{
		idc = IDC_BTN_DESTRUCT_MHQ;
		x = 0.035;
		y = 0.28;
		w = 0.275;
		text = "MHQ";
		action = "buttonPressedSetDestructType = 10";
	};
	class DestructMHQPos: DataText
	{
		idc = IDC_TEXT_DESTRUCT_MHQ;
		x = 0.325;
		y = 0.28;
		w = 0.3;
		text = "MHQ";
	};
	class DestructStruct0: RscButtonLarge
	{
		idc = IDC_BTN_DESTRUCT_STRUCT + 0;
		x = 0.035;
		y = 0.33;
		w = 0.275;
		text = "";
		action = "buttonPressedSetDestructType = 0";
	};
	class DestructStruct0Pos: RscCombo
	{
		idc = IDC_CB_DESTRUCT_STRUCT + 0;
		x = 0.325;
		y = 0.335;
		w = 0.3;
	};
	class DestructStruct1: RscButtonLarge
	{
		idc = IDC_BTN_DESTRUCT_STRUCT + 1;
		x = 0.035;
		y = 0.38;
		w = 0.275;
		text = "";
		action = "buttonPressedSetDestructType = 1";
	};
	class DestructStruct1Pos: RscCombo
	{
		idc = IDC_CB_DESTRUCT_STRUCT + 1;
		x = 0.325;
		y = 0.385;
		w = 0.3;
	};
	class DestructStruct2: RscButtonLarge
	{
		idc = IDC_BTN_DESTRUCT_STRUCT + 2;
		x = 0.035;
		y = 0.43;
		w = 0.275;
		text = "";
		action = "buttonPressedSetDestructType = 2";
	};
	class DestructStruct2Pos: RscCombo
	{
		idc = IDC_CB_DESTRUCT_STRUCT + 2;
		x = 0.325;
		y = 0.435;
		w = 0.3;
	};
	class DestructStruct3: RscButtonLarge
	{
		idc = IDC_BTN_DESTRUCT_STRUCT + 3;
		x = 0.035;
		y = 0.48;
		w = 0.275;
		text = "";
		action = "buttonPressedSetDestructType = 3";
	};
	class DestructStruct3Pos: RscCombo
	{
		idc = IDC_CB_DESTRUCT_STRUCT + 3;
		x = 0.325;
		y = 0.485;
		w = 0.3;
	};
	class DestructStruct4: RscButtonLarge
	{
		idc = IDC_BTN_DESTRUCT_STRUCT + 4;
		x = 0.035;
		y = 0.53;
		w = 0.275;
		text = "";
		action = "buttonPressedSetDestructType = 4";
	};
	class DestructStruct4Pos: RscCombo
	{
		idc = IDC_CB_DESTRUCT_STRUCT + 4;
		x = 0.325;
		y = 0.535;
		w = 0.3;
	};
	class DestructStruct5: RscButtonLarge
	{
		idc = IDC_BTN_DESTRUCT_STRUCT + 5;
		x = 0.035;
		y = 0.58;
		w = 0.275;
		text = "";
		action = "buttonPressedSetDestructType = 5";
	};
	class DestructStruct5Pos: RscCombo
	{
		idc = IDC_CB_DESTRUCT_STRUCT + 5;
		x = 0.325;
		y = 0.585;
		w = 0.3;
	};
	class DestructStruct6: RscButtonLarge
	{
		idc = IDC_BTN_DESTRUCT_STRUCT + 6;
		x = 0.035;
		y = 0.63;
		w = 0.275;
		text = "";
		action = "buttonPressedSetDestructType = 6";
	};
	class DestructStruct6Pos: RscCombo
	{
		idc = IDC_CB_DESTRUCT_STRUCT + 6;
		x = 0.325;
		y = 0.635;
		w = 0.3;
	};

	class Exit: RscButtonLarge
	{
		idc = -1;
		x = 0.035;
		y = 0.73;
		w = 0.175;
		text = "Exit";
		action = "closeDialog 0";
	};
};
