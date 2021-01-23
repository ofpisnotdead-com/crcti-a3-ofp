//-----------------------------------------------------------------------------
class StatsDialog: Menu
{
	idd = IDD_StatsDialog;
	movingEnable = true;
	controlsBackground[] = { StatsBackgroundWindow };
	objects[] = { };
	controls[] = { StatsTitle, WestLabel, MoneyWestLabel, MoneyWest,
			StructsWestLabel, StructsWest, UnitsWestLabel, UnitsWest,
			EastLabel, MoneyEastLabel, MoneyEast, StructsEastLabel,
			StructsEast, UnitsEastLabel, UnitsEast, Exit };

	class StatsBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.055;
		y = 0.055;
		w = 0.875;
		h = 0.8;
	};

	class StatsTitle: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		style = ST_CENTER;
		x = 0.055;
		y = 0.055;
		w = 0.875;
		text = "Statistics";
	};

	class WestLabel: Label
	{
		idc = IDC_DEFAULT;
		style = ST_CENTER;
		x = 0.11;
		y = 0.14;
		w = 0.38;
		h = 0.03;
		colorText[] = { 0, 0, 1, 1 };
		colorBackground[] = { 0.6, 0.6, 0.6, 1 };
		text = "WEST";
	};

	class MoneyWestLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.11;
		y = 0.18;
		w = 0.38;
		h = 0.03;
		text = "$ Total/Spent (at last town income)";
	};
	class MoneyWest: Text
	{
		idc = IDC_TEXT_MONEYWEST;
		x = 0.11;
		y = 0.21;
		w = 0.38;
		colorBackground[] = COLOR_DATA_BG;
	};

	class StructsWestLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.11;
		y = 0.25;
		w = 0.38;
		text = "Structures Built";
	};
	class StructsWest: RscListBox
	{
		idc = IDC_LB_STRUCTSWEST;
		x = 0.11;
		y = 0.28;
		w = 0.19;
		h = 0.425;
		font = FontM;
		sizeEx = 0.02;
		rowHeight = 0.025;
	};
	class UnitsWestLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.30;
		y = 0.25;
		w = 0.38;
		text = "Units Built";
	};
	class UnitsWest: RscListBox
	{
		idc = IDC_LB_UNITSWEST;
		x = 0.30;
		y = 0.28;
		w = 0.19;
		h = 0.425;
		font = FontM;
		sizeEx = 0.02;
		rowHeight = 0.025;
	};
	class EastLabel: Label
	{
		idc = IDC_DEFAULT;
		style = ST_CENTER;
		x = 0.51;
		y = 0.14;
		w = 0.38;
		h = 0.03;
		colorText[] = { 1, 0, 0, 1 };
		colorBackground[] = { 0.6, 0.6, 0.6, 1 };
		text = "EAST";
	};

	class MoneyEastLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.51;
		y = 0.18;
		w = 0.38;
		h = 0.03;
		text = "$ Total/Spent (at last town income)";
	};
	class MoneyEast: Text
	{
		idc = IDC_TEXT_MONEYEAST;
		x = 0.51;
		y = 0.21;
		w = 0.38;
		colorBackground[] = COLOR_DATA_BG;
	};

	class StructsEastLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.51;
		y = 0.25;
		w = 0.38;
		text = "Structures Built";
	};
	class StructsEast: RscListBox
	{
		idc = IDC_LB_STRUCTSEAST;
		x = 0.51;
		y = 0.28;
		w = 0.19;
		h = 0.425;
		font = FontM;
		sizeEx = 0.02;
		rowHeight = 0.025;
	};
	class UnitsEastLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.70;
		y = 0.25;
		w = 0.38;
		text = "Units Built";
	};
	class UnitsEast: RscListBox
	{
		idc = IDC_LB_UNITSEAST;
		x = 0.70;
		y = 0.28;
		w = 0.19;
		h = 0.425;
		font = FontM;
		sizeEx = 0.02;
		rowHeight = 0.025;
	};

	class Exit: RscButtonLarge
	{
		x = 0.11;
		y = 0.755;
		text = "Exit";
		action = "closeDialog 0";
	};
};
