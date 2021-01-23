class FactoryMenu: Menu
{
	idd = IDD_FactoryMenu;
	movingEnable = true;
	controlsBackground[] = { FactoryBackgroundWindow };
	objects[] = { };
	controls[] = { FactoryName, FactoryStatus, MoneyLabel, Money,
			GroupListLabel, GroupListBG, GroupList, FactoryListLabel,
			FactoryListBG, FactoryList, Buy, Driver,
			Gunner, Commander,
			BuyManned, Passengers, Buy_Picture, Exit, UnitListBG, UnitList,
			QueueLabel, QueueListBG, QueueList, Cancel };

	class FactoryBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = -0.075;
		y = -0.05;
		w = 1.165;
		h = 0.965;
	};

	class FactoryName: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		x = -0.075;
		y = -0.05;
		w = 1.165;
		text = "Buy Units";
	};

	class GroupListLabel: Label
	{
		idc = IDC_TEXT_LIST2_INFO;
		x = -0.06;
		y = 0.05;
		w = 0.3;
		h = 0.04;
		//colorBackground[] = COLOR_MENU_BG;
		text = "Leader Group Size Money";
	};
	class GroupListBG: RscListBoxBG
	{
		idc = IDC_BG_LIST2;
		x = -0.06;
		y = 0.09;
		w = 0.3;
		h = 0.45;
	};
	class GroupList: RscListBox
	{
		idc = IDC_LB_LIST2;
		x = -0.06;
		y = 0.09;
		w = 0.3;
		h = 0.45;
	};
	class FactoryStatus: Label
	{
		idc = IDC_TEXT_MENU_STATUS;
		x = 0.25;
		y = 0.03;
		colorText[] = { 1, 0.1, 0.1, 1 };
	};
	class MoneyLabel: Label
	{
		x = 0.25;
		y = 0.07;
		idc = -1;
		w = 0.1;
		text = "Your Cash:";
	};
	class Money: DataText
	{
		idc = IDC_TEXT_PLAYER_MONEY;
		x = 0.35;
		y = 0.07;
		w = 0.15;
	};

	class Buy: RscButtonLarge
	{
		idc = IDC_BTN_BUY;
		x = 0.25;
		y = 0.13;
		w = 0.26;
		text = "Buy";
		action = "bFactoryBuy = true";
	};

	class Driver: RscButtonLarge
	{
		idc = IDC_BTN_DRIVER;
		x = 0.25;
		y = 0.192;
		w = 0.26;
		text = "Driver";
		action = "bMannedDriver = !bMannedDriver";
	};

	class Gunner: RscButtonLarge
	{
		idc = IDC_BTN_GUNNER;
		x = 0.25;
		y = 0.234;
		w = 0.26;
		text = "Gunner";
		action = "bMannedGunner = !bMannedGunner";
	};

	class Commander: RscButtonLarge
	{
		idc = IDC_BTN_COMMANDER;
		x = 0.25;
		y = 0.276;
		w = 0.26;
		text = "Commander";
		action = "bMannedCommander = !bMannedCommander";
	};

	class BuyManned: RscButtonLarge
	{
		idc = IDC_BTN_BUY_MANNED;
		x = 0.25;
		y = 0.33;
		w = 0.26;
		text = "Buy Manned";
		action = "bFactoryBuyManned = true";
	};

	class Passengers: Label
	{
		idc = IDC_TEXT_PASSENGER_COUNT;
		x = 0.25;
		y = 0.37;
		w = 0.3;
		text = "Passenger Capacity:";
	};


	class FactoryListLabel: Label
	{
		idc = IDC_TEXT_LIST3_INFO;
		x = 0.25;
		y = 0.40;
		w = 0.3;
		text = "Available Factories";
	};
	class FactoryListBG: RscListBoxBG
	{
		idc = IDC_BG_LIST3;
		x = 0.25;
		y = 0.45;
		w = 0.3;
		h = 0.2;
	};
	class FactoryList: RscListBox
	{
		idc = IDC_LB_LIST3;
		x = 0.25;
		y = 0.45;
		w = 0.3;
		h = 0.2;
	};

	class Buy_Picture: RscPicture
	{
		idc = IDC_Buy_Picture;
		x = 0.324;
		y = 0.66;
		w = 0.17;
		h = 0.23;
	};

	class Exit: RscButtonLarge
	{
		idc = -1;
		x = 0.91;
		y = -0.045;
		text = "Exit";
		action = "closeDialog 0";
	};
	class UnitListBG: RscListBoxBG
	{
		x = 0.57;
		y = 0.05;
		w = 0.5;
		h = 0.84;
	};
	class UnitList: RscListBox
	{
		idc = IDC_LB_LIST1;
		x = 0.57;
		y = 0.05;
		w = 0.5;
		h = 0.84;
	};

#define qx -0.06
#define qy 0.55

	class QueueLabel: Label
	{
		idc = IDC_DEFAULT;
		x = qx;
		y = qy;
		w = 0.1;
		text = "Queue";
	};

	class QueueListBG: RscListBoxBG
	{
		x = qx;
		y = qy + 0.04;
		w = 0.3;
		h = 0.3;
	};
	class QueueList: RscListBox
	{
		idc = IDC_LB+3;
		x = qx;
		y = qy + 0.04;
		w = 0.3;
		h = 0.3;
	};

	class Cancel: RscButton
	{
		idc = IDC_BTN_CANCEL;
		x = qx+0.15;
		y = qy;
		w = 0.1;
		text = "Cancel";
		action = "bCancel = true";
	};

};
