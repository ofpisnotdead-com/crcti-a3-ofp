class SetFlightAltitudeDialog: Menu
{
	idd = IDD_SetFlightAltitudeDialog;
	movingEnable = true;
	controlsBackground[] = { SetFlightAltitudeDialogBackgroundWindow };
	objects[] = { };
	controls[] = { SetFlightAltitudeTitle, Action, Exit, Altitudes };

	class SetFlightAltitudeDialogBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.02;
		y = 0.05;
		w = 0.55;
		h = 0.675;
	};

	class SetFlightAltitudeTitle: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		style = ST_LEFT;
		x = 0.02;
		y = 0.05;
		w = 0.55;
		text = "Set Flight Altitude";
	};

	class Action: RscButtonLarge
	{
		x = 0.035;
		y = 0.17;
		text = "Set Altitude";
		action = "btnAction=true";
	};

	class Exit: RscButtonLarge
	{
		x = 0.035;
		y = 0.23;
		text = "Exit";
		action = "closeDialog 0";
	};

	class Altitudes: RscListBox
	{
		idc = IDC_LB_ALTITUDES;
		x = 0.25;
		y = 0.12;
		w = 0.3;
		h = 0.55;
	};

};
