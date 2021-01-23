class SatCamDialog: Menu
{
	idd = IDD_SatCamDialog;
	movingEnable = true;
	controlsBackground[] = { GroupsBg };
	objects[] = { };
	controls[] = { Tracking, MapPos, ShowMap, ShowGroups, GroupLeaders,
			GroupMembers, Distance, North, West, East, South,
			ToggleTrack, Exit, ToggleNV };

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

	class MapPos: Text
	{
		idc = IDC_TEXT_MAPPOS;
		style = ST_LEFT;
		x = 0.0;
		y = 0.98;
		w = 0.3;
		h = 0.04;
		colorText[] = { 1, 1, 1, 1 };
		colorBackground[] = { 0, 0, 0, 0.5 };
	};

	class ShowMap: RscButtonLarge
	{
		idc =IDC_BTN_SHOWMAP;
		x = 0.0;
		y = 0.88;
		text = "";
		action = "bShowMap=!bShowMap";
	};

	class ToggleNV: RscButtonLarge
	{
		idc =IDC_BTN_TOGGLENV;
		x = 0.0;
		y = 0.93;
		text = "NightVis On/Off";
		action = "bToggleNV=!bToggleNV";
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

	class Distance: SliderVert
	{
		idc = IDC_SL_DISTANCE;
		x = 0.94;
		y = 0.55;
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

	class North: RscButton
	{
		idc = IDC_BTN_FRONT;
		x = 0.86;
		y = 0.80;
		w = 0.08;
		text = "North";
		action = "btnNorth=true";
	};

	class West: RscButton
	{
		idc = IDC_BTN_LEFT;
		x = 0.818;
		y = 0.84;
		w = 0.08;
		text = "West";
		action = "btnWest=true";
	};

	class East: RscButton
	{
		idc = IDC_BTN_RIGHT;
		x = 0.902;
		y = 0.84;
		w = 0.08;
		text = "East";
		action = "btnEast=true";
	};

	class South: RscButton
	{
		idc = IDC_BTN_REAR;
		x = 0.86;
		y = 0.88;
		w = 0.08;
		text = "South";
		action = "btnSouth=true";
	};

	class ToggleTrack: RscButtonLarge
	{
		idc = IDC_BTN_TRACK;
		x = 0.86;
		y = 0.946;
		text = "";
		action = "bTrack=!bTrack";
	};

	class Exit: RscButtonLarge
	{
		x = 0.86;
		y = 0.99;
		text = "Exit";
		action = "closeDialog 0";
	};
};
