class CommandAIDialog: Menu
{
	idd = IDD_CommandAIDialog;
	movingEnable = true;
	controlsBackground[] = { CommandAIDialogBackgroundWindow };
	objects[] = { };
	controls[] = { CommandAITitle, GroupOrdersLabel, GroupOrdersBG,
			GroupOrders, Setting0Label, Setting0, Setting1Label, Setting1,
			Setting2Label, Setting2, Setting3Label, Setting3, Setting4Label,
			Setting4, Setting5Label, Setting5, Setting6Label, Setting6,
			Setting7Label, Setting7, SendOrder, OrderLabel, OrderBG, Order,
			Param0Label, Param0BG, Param0, Param1Label, Param1BG, Param1,
			Param2Label, Param2BG, Param2, Map, Exit };

	class CommandAIDialogBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = -0.025;
		y = -0.025;
		w = 1.05;
		h = 1.05;
	};

	class CommandAITitle: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		style = ST_CENTER;
		x = -0.025;
		y = -0.025;
		w = 1.05;
		text = "AI Group Orders";
	};

	class GroupOrdersLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.0;
		y = 0.02;
		w = 0.5;
		text = "Count, Group, Current Order, Composition";
	};

	class GroupOrdersBG: RscListBoxBG
	{
		x = 0.0;
		y = 0.05;
		w = 0.6;
		h = 0.30;
	};
	class GroupOrders: RscListBox
	{
		idc = IDC+0;
		x = 0.0;
		y = 0.05;
		w = 0.6;
		h = 0.30;
	};

	class Setting0Label: Label
	{
		idc = IDC+100;
		x = 0.6;
		y = 0.02;
		w = 0.2;
		text = "Rally Point";
	};
	class Setting0: RscCombo
	{
		idc = IDC+200;
		x = 0.6;
		y = 0.05;
		w = 0.2;
	};

	class Setting1Label: Label
	{
		idc = IDC+101;
		x = 0.8;
		y = 0.02;
		w = 0.2;
		text = "Pickup Wait";
	};
	class Setting1: RscCombo
	{
		idc = IDC+201;
		x = 0.8;
		y = 0.05;
		w = 0.2;
	};

	class Setting2Label: Label
	{
		idc = IDC+102;
		x = 0.6;
		y = 0.09;
		w = 0.2;
		text = "Respawn";
	};
	class Setting2: RscCombo
	{
		idc = IDC+202;
		x = 0.6;
		y = 0.12;
		w = 0.2;
	};

	class Setting3Label: Label
	{
		idc = IDC+103;
		x = 0.8;
		y = 0.09;
		w = 0.2;
		text = "Buy";
	};
	class Setting3: RscCombo
	{
		idc = IDC+203;
		x = 0.8;
		y = 0.12;
		w = 0.2;
	};

	class Setting4Label: Label
	{
		idc = IDC+104;
		x = 0.6;
		y = 0.16;
		w = 0.2;
		text = "Keep";
	};
	class Setting4: RscCombo
	{
		idc = IDC+204;
		x = 0.6;
		y = 0.19;
		w = 0.2;
	};

	class Setting5Label: Label
	{
		idc = IDC+105;
		x = 0.8;
		y = 0.16;
		w = 0.2;
		text = "Buy in Base";
	};
	class Setting5: RscCombo
	{
		idc = IDC+205;
		x = 0.8;
		y = 0.19;
		w = 0.2;
	};

	class Setting6Label: Label
	{
		idc = IDC+106;
		x = 0.6;
		y = 0.23;
		w = 0.2;
		text = "Speedmode";
	};
	class Setting6: RscCombo
	{
		idc = IDC+206;
		x = 0.6;
		y = 0.26;
		w = 0.2;
	};

	class Setting7Label: Label
	{
		idc = IDC+107;
		x = 0.8;
		y = 0.23;
		w = 0.2;
		text = "Formation";
	};
	class Setting7: RscCombo
	{
		idc = IDC+207;
		x = 0.8;
		y = 0.26;
		w = 0.2;
	};

	class OrderLabel: Label
	{
		idc = IDC+1;
		x = 0.0;
		y = 0.36;
		w = 0.1;
		text = "Order";
	};

	class SendOrder: RscButtonLarge
	{
		idc = IDC+2;
		x = 0.825;
		y = 0.39;
		text = "Send";
		action = "btnSendOrder=true";
	};

	class OrderBG: RscListBoxBG
	{
		idc = IDC_DEFAULT;
		x = 0.0;
		y = 0.39;
		w = 0.2;
		h = 10*0.03;
	};

	class Order: RscListBox
	{
		idc = IDC+3;
		x = 0.0;
		y = 0.39;
		w = 0.2;
		h = 10*0.03;
	};

	class Param0Label: Label
	{
		idc = IDC+4;
		x = 0.2;
		y = 0.36;
		w = 0.2;
		text = "Param0";
	};

	class Param0BG: RscListBoxBG
	{
		idc = IDC_DEFAULT;
		x = 0.2;
		y = 0.39;
		w = 0.2;
		h = 10*0.03;
	};

	class Param0: RscListBox
	{
		idc = IDC+5;
		x = 0.2;
		y = 0.39;
		w = 0.2;
		h = 10*0.03;
	};

	class Param1Label: Label
	{
		idc = IDC+6;
		x = 0.4;
		y = 0.36;
		w = 0.2;
		text = "Param1";
	};

	class Param1BG: RscListBoxBG
	{
		x = 0.4;
		y = 0.39;
		w = 0.2;
		h = 10*0.03;
	};

	class Param1: RscListBox
	{
		idc = IDC+7;
		x = 0.4;
		y = 0.39;
		w = 0.2;
		h = 10*0.03;
	};

	class Param2Label: Label
	{
		idc = IDC+8;
		x = 0.6;
		y = 0.36;
		w = 0.2;
		text = "Param2";
	};

	class Param2BG: RscListBoxBG
	{
		x = 0.6;
		y = 0.39;
		w = 0.2;
		h = 10*0.03;
	};

	class Param2: RscListBox
	{
		idc = IDC+9;
		x = 0.6;
		y = 0.39;
		w = 0.2;
		h = 10*0.03;
	};

	class Map: RscMapControl
	{
		idc = IDC_CommandAI_Map;
		colorBackground[] = { 0.95, 0.95, 0.95, 1.00 };
		x = 0.01;
		y = 0.70;
		w = 0.98;
		h = 0.29;
	};
	class Exit: RscButtonLarge
	{
		x = 0.84;
		y = -0.02;
		text = "Exit";
		action = "closeDialog IDD_CommandAIDialog";
	};
};
