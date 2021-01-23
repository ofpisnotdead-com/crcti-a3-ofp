waitUntil {!isNil "crcti_kb_initServerDone"};
waitUntil {crcti_kb_initServerDone};

while {true}do
{
	if ( !isNil "posRespawnAI" ) then
	{
		{
			_marker = ["Respawn_East", "Respawn_West"] select (_x == siWest);
			_marker setMarkerPosLocal (posRespawnAI select _x);
		}forEach [siWest, siEast];
	};

	sleep 5;
};