// args: [si]

_si = _this select 0;

waitUntil {!isNil "crcti_kb_initServerDone"};
waitUntil {crcti_kb_initServerDone};
waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
waitUntil {!isNull mhqWest && !isNull mhqEast};

_dir = getDir mhqWest;
_pos = getPos mhqWest;
_posWest = [(_pos Select 0)-(sin _dir)*10,(_pos Select 1)-(cos _dir)*10,0];

_dir = getDir mhqEast;
_pos = getPos mhqEast;
_posEast = [(_pos Select 0)-(sin _dir)*10,(_pos Select 1)-(cos _dir)*10, 0];

posRespawnAi = [_posWest, _posEast];
publicVariable "posRespawnAi";

_mhq = objNull;
_respawnObject = objNull;

if (_si == siWest) then
{
	_mhq = mhqWest;
	pvRespawnObjectAiWest = _mhq;
	publicVariable "pvRespawnObjectAiWest";
	_respawnObject = pvRespawnObjectAiWest;
};

if (_si == siEast) then
{
	_mhq = mhqEast;
	pvRespawnObjectAiEast = _mhq;
	publicVariable "pvRespawnObjectAiEast";
	_respawnObject = pvRespawnObjectAiEast;
};

_state = "update";
while {_state != "finished"}do
{

	_marker = "";
	if (_si == siWest) then
	{
		_mhq = mhqWest;
		_marker = "Respawn_West";

		if ( isNil "pvRespawnObjectAiWest" ) then {pvRespawnObjectAiWest = mhqWest; _respawnObject = objNull};
	};
	if (_si == siEast) then
	{
		_mhq = mhqEast;
		_marker = "Respawn_East";

		if ( isNil "pvRespawnObjectAiEast" ) then {pvRespawnObjectAiEast = mhqEast; _respawnObject = objNull};
	};

	_marker setMarkerPosLocal (posRespawnAI select _si);

	_commanderChangedRespawn = false;
	if (_si == siWest && pvRespawnObjectAiWest != _respawnObject) then
	{
		_respawnObject = pvRespawnObjectAiWest;
		_commanderChangedRespawn = true;
	};
	if (_si == siEast && pvRespawnObjectAiEast != _respawnObject) then
	{
		_respawnObject = pvRespawnObjectAiEast;
		_commanderChangedRespawn = true;
	};

	if ( _commanderChangedRespawn ) then
	{
		{
			if (_respawnObject in ((structMatrix select _si) select _x)) exitWith
			{
				_res = [_respawnObject, _x, _si] call funcCalcUnitPlacementPosDir;
				posRespawnAi set [_si, _res select 0];
				publicVariable "posRespawnAi";
			};
		}forEach structsRespawn;
	};

	if (!alive _respawnObject) then
	{

		_minDist = 1000000;
		_newStruct = objNull;
		_newType = -1;

		{
			_type = _x;
			_structs = [_si, _type] call funcGetWorkingStructures;
			{
				_dist = _respawnObject distance _x;

				if (_dist < _minDist) then
				{
					_newStruct = _x;
					_newType = _type;
					_minDist = _dist;
				};
			}foreach _structs;
		}forEach structsRespawn;

		if ( isNull _newStruct ) then
		{
			_respawnObject = _mhq;
			if (_si == siWest) then
			{
				pvRespawnObjectAiWest = _respawnObject;
				publicVariable "pvRespawnObjectAiWest";
			};
			if (_si == siEast) then
			{
				pvRespawnObjectAiEast = _respawnObject;
				publicVariable "pvRespawnObjectAiEast";
			};
		}
		else
		{
			_respawnObject = _newStruct;
			_res = [_respawnObject, _newType, _si] call funcCalcUnitPlacementPosDir;

			_destination = _res select 0;
			posRespawnAi set [_si, _destination];
			publicVariable "posRespawnAi";

			if (_si == siWest) then
			{
				pvRespawnObjectAiWest = _respawnObject;
				publicVariable "pvRespawnObjectAiWest";
			};
			if (_si == siEast) then
			{
				pvRespawnObjectAiEast = _respawnObject;
				publicVariable "pvRespawnObjectAiEast";
			};
		};
	};

	if (_respawnObject == _mhq) then
	{
		_dir = getDir _mhq;
		_pos = getPos _mhq;
		_destination = [(_pos Select 0)-(sin _dir)*10, (_pos Select 1)-(cos _dir)*10, 0];
		posRespawnAi set [_si, _destination];
		publicVariable "posRespawnAi";
	};

	sleep 5;
};