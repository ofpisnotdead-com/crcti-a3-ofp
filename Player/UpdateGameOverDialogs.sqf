// args: none

btnLeaderboard = false;
btnShowStats = false;
_dlg = "none";

while {gameEndDialog == 0}do
{

	if ( _dlg == "none" && !dialog ) then
	{
		_ok = createDialog "GameOverDialog";		
	};

	if ( _dlg == "lb" && !dialog ) then
	{
		_dlg = "none";
		_lbhandle = [false] execVM "Player\OpenLeaderboardDialog.sqf";
		waitUntil {scriptDone _lbhandle || gameEndDialog != 0 };
		closeDialog 0;
	};

	if ( _dlg == "st" && !dialog ) then
	{
		_dlg = "none";
		_statshandle = [siBoth, false] execVM "Player\OpenStatsDialog.sqf";
		waitUntil {scriptDone _statshandle || gameEndDialog != 0};
		closeDialog 0;
	};

	if ( btnLeaderBoard ) then
	{
		btnLeaderBoard = false;
		_dlg = "lb";
		closeDialog 0;
	};

	if ( btnShowStats ) then
	{
		btnShowStats = false;
		_dlg = "st";
		closeDialog 0;
	};

};

while { dialog } do { closeDialog 0; };