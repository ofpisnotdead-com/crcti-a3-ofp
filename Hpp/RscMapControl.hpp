//-------------------------------------
class RscMapControl
{
	type = CT_MAP_MAIN;
	idc = -1;
	style = ST_PICTURE;

	x = 0.1;
	y = 0.1;
	w = 0.3;
	h = 0.3;

	colorSea[] = { 0.56, 0.8, 0.98, 0.5 };
	colorForest[] = { 0.6, 0.8, 0.2, 0.5 };
	colorRocks[] = { 0.6, 0.45, 0.27, 0.4 };
	colorCountlines[] = { 0.7, 0.55, 0.3, 0.6 };
	colorCountlinesWater[] = { 0, 0.53, 1, 0.5 };
	colorMainCountlines[] = { 0.65, 0.45, 0.27, 1 };
	colorMainCountlinesWater[] = { 0, 0.53, 1, 1 };
	colorPowerLines[] = { Dlg_Color_Black, 1 };
	colorLevels[] = { Dlg_Color_Black, 1 };
	colorForestBorder[] = { 0.4, 0.8, 0, 1 };
	colorRocksBorder[] = { 0.6, 0.45, 0.27, 0.4 };
	colorNames[] = { Dlg_Color_Black, 1 };
	colorInactive[] = { Dlg_Color_White, 0.5 };
	colorBackground[] = { Dlg_Color_White, 1 };
	colorText[] = { Dlg_Color_White, 1 };
	colorRailWay[] = { 0.8, 0.2, 0, 1 };
	colorTracks[] = { 0.8, 0.2, 0, 1 };
	colorRoads[] = { 0.8, 0.2, 0, 1 };
	colorMainRoads[] = { 0.8, 0.2, 0, 1 };
	colorTracksFill[] = { 0.8, 0.2, 0, 1 };
	colorRoadsFill[] = { 0.8, 0.2, 0, 1 };
	colorMainRoadsFill[] = { 0.8, 0.2, 0, 1 };
	colorOutside[] = { 0, 0, 0, 1 };
	colorGrid[] = { 0, 0, 0, 1 };
	colorGridMap[] = { 0, 0, 0, 1 };
	maxSatelliteAlpha = 0.75;
	alphaFadeStartScale = 0.15;
	alphaFadeEndScale = 0.29;

	font = "PuristaMedium";
	sizeEx = 0.05;

	fontLabel = "PuristaMedium";
	sizeExLabel = 0.0286458;
	fontGrid = "PuristaMedium";
	sizeExGrid = 0.0286458;
	fontUnits = "PuristaMedium";
	sizeExUnits = 0.0286458;
	fontNames = "PuristaMedium";
	sizeExNames = 0.0286458;
	fontInfo = "PuristaMedium";
	sizeExInfo = 0.0286458;
	fontLevel = "PuristaMedium";
	sizeExLevel = 0.0286458;

	ptsPerSquareSea = 6;
	ptsPerSquareTxt = 8;
	ptsPerSquareCLn = 8;
	ptsPerSquareExp = 8;
	ptsPerSquareCost = 8;
	ptsPerSquareFor = "4.0f";
	ptsPerSquareForEdge = "10.0f";
	ptsPerSquareRoad = 2;
	ptsPerSquareObj = 10;

	text = "";
	ShowCountourInterval = 0;
	scaleDefault = 0.1;
	scaleMin = 0.0;
	scaleMax = 1.0;
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";

	class Task
	{
		icon = "\a3\ui_f\data\map\MapControl\taskicon_ca.paa";
		iconCreated = "\a3\ui_f\data\map\MapControl\taskiconcreated_ca.paa";
		iconCanceled = "\a3\ui_f\data\map\MapControl\taskiconcanceled_ca.paa";
		iconDone = "\a3\ui_f\data\map\MapControl\taskicondone_ca.paa";
		iconFailed = "\a3\ui_f\data\map\MapControl\taskiconfailed_ca.paa";
		color[] = { 1, 0.537, 0, 1 };
		colorCreated[] = { 1, 0.537, 0, 1 };
		colorCanceled[] = { 1, 0.537, 0, 1 };
		colorDone[] = { 1, 0.537, 0, 1 };
		colorFailed[] = { 1, 0.537, 0, 1 };
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class CustomMark
	{

		icon = "\a3\ui_f\data\map\MapControl\waypoint_ca.paa";
		color[] = { 0.6471, 0.6706, 0.6235, 1.0 };
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class ActiveMarker
	{
		color[] = { 0.3, 0.1, 0.9, 1 };
		size = 50;
	};

	class Legend
	{
		x = 0.729;
		y = 0.05;
		w = 0.237;
		h = 0.127;
		font = "PuristaMedium";
		sizeEx = 0.0208333;
		colorBackground[] = { 0.906, 0.901, 0.88, 0.8 };
		color[] = { Dlg_Color_Black, 1 };
	};

	class Bunker
	{
		color[] = { 0, 0.35, 0.7, 1 };
		icon = "\a3\ui_f\data\map\MapControl\bunker_ca.paa";
		size = 14;
		importance = 1.5 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Bush
	{
		icon = "\a3\ui_f\data\map\MapControl\bush_ca.paa";
		color[] = { 0.55, 0.64, 0.43, 1 };
		size = 14;
		importance = 0.2 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class BusStop
	{
		icon = "\a3\ui_f\data\map\MapControl\busstop_ca.paa";
		color[] = { 0, 0, 1, 1 };
		size = 10;
		importance = 1 * 10 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Command
	{
		icon = "#(argb,8,8,3)color(1,1,1,1)";
		color[] = { 0, 0.9, 0, 1 };
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};

	class Cross
	{
		color[] = { 0, 0.35, 0.7, 1 };
		icon = "\a3\ui_f\data\map\MapControl\cross_ca.paa";
		size = 16;
		importance = 0.7 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Fortress
	{
		icon = "\a3\ui_f\data\map\MapControl\bunker_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Fuelstation
	{
		icon = "\a3\ui_f\data\map\MapControl\fuelstation_ca.paa";
		color[] = { 1.0, 0.35, 0.35, 1 };
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.75;
		coefMax = 4;
	};

	class Fountain
	{
		icon = "\a3\ui_f\data\map\MapControl\fountain_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 12;
		importance = 1 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Hospital
	{
		icon = "\a3\ui_f\data\map\MapControl\hospital_ca.paa";
		color[] = { 0.78, 0, 0.05, 1 };
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};

	class Chapel
	{
		icon = "\a3\ui_f\data\map\MapControl\chapel_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 16;
		importance = 1 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};

	class Church
	{
		icon = "\a3\ui_f\data\map\MapControl\church_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};

	class Lighthouse
	{
		icon = "\a3\ui_f\data\map\MapControl\lighthouse_ca.paa";
		color[] = { 0.78, 0, 0.05, 1 };
		size = 20;
		importance = 3 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};

	class Quay
	{
		icon = "\a3\ui_f\data\map\MapControl\quay_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};

	class Rock
	{
		color[] = { 0.35, 0.35, 0.35, 1 };
		icon = "\a3\ui_f\data\map\MapControl\rock_ca.paa";
		size = 12;
		importance = 0.5 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Ruin
	{
		icon = "\a3\ui_f\data\map\MapControl\ruin_ca.paa";
		color[] = { 0.78, 0, 0.05, 1 };
		size = 16;
		importance = 1.2 * 16 * 0.05;
		coefMin = 1;
		coefMax = 4;
	};

	class SmallTree
	{
		icon = "\a3\ui_f\data\map\MapControl\smalltree_ca.paa";
		color[] = { 0.55, 0.64, 0.43, 1 };
		size = 12;
		importance = 0.6 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Stack
	{
		icon = "\a3\ui_f\data\map\MapControl\stack_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 20;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};

	class Tree
	{
		icon = "\a3\ui_f\data\map\MapControl\tree_ca.paa";
		color[] = { 0.55, 0.64, 0.43, 1 };
		size = 12;
		importance = 0.9 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Tourism
	{
		icon = "\a3\ui_f\data\map\MapControl\tourism_ca.paa";
		color[] = { 0.78, 0, 0.05, 1 };
		size = 16;
		importance = 1 * 16 * 0.05;
		coefMin = 0.7;
		coefMax = 4;
	};

	class Transmitter
	{
		icon = "\a3\ui_f\data\map\MapControl\transmitter_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 20;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};

	class ViewTower
	{
		icon = "\a3\ui_f\data\map\MapControl\viewtower_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 16;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};

	class Watertower
	{
		icon = "\a3\ui_f\data\map\MapControl\watertower_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 32;
		importance = 1.2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};

	class Waypoint
	{
		icon = "\a3\ui_f\data\map\MapControl\waypoint_ca.paa";
		color[] = { 0, 0.35, 0.7, 1 };
		size = 32;
		coefMin = 1.00;
		coefMax = 1.00;
		importance = 1.00;
	};

	class WaypointCompleted
	{
		icon = "\a3\ui_f\data\map\MapControl\waypointcompleted_ca.paa";
		color[] = { Dlg_Color_Black, 1 };
		size = 24;
		importance = 1.00;
		coefMin = 1.00;
		coefMax = 1.00;
	};

	class ShipWreck
	{
		coefMax = 1.0;
		coefMin = 0.85;
		color[] = { 0, 0, 0, 1 };
		size = 24;
		importance = 1.0;
		icon = "\a3\ui_f\data\map\MapControl\shipwreck_ca.paa";
	};

	class Power
	{
		coefMax = 1.0;
		coefMin = 0.85;
		color[] = { 1, 1, 1, 1 };
		size = 24;
		importance = 1.0;
		icon = "\a3\ui_f\data\map\MapControl\power_ca.paa";

	};
	class PowerSolar
	{
		coefMax = 1.0;
		coefMin = 0.85;
		color[] = { 1, 1, 1, 1 };
		size = 24;
		importance = 1.0;
		icon = "\a3\ui_f\data\map\MapControl\powersolar_ca.paa";
	};
	class PowerWind
	{
		coefMax = 1.0;
		coefMin = 0.85;
		color[] = { 1, 1, 1, 1 };
		size = 24;
		importance = 1.0;
		icon = "\a3\ui_f\data\map\MapControl\powerwind_ca.paa";
	};
	class PowerWave
	{
		coefMax = 1.0;
		coefMin = 0.85;
		color[] = { 1, 1, 1, 1 };
		size = 24;
		importance = 1.0;
		icon = "\a3\ui_f\data\map\MapControl\powerwind_ca.paa";
	};
};
//-------------------------------------
