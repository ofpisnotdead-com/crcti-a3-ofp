class BuildMenu: Menu
{
	idd = IDD_BuildMenu;
	movingEnable = true;
	controlsBackground[] = { BuildBackgroundWindow };
	objects[] = { };
	controls[] = { FactoryName, MoneyLabel, Money, AutoAlignWalls, FloatObj,
			Build, PlaceBuild, Undo, WorkerLabel, Worker,
			BuyWorker, Build_Picture, Exit, StructListBG,
			StructList };

	class BuildBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = 0.02;
		y = 0.02;
		w = 0.64;
		h = 0.75;
	};
	class FactoryName: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		x = 0.02;
		y = 0.02;
		w = 0.64;
		text = "Build Menu";
	};
	class MoneyLabel: Label
	{
		x = 0.035;
		y = 0.14;
		idc = -1;
		w = 0.1;
		text = "Your Cash:";
	};
	class Money: DataText
	{
		idc = IDC_TEXT_PLAYER_MONEY;
		x = 0.135;
		y = 0.14;
		w = 0.15;
		text = "Money";
	};

	class AutoAlignWalls: RscButtonLarge
	{
		idc = IDC_BTN_ALIGN;
		x = 0.035;
		y = 0.19;
		w = 0.24;
		text = "Align Walls";
		action = "alignWalls=!alignWalls";
	};
	class FloatObj: RscButtonLarge
	{
		idc = IDC_BTN_FLOAT;
		x = 0.035;
		y = 0.24;
		w = 0.24;
		text = "Float Object";
		action = "SQU_FloatObj=!SQU_FloatObj";
	};
	class Build: RscButtonLarge
	{
		idc = IDC_BTN_BUILD;
		x = 0.035;
		y = 0.29;
		w = 0.24;
		text = "Build here";
		action = "buttonPressedBuild = true";
	};
	class PlaceBuild: RscButtonLarge
	{
		idc = IDC_BTN_BUILD;
		x = 0.035;
		y = 0.34;
		w = 0.24;
		text = "Place / Build";
		action = "buttonPressedPlaceBuild = true";
	};
	class Undo: RscButtonLarge
	{
		idc = IDC_BTN_UNDO;
		x = 0.035;
		y = 0.39;
		w = 0.24;
		text = "Undo";
		action = "_nul = [] execVM ""Player\UndoLastStructure.sqf""";
	};
	class BuyWorker: RscButtonLarge
	{
		idc = IDC_BTN_BUY;
		x = 0.035;
		y = 0.44;
		w = 0.24;
		text = "Buy Worker";
		action = "buttonPressedBuy = true";
	};

	class WorkerLabel: Label
	{
		x = 0.035;
		y = 0.485;
		idc = IDC_LABEL_WORKERS;
		w = 0.1;
		text = "Workers:";
	};
	class Worker: DataText
	{
		idc = IDC_TEXT_WORKERS;
		x = 0.125;
		y = 0.485;
		w = 0.15;
		text = "(0/0)";
	};

	class Build_Picture: RscPicture
	{
		idc = IDC_Build_Picture;
		x = 0.27;
		y = 0.39;
		w = 0.15;
		h = 0.21;
	};
	class Exit: RscButtonLarge
	{
		idc = -1;
		x = 0.035;
		y = 0.53;
		w = 0.24;
		text = "Exit";
		action = "closeDialog 0";
	};
	class StructListBG: RscListBoxBG
	{
		x = 0.28;
		y = 0.12;
		w = 0.35;
		h = 0.58;
	};
	class StructList: RscListBox
	{
		idc = IDC_LB_LIST1;
		x = 0.28;
		y = 0.12;
		w = 0.35;
		h = 0.58;
	};
};

