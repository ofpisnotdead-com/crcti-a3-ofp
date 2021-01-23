class UnitCamDialog: Menu
{
	idd = IDD_UnitCamDialog;
	movingEnable = true;
	controlsBackground[] = { GroupsBg };
	objects[] = { };
	controls[] = { Tracking, Info, ShowInfo, ShowGroups, GroupLeaders,
			GroupMembers, SatCam, Disband, DisbandGroup, TeamSwitch, Front,
			Left, Right, Rear, Exit, ToggleNV };

	class Tracking: Text
	{
		idc = IDC_TEXT_TRACKING;
		style = ST_CENTER;
		x = 0.3;
		y = 0.0;
		w = 0.4;
		h = 0.04;
		colorText[] = { 1, 1, 1, 1 };
		colorBackground[] = { 0, 0, 0, 0.5 };
	};
	class Info: TextField
	{
		idc = IDC_INFO;
		x = 0.0;
		y = 0.04;
		w = 0.3;
		h = 0.6;
		text = "";
		colorText[] = { 1, 1, 1, 1 };
		colorbackground[] = { 0, 0, 0, 0.5 };
	};
	class ShowInfo: RscButtonLarge
	{
		idc = IDC_BTN_SHOWINFO;
		x = 0.0;
		y = 0.0;
		w = 0.3;
		text = "";
		action = "bShowInfo=!bShowInfo; if (bShowInfo) then { bShowLog=false }";
	};
	class ShowGroups: RscButtonLarge
	{
		idc = IDC_BTN_SHOWGROUPS;
		x = 0.86;
		y = 0.0;
		w = 0.18;
		text = "";
		action = "bShowGroups=!bShowGroups";
	};

	class GroupLeaders: RscListBox
	{
		idc = IDC_LB_GROUPLEADERS;
		x = 0.86;
		y = 0.04;
		w = 0.18;
		h = 0.225;
		colorText[] = { 0.5, 0.5, 0.5, 1 };
		font = FontM;
		sizeEx = 0.02;
		rowHeight = 0.025;
	};

	class GroupMembers: RscListBox
	{
		idc = IDC_LB_GROUPMEMBERS;
		x = 0.86;
		y = 0.265;
		w = 0.18;
		h = 0.275;
		colorText[] = { 0.5, 0.5, 0.5, 1 };
		font = FontM;
		sizeEx = 0.02;
		rowHeight = 0.025;
	};

	class GroupsBg: Text
	{
		idc = IDC_BG_GROUPS;
		x = 0.86;
		y = 0.04;
		w = 0.18;
		h = 0.50;
		colorbackground[] = { 0, 0, 0, 0.5 };
	};

	class SatCam: RscButtonLarge
	{
		idc = IDC_BTN_FAR;
		x = 0.0;
		y = 0.93;
		text = "Sat Cam";
		action = "btnFar=true";
	};

	class Disband: RscButtonLarge
	{
		idc = IDC_BTN_DISB;
		x = 0.0;
		y = 0.81;
		text = "Disband";
		action = "btnDisband=true";
	};

	class DisbandGroup: RscButtonLarge
	{
		idc = IDC_BTN_DISBGROUP;
		x = 0.0;
		y = 0.87;
		text = "Disband Group";
		action = "btnDisbandGroup=true";
	};

	class TeamSwitch: RscButtonLarge
	{
		idc = IDC_BTN_SWITCH;
		x = 0.0;
		y = 0.75;
		text = "Unit Switch";
		action = "btnTeamSwitch=true";
	};

	class ToggleNV: RscButtonLarge
	{
		idc = IDC_BTN_TOGGLENV;
		x = 0.0;
		y = 0.99;
		text = "NightVis On/Off";
		action = "btnToggleNV=true";
	};

	class Front: RscButton
	{
		idc = IDC_BTN_FRONT;
		x = 0.86;
		y = 0.83;
		text = "Front";
		action = "btnFront=true";
	};

	class Left: RscButton
	{
		idc = IDC_BTN_LEFT;
		x = 0.80;
		y = 0.87;
		text = "Left";
		action = "btnLeft=true";
	};

	class Right: RscButton
	{
		idc = IDC_BTN_RIGHT;
		x = 0.92;
		y = 0.87;
		text = "Right";
		action = "btnRight=true";
	};

	class Rear: RscButton
	{
		idc = IDC_BTN_REAR;
		x = 0.86;
		y = 0.91;
		text = "Rear";
		action = "btnRear=true";
	};

	class Exit: RscButtonLarge
	{
		x = 0.86;
		y = 0.99;
		text = "Exit";
		action = "closeDialog 0";
	};
};
