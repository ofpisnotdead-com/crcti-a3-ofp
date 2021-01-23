class GameInfoDialog: Menu
{
	idd = IDD_GameInfoDialog;
	movingEnable = true;
	controlsBackground[] = { GameInfoBackgroundWindow };
	objects[] = { };
	controls[] = { GameInfoTitle, Exit, Param, Value };

	class GameInfoBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.0;
		y = 0.0;
		w = 1.0;
		h = 1.05;
	};

	class GameInfoTitle: Title
	{
		colorBackground[] = { 0.1, 0.1, 0.1, 0.6 };
		idc = IDC_TEXT_MENU_NAME;
		style = ST_LEFT;
		x = 0.00;
		y = 0.00;
		w = 1.0;
		text = "Game Options";
	};

	class Exit: RscButtonLarge
	{
		x = 0.82;
		y = 0.005;
		text = "Exit";
		action = "closeDialog 0";
	};

	class Param: RscListBox
	{
		idc = IDC_GI_PARAM;
		style = ST_MULTI + ST_RIGHT;
		x = 0.01;
		y = 0.06;
		w = 0.48;
		h = 0.98;
		colorBackground[] = { 0, 0, 0, 0 };
		colorText[] = { 1, 1, 1, 1 };
	};

	class Value: RscListBox
	{
		idc = IDC_GI_VALUE;
		style = ST_MULTI + ST_LEFT;
		x = 0.51;
		y = 0.06;
		w = 0.48;
		h = 0.98;
		colorBackground[] = { 0, 0, 0, 0 };
		colorText[] = { 1, 1, 1, 1 };
	};
};
