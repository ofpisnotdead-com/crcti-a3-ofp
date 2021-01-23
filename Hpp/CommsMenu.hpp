class CfgCommunicationMenu
{
	class SupportPosition
	{
		text = "Request Support Truck Position";
		submenu = "";
		expression = " _nul = [] execVM ""Player\SupportPositionRequest.sqf"";"; // Code executed upon activation
		//icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
		//cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
		enable = "1";
		removeAfterExpressionCall = 0;
	};

	class Sitrep
	{
		text = "Send Sitrep";
		submenu = "";
		expression = "_nul = [] execVM ""Common\SendSitrep.sqf"";"; // Code executed upon activation
		//icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
		//cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
		enable = "1";
		removeAfterExpressionCall = 0;
	};

	class Picture
	{
		text = "Request Picture";
		submenu = "";
		expression = "_nul = [] execVM ""Player\RequestPicture.sqf"";"; // Code executed upon activation
		//icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
		//cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
		enable = "1";
		removeAfterExpressionCall = 0;
	};
};
