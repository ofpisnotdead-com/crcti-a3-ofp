class GameOverDialog: Menu
{
	idd = IDD_GameOverDialog;
	movingEnable = true;
	controlsBackground[] = { };
	objects[] = { };
	controls[] = { Leaderboard, Stats };

	class Leaderboard: RscButtonLarge
	{
		x = 0.0;
		y = 0.03;
		w = 0.2;
		text = "Leaderboard";
		action = "btnLeaderboard=true";
	};

	class Stats: RscButtonLarge
	{
		x = 0.8;
		y = 0.03;
		w = 0.2;
		text = "Statistics";
		action = "btnShowStats=true";
	};
};
