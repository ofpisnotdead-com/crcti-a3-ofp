class FactionsDialog: Menu
{
	idd = IDD_FactionsDialog;
	movingEnable = true;
	controlsBackground[] = { FactionsBackgroundWindow };
	objects[] = { };
	controls[] = { FactionsTitle,
			AvailableLabel, AvailableBG, Available,
			SelectedLabel, SelectedBG, Selected,
			ResultLabel, ResultBG, Result, Finished,
			Timer, Info };

	class FactionsBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.0;
		y = 0.0;
		w = 1.0;
		h = 0.9;
	};

	class FactionsTitle: Title
	{
		colorBackground[] = { 0.1, 0.1, 0.1, 0.6 };
		idc = IDC_DEFAULT;
		style = ST_LEFT;
		x = 0.00;
		y = 0.00;
		w = 1.0;
		text = "Select Factions";
	};

	class Timer: Title
	{
		idc = IDC_FACTION_TIMER;
		colorBackground[] = { 0.1, 0.1, 0.1, 0.0 };
		colorText[] = { 0.9, 0.1, 0.1, 1.0 };
		style = ST_LEFT;
		x = 0.70;
		y = 0.00;
		w = 1.0;
		text = "";
	};

	class Finished: RscButtonLarge
	{
		idc = IDC_FACTION_SELECTION_FINISHED;
		x = 0.82;
		y = 0.005;
		text = "Finished";
		action = "btnFinished=true;";
	};

	class AvailableLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.025;
		y = 0.075;
		w = 0.25;
		h = 0.03;
		text = "Available Factions";
	};

	class AvailableBG: RscListBoxBG
	{
		idc = IDC_DEFAULT;
		x = 0.025;
		y = 0.105;
		w = 0.3;
		h = 0.65;
	};
	class Available: RscListBox
	{
		type = 102;
		columns[] = { 0.0, 0.1 };
		drawSideArrows = 0;
		idcLeft = -1;
		idcRight = -1;
		idc = IDC_LB_AVAILABLE_FACTIONS;
		x = 0.025;
		y = 0.105;
		w = 0.3;
		h = 0.65;
	};

	class SelectedLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.35;
		y = 0.075;
		w = 0.25;
		h = 0.03;
		text = "Selected Factions";
	};

	class SelectedBG: RscListBoxBG
	{
		idc = IDC_DEFAULT;
		x = 0.35;
		y = 0.105;
		w = 0.3;
		h = 0.65;
	};
	class Selected: RscListBox
	{
		type = 102;
		columns[] = { 0.0, 0.1 };
		drawSideArrows = 0;
		idcLeft = -1;
		idcRight = -1;
		idc = IDC_LB_SELECTED_FACTIONS;
		x = 0.35;
		y = 0.105;
		w = 0.3;
		h = 0.65;
	};

	class ResultLabel: Label
	{
		text = "Server Result";
		idc = IDC_DEFAULT;
		x = 0.675;
		y = 0.075;
		w = 0.25;
		h = 0.03;
	};

	class ResultBG: RscListBoxBG
	{
		idc = IDC_DEFAULT;
		x = 0.675;
		y = 0.105;
		w = 0.3;
		h = 0.65;
	};
	class Result: RscListBox
	{
		type = 102;
		columns[] = { 0.0, 0.1 };
		drawSideArrows = 0;
		idcLeft = -1;
		idcRight = -1;
		idc = IDC_LB_RESULT_FACTIONS;
		x = 0.675;
		y = 0.105;
		w = 0.3;
		h = 0.65;
	};

	class Info: TextField
	{
		idc = IDC_DEFAULT;
		x = 0.025;
		y = 0.78;
		h = 0.05;
		w = 1.0;
		text = "Click on available Faction to select, click on selected Faction to remove. Only factions available on all currently connected clients are displayed. End result decided by the server is shown to the right.";
	};

};

