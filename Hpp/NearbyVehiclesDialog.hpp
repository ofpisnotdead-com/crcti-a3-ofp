class NearbyVehiclesDialog: Menu
{
	idd = IDD_NearbyVehiclesDialog;
	movingEnable = true;
	controlsBackground[] = { NearbyVehiclesDialogBackgroundWindow };
	objects[] = { };
	controls[] = { NearbyVehiclesTitle, Action, Exit, Vehicles };

	class NearbyVehiclesDialogBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.02;
		y = 0.02;
		w = 0.56;
		h = 0.7;
	};

	class NearbyVehiclesTitle: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		style = ST_CENTER;
		x = 0.02;
		y = 0.02;
		w = 0.56;
		text = "Nearby Vehicles";
	};

	class Action: RscButtonLarge
	{
		idc = IDC_BTN_ACTION;
		x = 0.035;
		y = 0.17;
		text = "UNDEFINED";
		action = "btnAction=true";
	};

	class Exit: RscButtonLarge
	{
		x = 0.035;
		y = 0.22;
		text = "Exit";
		action = "closeDialog 0";
	};

	class Vehicles: RscListBox
	{
		idc = IDC_LB_VEHICLES;
		x = 0.25;
		y = 0.12;
		w = 0.3;
		h = 0.55;
	};

};
