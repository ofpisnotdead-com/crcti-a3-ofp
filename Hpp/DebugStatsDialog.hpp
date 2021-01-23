class DebugStatsDialog: Menu
{
	idd = IDD_DebugStatsDialog;
	movingEnable = true;
	controlsBackground[] = { DebugStatsBackgroundWindow };
	objects[] = { };
	controls[] = { DebugStatsTitle, Exit, Text };

	class DebugStatsBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.0;
		y = 0.0;
		w = 1.0;
		h = 1.05;
	};

	class DebugStatsTitle: Title
	{
		colorBackground[] = { 0.1, 0.1, 0.1, 0.6 };
		idc = IDC_DEFAULT;
		style = ST_LEFT;
		x = 0.00;
		y = 0.00;
		w = 1.0;
		text = "Debug Statistics";
	};

	class Exit: RscButtonLarge
	{
		x = 0.82;
		y = 0.005;
		text = "Exit";
		action = "closeDialog 0";
	};

	class Text: RscListBox
	{
		idc = IDC_DBG_VALUE;
		style = ST_MULTI + ST_LEFT;
		x = 0.01;
		y = 0.06;
		w = 0.98;
		h = 0.98;
		colorText[] = { 1, 1, 1, 1 };
	};
};
