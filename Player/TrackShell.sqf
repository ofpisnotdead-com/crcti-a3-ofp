// args: [[fired eventhandler, side]]

_ev = _this select 0;
_si = _this select 1;

_vehicle = _ev select 0;
_shell = _ev select 6;

_siEnemy = [siWest, siEast] select (_si == siWest);

if ((((upgMatrix select _siEnemy) select upgRadarArtillery) select 3) == 2 && !isNull _shell) then
{
	_radars = [_siEnemy, stAAradar] call funcGetWorkingStructures;
	_radarsLR = [_siEnemy, stAAradarLR] call funcGetWorkingStructures;

	if (count _radars > 0) then
	{

		_detections = 0;
		_timeStart = time;

		while {!isNull _shell}do
		{
			_posShell = getPos _shell;
			if (((getPos _shell) select 2) > 20) then
			{
				{
					if ((_x distance _shell) < radarRange) then {_detections = _detections + 1;};
				}foreach _radars;
				{
					if ((_x distance _shell) < radarRangeLR) then {_detections = _detections + 1;};
				}foreach _radarsLR;
			};
			sleep 0.1;
		};

		_lifetime = time - _timeStart;

		// avoid small arms
		if (_lifetime > 3 && _detections > 0) then
		{
			_dist = 1000 - 5*_detections;
			if (_dist < 100) then {_dist = 100;};
			_dist = random _dist;

			_dir = random 360;
			_posRel = [_dist*sin(_dir), _dist*cos(_dir)];

			_posX = (((getPos _vehicle) select 0) + (_posRel select 0))/10;
			_posY = (((getPos _vehicle) select 1) + (_posRel select 1))/10;

			pvArt = [_si, [_posX*10,_posY*10,0], _detections];
			publicVariable "pvArt";
			_nul = [pvArt] spawn MsgArtilleryShellDetected;

		};
	};
};