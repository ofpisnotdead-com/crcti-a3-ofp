class LeaderboardDialog: Menu
{
	idd = IDD_LeaderboardDialog;
	movingEnable = true;
	controlsBackground[] = { LeaderboardBackgroundWindow };
	objects[] = { };
	controls[] = { LeaderboardTitle, GroupLabel, Group, Side, InfantryLabel,
			Infantry, InfantrySide, VehicleLabel, Vehicle, VehicleSide,
			MHQLabel, MHQ, MHQSide, StructLabel, Struct, StructSide, TownLabel,
			Town, TownSide, TotalLabel, Total, TotalSide, Exit };

	class LeaderboardBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.0;
		y = -0.1;
		w = 1.0;
		h = 1.0;
	};

	class LeaderboardTitle: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		style = ST_LEFT;
		x = 0.0;
		y = -0.1;
		w = 1.0;
		text = "Leaderboard";
	};
	class GroupLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.1;
		y = 0.03;
		w = 0.2;
		text = "Name";
	};
	class Group: RscListBox
	{
		idc = IDC_LB_GROUP;
		x = 0.1;
		y = 0.06;
		w = 0.2;
		h = 0.65;
	};
	class Side: RscListBox
	{
		idc = IDC_LB_SIDE;
		x = 0.1;
		y = 0.7;
		w = 0.2;
		h = 0.06;
	};
	class InfantryLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.3;
		y = 0.03;
		w = 0.1;
		text = "Inf";
	};
	class Infantry: RscListBox
	{
		idc = IDC_LB_INFANTRY;
		x = 0.3;
		y = 0.06;
		w = 0.1;
		h = 0.65;
	};
	class InfantrySide: RscListBox
	{
		idc = IDC_LB_INFANTRYSIDE;
		x = 0.3;
		y = 0.7;
		w = 0.1;
		h = 0.06;
	};
	class VehicleLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.4;
		y = 0.03;
		w = 0.1;
		text = "Vehicle";
	};
	class Vehicle: RscListBox
	{
		idc = IDC_LB_VEHICLE;
		x = 0.4;
		y = 0.06;
		w = 0.1;
		h = 0.65;
	};
	class VehicleSide: RscListBox
	{
		idc = IDC_LB_VEHICLESIDE;
		x = 0.4;
		y = 0.7;
		w = 0.1;
		h = 0.06;
	};
	class MHQLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.5;
		y = 0.03;
		w = 0.1;
		text = "MHQ";
	};
	class MHQ: RscListBox
	{
		idc = IDC_LB_MHQ;
		x = 0.5;
		y = 0.06;
		w = 0.1;
		h = 0.65;
	};
	class MHQSide: RscListBox
	{
		idc = IDC_LB_MHQSIDE;
		x = 0.5;
		y = 0.7;
		w = 0.1;
		h = 0.06;
	};
	class StructLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.6;
		y = 0.03;
		w = 0.1;
		text = "Struct";
	};
	class Struct: RscListBox
	{
		idc = IDC_LB_STRUCT;
		x = 0.6;
		y = 0.06;
		w = 0.1;
		h = 0.65;
	};
	class StructSide: RscListBox
	{
		idc = IDC_LB_STRUCTSIDE;
		x = 0.6;
		y = 0.7;
		w = 0.1;
		h = 0.06;
	};
	class TownLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.7;
		y = 0.03;
		w = 0.1;
		text = "Town";
	};
	class Town: RscListBox
	{
		idc = IDC_LB_TOWN;
		x = 0.7;
		y = 0.06;
		w = 0.1;
		h = 0.65;
	};
	class TownSide: RscListBox
	{
		idc = IDC_LB_TOWNSIDE;
		x = 0.7;
		y = 0.7;
		w = 0.1;
		h = 0.06;
	};
	class TotalLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.8;
		y = 0.03;
		w = 0.1;
		text = "Total";
	};
	class Total: RscListBox
	{
		idc = IDC_LB_TOTAL;
		x = 0.8;
		y = 0.06;
		w = 0.1;
		h = 0.65;
	};
	class TotalSide: RscListBox
	{
		idc = IDC_LB_TOTALSIDE;
		x = 0.8;
		y = 0.7;
		w = 0.1;
		h = 0.06;
	};
	class Exit: RscButtonLarge
	{
		x = 0.82;
		y = -0.095;
		text = "Exit";
		action = "closeDialog 0";
	};
};
