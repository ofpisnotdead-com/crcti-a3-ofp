MusicPlaying = "";

addMusicEventHandler ["MusicStart", {MusicPlaying = (_this select 0)}];
addMusicEventHandler ["MusicStop", {MusicPlaying = ""}];

_tracks = ["C_EA_RadioMusic1","C_EA_RadioMusic2"];

{
	if ( !isClass(configfile >> "CfgMusic" >> _x) && !isClass(configfile >> "CfgSounds" >> _x)) then
	{
		_tracks set [_forEachIndex ,0];
	};
}forEach _tracks;
_tracks = _tracks - [0];

while {count(_tracks) > 0}do
{
	_posInfo = [getPos player, playerSideIndex] call funcGetClosestBase;

	_dist = 1000000;
	if ( count(_posInfo) > 2 ) then
	{
		_dist = _posInfo select 2;
	};

	if ( MusicPlaying == "" && _dist < 100 ) then
	{
		0 fadeMusic 0;
		_track = _tracks select random((count _tracks)-1);
		playMusic _track;
		3 fadeMusic 1;
	};

	if ( !alive player || (MusicPlaying in _tracks && _dist > 110) ) then
	{
		3 fadeMusic 0;
		sleep 4;
		MusicPlaying = "";
		playMusic "";
	};

	sleep 0.2;
};