// args: none

_respawnMarker = "";
if (playerSideIndex == siWest) then
{
	_respawnMarker = "Respawn_West";
	_respawnMarker setMarkerPosLocal (getPos mhqWest);
};

if (playerSideIndex == siEast) then
{
	_respawnMarker = "Respawn_East";
	_respawnMarker setMarkerPosLocal (getPos mhqEast);
};

_lastRespawnObject = respawnObject;

while {true}do
{
	if (!alive respawnObject) then
	{

		if (respawnType == 10) then
		{

			respawnType = 10;
			respawnObject = mhq;

			{
				_typeStruct = _x;
				_structs = [playerSideIndex, _typeStruct] call funcGetWorkingStructures;

				if (count _structs > 0) exitWith
				{
					respawnType = _forEachIndex;
					respawnObject = _structs select 0;
				};
			}forEach structsRespawn;

		};

		if (respawnType >= 0 && respawnType != 10 ) then
		{
			_typeStruct = structsRespawn select respawnType;
			_structs = [playerSideIndex, _typeStruct] call funcGetWorkingStructures;

			if (count _structs > 0) then
			{
				respawnObject = _structs select 0;
			}
			else
			{
				respawnType = 10;
				respawnObject = mhq;
			};

		};

	};

	if (_lastRespawnObject != respawnObject && respawnType != 10 ) then
	{
		_lastRespawnObject = respawnObject;
		_res = [respawnObject, structsRespawn select respawnType, playerSideIndex] call funcCalcUnitPlacementPosDir;
		_destination = _res select 0;
		_respawnMarker setMarkerPosLocal _destination;		
	};

	// update respawnmarker for moving mhq
	if (respawnType == 10) then
	{
		_lastRespawnObject = respawnObject;
		_dir = getDir mhq;
		_pos = getPos mhq;
		_destination = [(_pos Select 0)-(sin _dir)*10,(_pos Select 1)-(cos _dir)*10,0];
		_respawnMarker setMarkerPosLocal _destination;
	};

	sleep 5;
};

