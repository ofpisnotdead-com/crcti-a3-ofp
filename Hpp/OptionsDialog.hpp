class OptionsDialog: Menu
{
	idd = IDD_OptionsDialog;
	movingEnable = true;
	controlsBackground[] = { OptionsBackgroundWindow };
	objects[] = { };
	controls[] = { OptionsTitle, Money, Score, Leaderboard, Destruction, Towns,
			Income, FPS, CleanupGround, DisbandLabel, Units, Disband, TeamSwitch,
			TransferLabel, TransferTargetBG, TransferTarget, TransferAmountBG,
			TransferAmount, Transfer, Request, BuyUnits, ShowStats, UnitCam, SatCam,
			MemberMarkersLabel, MemberMarkers, PlayerIncomeLabel, PlayerIncome, CommanderLabel,
			Commander, CommanderTransfer, CommandAI, AIRespawnLabel, AIRespawn,
			UpgradesLabel, UpgradesBG, Upgrades, Upgrade, Exit, HiddenDefault, Info,
			VDUp, VDDown, GridUp, GridDown, PlayerViewDist, ServerViewDist, ViewDist, GridSize, PlayerViewDistLabel, GridSizeLabel, ServerViewDistLabel,
			ViewDistLabel, Surrender, Extension, Extension2, Clean, Kill, DebugStats };

	class OptionsBackgroundWindow: BackgroundWindow
	{
		idc = IDC_DEFAULT;
		x = -0.08;
		y = -0.05;
		w = 1.1;
		h = 0.9;
	};

	class OptionsTitle: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		style = ST_CENTER;
		x = -0.08;
		y = -0.05;
		w = 1.1;
		text = "Options Menu";
	};

	class Money: Text
	{
		idc = IDC_TEXT_MONEY;
		x = -0.06;
		y = 0.05;
		w = 0.25;
		text = "Money";
	};

	class Score: Text
	{
		idc = IDC_TEXT_SCORE;
		x = -0.06;
		y = 0.10;
		w = 0.25;
		text = "Score";
	};
	class Leaderboard: RscButtonLarge
	{
		x = 0.20;
		y = 0.05;
		text = "Leaderboard";
		action = "btnLeaderboard=true";
	};

	class Destruction: RscButtonLarge
	{
		idc = IDC_BTN_DESTRUCTION;
		x = 0.40;
		y = 0.05;
		text = "Destruction";
		action = "btnDestruction=true";
	};

	class Towns: Text
	{
		idc = IDC_TEXT_TOWNS;
		x = -0.06;
		y = 0.15;
		w = 0.25;
		text = "Towns";
	};

	class Info: RscButtonLarge
	{
		x = 0.20;
		y = 0.10;
		text = "Game Info";
		action = "btnInfo=true";
	};

	class CleanupGround: RscButtonLarge
	{
		x = 0.40;
		y = 0.10;
		text = "Cleanup Ground";
		action = "closeDialog 0; [getPos player] exec ""Player\CleanupGround.sqs""";
	};

	class Income: Text
	{
		idc = IDC_TEXT_INCOME;
		x = -0.06;
		y = 0.20;
		w = 0.25;
		text = "Income";
	};

	class ShowStats: RscButtonLarge
	{
		x = 0.20;
		y = 0.15;
		text = "Statistics";
		action = "btnShowStats=true";
	};

	class PlayerViewDistLabel: Label
	{
		idc = -1;
		x = 0.41;
		y = 0.15;
		w = 0.2;
		text = "Player Viewdist:";
	};

	class PlayerViewDist: Text
	{
		idc = IDC_TEXT_PLAYERVD;
		x = 0.41;
		y = 0.18;
		w = 0.2;
		text = "????m";
	};

	class VDDown: RscButton
	{
		x = 0.52;
		y = 0.1875;
		w = 0.025;
		h = 0.025;
		text = "-";
		action = "btnVDDown=true";
	};
	class VDUp: RscButton
	{
		x = 0.55;
		y = 0.1875;
		w = 0.025;
		h = 0.025;
		text = "+";
		action = "btnVDUp=true";
	};

	class ServerViewDistLabel: Label
	{
		idc = -1;
		x = 0.41;
		y = 0.21;
		w = 0.2;
		text = "Server Viewdist:";
	};

	class ServerViewDist: Text
	{
		idc = IDC_TEXT_SERVERVD;
		x = 0.41;
		y = 0.24;
		w = 0.2;
		text = "????m";
	};

	class ViewDistLabel: Label
	{
		idc = IDC_TEXT_VD;
		x = 0.41;
		y = 0.27;
		w = 0.2;
		text = "Effective Viewdist:";
	};

	class ViewDist: Text
	{
		idc = IDC_TEXT_VD;
		x = 0.41;
		y = 0.30;
		w = 0.2;
		text = "????m";
	};

	class GridSizeLabel: Label
	{
		idc = -1;
		x = 0.41;
		y = 0.33;
		w = 0.2;
		text = "Terrain Detail:";
	};

	class GridSize: Text
	{
		idc = IDC_TEXT_GRIDSIZE;
		x = 0.41;
		y = 0.36;
		w = 0.2;
		text = "Gridsize";
	};

	class GridDown: RscButton
	{
		x = 0.52;
		y = 0.3675;
		w = 0.025;
		h = 0.025;
		text = "-";
		action = "btnGridDown=true";
	};
	class GridUp: RscButton
	{
		x = 0.55;
		y = 0.3675;
		w = 0.025;
		h = 0.025;
		text = "+";
		action = "btnGridUp=true";
	};

	class FPS: Text
	{
		idc = IDC_TEXT_FPS;
		x = -0.06;
		y = 0.25;
		w = 0.4;
		text = "FPS";
	};

	class DisbandLabel: Label
	{
		idc = IDC_DEFAULT;
		x = -0.06;
		y = 0.32;
		w = 0.2;
		text = "Units";
	};
	class Disband: RscButtonLarge
	{
		idc = IDC_BTN_DISB;
		x = 0.00;
		y = 0.31;
		text = "Disband";
		action = "btnDisband=true";
	};
	class TeamSwitch: RscButtonLarge
	{
		idc = IDC_BTN_SWITCH;
		x = 0.20;
		y = 0.31;
		text = "Unit Switch";
		action = "btnTeamSwitch=true";
	};

	class Units: RscCombo
	{
		idc = IDC_LB_UNITS;
		x = -0.06;
		y = 0.36;
		w = 0.43;
	};

	class TransferLabel: Label
	{
		idc = IDC_DEFAULT;
		x = -0.06;
		y = 0.45;
		w = 0.2;
		text = "Transfer Money";
	};

	class Request: RscButtonLarge
	{
		idc = IDC_BTN_REQUEST_MONEY;
		x = 0.095;
		y = 0.45;
		text = "Request";
		action = "btnRequest=true";
	};

	class Transfer: RscButtonLarge
	{
		idc = IDC_BTN_TRANSFER_MONEY;
		x = 0.276;
		y = 0.45;
		text = "Give";
		action = "btnGive=true";
	};
	class TransferTargetBG: RscListBoxBG
	{
		x = -0.06;
		y = 0.5;
		w = 0.42;
		h = 0.32;
	};
	class TransferTarget: RscListBox
	{
		idc = IDC_LB_TRANSFER_TARGET;
		x = -0.06;
		y = 0.5;
		w = 0.42;
		h = 0.32;
	};
	class TransferAmountBG: RscListBoxBG
	{
		idc = IDC_DEFAULT;
		x = 0.37;
		y = 0.5;
		w = 0.08;
		h = 0.32;
	};
	class TransferAmount: RscListBox
	{
		idc = IDC_LB_TRANSFER_AMOUNT;
		x = 0.37;
		y = 0.5;
		w = 0.08;
		h = 0.32;
	};

	class Surrender: RscButtonLarge
	{
		idc = IDC_BTN_SURRENDER;
		x = 0.81;
		y = 0.05;
		text = "Surrender";
		action = "btnSurrender=true";
	};

	class Extension: RscButtonLarge
	{
		idc = IDC_BTN_EXTENSION;
		x = 0.81;
		y = 0.10;
		text = "Time +15 min";
		action = "btnExtension=true";
	};

	class Extension2: RscButtonLarge
	{
		idc = IDC_BTN_EXTENSION2;
		x = 0.81;
		y = 0.15;
		text = "Time +60 min";
		action = "btnExtension2=true";
	};

	class BuyUnits: RscButtonLarge
	{
		x = 0.61;
		y = 0.05;
		text = "Buy Units";
		action = "btnBuyUnits=true";
	};

	class UnitCam: RscButtonLarge
	{
		x = 0.61;
		y = 0.10;
		text = "Unit Cam";
		action = "btnUnitCam=true";
	};

	class SatCam: RscButtonLarge
	{
		x = 0.61;
		y = 0.15;
		text = "Sat Cam";
		action = "btnSatCam=true";
	};

	class MemberMarkersLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.61;
		y = 0.22;
		w = 0.19;
		text = "Extra AI Markers";
	};

	class MemberMarkers: RscCombo
	{
		idc = IDC_CB_AIMARKERS;
		x = 0.61;
		y = 0.25;
		w = 0.19;
	};

	class ReportsLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.81;
		y = 0.22;
		w = 0.19;
		text = "Enemy Reports";
	};

	class Reports: RscCombo
	{
		idc = IDC_CB_REPORTS;
		x = 0.81;
		y = 0.25;
		w = 0.19;
	};

	class PlayerIncomeLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.61;
		y = 0.29;
		w = 0.19;
		text = "Comm Income";
	};
	class PlayerIncome: RscCombo
	{
		idc = IDC_CB_PLAYERINCOME;
		x = 0.61;
		y = 0.32;
		w = 0.19;
	};

	class CommanderLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.81;
		y = 0.29;
		w = 0.19;
		text = "Commander";
	};
	class Commander: RscCombo
	{
		idc = IDC_CB_COMMANDER;
		x = 0.81;
		y = 0.32;
		w = 0.19;
	};

	class CommanderTransfer: RscButtonLarge
	{
		idc = IDC_BTN_COMMANDERTRANSFER;
		x = 0.81;
		y = 0.37;
		text = "Transfer";
		action = "btnTransfer=true";
	};

	class CommandAI: RscButtonLarge
	{
		idc = IDC_BTN_COMMANDAI;
		x = 0.61;
		y = 0.37;
		text = "Command AI";
		action = "btnCommandAI=true";
	};

	class AIRespawnLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.81;
		y = 0.22;
		w = 0.20;
		text = "AI Respawn Pos";
	};
	class AIRespawn: RscCombo
	{
		idc = IDC_CB_AIRESPAWN;
		x = 0.81;
		y = 0.25;
		w = 0.19;
	};

	class UpgradesLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.61;
		y = 0.45;
		w = 0.2;
		text = "Upgrades";
	};
	class Upgrade: RscButtonLarge
	{
		idc = IDC_BTN_UPGRADE;
		x = 0.81;
		y = 0.45;
		text = "Upgrade";
		action = "btnUpgrade=true";
	};
	class UpgradesBG: RscListBoxBG
	{
		x = 0.61;
		y = 0.50;
		w = 0.38;
		h = 0.32;
	};
	class Upgrades: RscListBox
	{
		idc = IDC_LB_UPGRADES;
		x = 0.61;
		y = 0.50;
		w = 0.38;
		h = 0.32;
	};

	class Exit: RscButtonLarge
	{
		x = 0.84;
		y = -0.045;
		text = "Exit";
		action = "closeDialog 0";
	};

	class Clean: RscButton
	{
		idc = IDC_BTN_CLEAN;
		x = 0.2;
		y = 0.2;
		w = 0.05;
		h = 0.025;
		colorBackground[] = { 1, 0, 0, 1 };
		text = "Clean";
		action = "btnClean=true";
	};

	class Kill: RscButton
	{
		idc = IDC_BTN_KILL;
		x = 0.261;
		y = 0.2;
		w = 0.05;
		h = 0.025;
		colorBackground[] = { 1, 0, 0, 1 };
		text = "Kill";
		action = "btnKill=true";
	};

	class DebugStats: RscButton
		{
			idc = IDC_BTN_DEBUGSTATS;
			x = 0.322;
			y = 0.2;
			w = 0.05;
			h = 0.025;
			colorBackground[] = { 1, 0, 0, 1 };
			text = "Stats";
			action = "btnDebugStats=true";
		};

	class HiddenDefault: RscButtonLarge // this is to catch the default RscButtonLarge Enter key
	{
		idc = IDC_DEFAULT;
		default = true;
		x = -1;
		y = -1;
		w = 0;
		h = 0;
		text = "";
		action = "";
	};
};
