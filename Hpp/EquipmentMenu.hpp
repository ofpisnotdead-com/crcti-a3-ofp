#define X_INV 0.45
#define Y_INV 0.07
#define W_SLOT 0.05
#define H_SLOT 0.06

//-----------------------------------------------------------------------------
class EquipmentMenu: Menu
{
	idd = IDD_EquipmentMenu;
	movingEnable = true;
	controlsBackground[] = { EquipmentBackgroundWindow };
	objects[] = { };
	controls[] = {
			EquipmentTitle,
			PrimaryTab,
			SecondaryTab,
			HandgunTab,
			EquipmentTab,
			ClothesTab,
			CurrentLabel,
			CurrentBG,
			Current,
			RemoveCurrent,
			RemoveCurrentAll,
			TypeLabel,
			ListBG,
			Primary,
			AddPrimary,
			PrimaryAmmo,
			AddPrimaryAmmo,
			Handgun,
			AddHandgun,
			HandgunAmmo,
			AddHandgunAmmo,
			Clothes,
			AddClothes,
			Secondary,
			AddSecondary,
			SecondaryAmmo,
			AddSecondaryAmmo,
			Equipment,
			AddEquipment,
			TemplatesLabel,
			SaveTemplate,
			LoadTemplate,
			TemplateListBG,
			Templates,
			Clear,
			Exit,
			EquiInfo,
			EquiInfoLabel
	};

	class EquipmentBackgroundWindow: BackgroundWindow
	{
		idc = IDC_UNDEFINED;
		x = -0.02;
		y = -0.02;
		w = 1.04;
		h = 0.975;
	};

	class EquipmentTitle: Title
	{
		idc = IDC_TEXT_MENU_NAME;
		style = ST_LEFT;
		x = -0.02;
		y = -0.02;
		w = 1.04;
		text = "GEAR";
	};

	class PrimaryTab: RscButtonLarge
	{
		idc = IDC_BTN_PRIMARY_TAB;
		x = 0.0;
		y = 0.035;
		text = "Primary Weapons";
		action = "btnPrimaryTab=true";
	};

	class SecondaryTab: RscButtonLarge
	{
		idc = IDC_BTN_SECONDARY_TAB;
		x = 0.2;
		y = 0.035;
		text = "Secondary Weapons";
		action = "btnSecondaryTab=true";
	};

	class HandgunTab: RscButtonLarge
	{
		idc = IDC_BTN_HANDGUN_TAB;
		x = 0.4;
		y = 0.035;
		text = "Handguns";
		action = "btnHandgunTab=true";
	};

	class EquipmentTab: RscButtonLarge
	{
		idc = IDC_BTN_EQUIPMENT_TAB;
		x = 0.6;
		y = 0.035;
		text = "Equipment";
		action = "btnEquipmentTab=true";
	};

	class ClothesTab: RscButtonLarge
	{
		idc = IDC_BTN_CLOTHES_TAB;
		x = 0.8;
		y = 0.035;
		text = "Clothing & Misc.";
		action = "btnClothesTab=true";
	};

	class CurrentLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.35;
		y = 0.075;
		w = 0.275;
		h = 0.03;
		text = "Current Equipment";
	};
	class CurrentBG: RscListBoxBG
	{
		idc = IDC_DEFAULT;
		x = 0.35;
		y = 0.105;
		w = 0.375;
		h = 0.75;
	};
	class Current: RscListBox
	{
		type = 102;
		columns[] = { 0.0, 0.1, 0.8 };
		drawSideArrows = 0;
		idcLeft = -1;
		idcRight = -1;
		idc = IDC_LB_CURRENT;
		x = 0.35;
		y = 0.105;
		w = 0.375;
		h = 0.75;
	};

	class RemoveCurrent: RscButton
	{
		idc = IDC_REMOVE_CURRENT;
		x = 0.40;
		y = 0.865;
		w = 0.14;
		h = 0.04;
		text = "Remove One";
		action = "btnRemoveCurrent = true";
	};

	class RemoveCurrentAll: RscButton
	{
		idc = IDC_REMOVE_CURRENT_ALL;
		x = 0.55;
		y = 0.865;
		w = 0.14;
		h = 0.04;
		text = "Remove All";
		action = "btnRemoveCurrentAll = true";
	};

	class TypeLabel: Label
	{
		idc = IDC_EQUIP_TYPELABEL;
		x = 0.00;
		y = 0.075;
		w = 0.25;
		h = 0.03;
		text = "Type";
	};

	class ListBG: RscListBoxBG
	{
		idc = IDC_DEFAULT;
		x = 0.00;
		y = 0.105;
		w = 0.3;
		h = 0.75;
	};

	class Primary: RscListBox
	{
		idc = IDC_LB_PRIM;
		x = 0.00;
		y = 0.105;
		w = 0.3;
		h = 0.50;
	};

	class AddPrimary: RscButton
	{
		idc = IDC_BTN_PRIM;
		x = 0.305;
		y = 0.355;
		w = 0.04;
		h = 0.04;
		text = ">>";
		action = "btnAddPrimary = true";
	};

	class PrimaryAmmo: RscListBox
	{
		idc = IDC_LB_PRIM_AMMO;
		x = 0.0;
		y = 0.62;
		w = 0.3;
		h = 0.235;
	};

	class AddPrimaryAmmo: RscButton
	{
		idc = IDC_BTN_PRIM_AMMO;
		x = 0.305;
		y = 0.725;
		w = 0.04;
		h = 0.04;
		text = ">>";
		action = "btnAddPrimaryAmmo=true";
	};

	class Handgun: RscListBox
	{
		idc = IDC_LB_HG;
		x = 0.00;
		y = 0.105;
		w = 0.3;
		h = 0.50;
	};

	class AddHandgun: RscButton
	{
		idc = IDC_BTN_HG;
		x = 0.305;
		y = 0.355;
		w = 0.04;
		h = 0.04;
		text = ">>";
		action = "btnAddHandgun=true";
	};

	class HandgunAmmo: RscListBox
	{
		idc = IDC_LB_HG_AMMO;
		x = 0.0;
		y = 0.62;
		w = 0.3;
		h = 0.235;
	};
	class AddHandgunAmmo: RscButton
	{
		idc = IDC_BTN_HG_AMMO;
		x = 0.305;
		y = 0.725;
		w = 0.04;
		h = 0.04;
		text = ">>";
		action = "btnAddHandgunAmmo=true";
	};

//--------------------------

	class Clothes: RscListBox
	{
		idc = IDC_LB_CLOTHES;
		x = 0.00;
		y = 0.105;
		w = 0.30;
		h = 0.75;
	};

	class AddClothes: RscButton
	{
		idc = IDC_BTN_CLOTHES;
		x = 0.305;
		y = 0.47;
		w = 0.04;
		h = 0.04;
		text = ">>";
		action = "btnAddClothes=true";
	};

//--------------------------
	class Secondary: RscListBox
	{
		idc = IDC_LB_SEC;
		x = 0.00;
		y = 0.105;
		w = 0.3;
		h = 0.50;
	};

	class AddSecondary: RscButton
	{
		idc = IDC_BTN_SEC;
		x = 0.305;
		y = 0.355;
		w = 0.04;
		h = 0.04;
		text = ">>";
		action = "btnAddSecondary=true";
	};

	class SecondaryAmmo: RscListBox
	{
		idc = IDC_LB_SEC_AMMO;
		x = 0.0;
		y = 0.62;
		w = 0.3;
		h = 0.235;
	};
	class AddSecondaryAmmo: RscButton
	{
		idc = IDC_BTN_SEC_AMMO;
		x = 0.305;
		y = 0.725;
		w = 0.04;
		h = 0.04;
		text = ">>";
		action = "btnAddSecondaryAmmo=true";
	};

	class Equipment: RscListBox
	{
		idc = IDC_LB_EQ;
		x = 0.00;
		y = 0.105;
		w = 0.3;
		h = 0.75;
	};

	class AddEquipment: RscButton
	{
		idc = IDC_BTN_EQUIPMENT;
		x = 0.305;
		y = 0.47;
		w = 0.04;
		h = 0.04;
		text = ">>";
		action = "btnAddEquipment=true";
	};

//--------------------------
	class TemplatesLabel: Label
	{
		idc = IDC+0;
		x = 0.75;
		y = 0.5;
		w = 0.3;
		text = "SAVE GEAR";
	};
	class TemplateListBG: RscListBoxBG
	{
		idc = IDC_DEFAULT;
		x = 0.75;
		y = 0.54;
		w = 0.25;
		h = 0.18;
	};
	class Templates: RscListBox
	{
		idc = IDC_LB_TEMPLATES;
		x = 0.75;
		y = 0.54;
		w = 0.25;
		h = 0.18;
	};

	class SaveTemplate: RscButtonLarge
	{
		x = 0.75;
		y = 0.74;
		text = "Save";
		action = "btnSaveTempl=true";
	};
	class LoadTemplate: RscButtonLarge
	{
		x = 0.75;
		y = 0.79;
		text = "Load";
		action = "btnLoadTempl=true";
	};

	class Clear: RscButtonLarge
	{
		idc = IDC+1;
		x = 0.75;
		y = 0.84;
		text = "Clear";
		action = "btnClear=true";
	};

	class EquiInfoLabel: Label
	{
		idc = IDC_DEFAULT;
		x = 0.75;
		y = 0.075;
		w = 0.3;
		text = "Description";
	};
	class EquiInfo: TextField
	{
		idc = IDC_EquiInfo;
		x = 0.745;
		y = 0.105;
		w = 0.25;
		h = 0.40;
		text = "Nothing Selected";
	};

	class Exit: RscButtonLarge
	{
		x = 0.84;
		y = -0.015;
		text = "Exit";
		action = "btnExit=true";
	};
};
