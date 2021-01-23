_myHC = _this select 0;

_fpscount = [];
_lastFPSSent = time;
_lastDiagFps = -10000;

_myHC setVariable ["FPS", -1, true];

while {true}do
{
	setViewDistance serverViewDistance;
	_objVD = viewDistance;
	if ( _objVD > maxObjectViewDistance ) then {_objVD = maxObjectViewDistance;};
	setObjectViewDistance _objVD;

	if ( count(_fpscount) > 50 ) then
	{
		_fpscount set [0, -1];
		_fpscount = _fpscount - [-1];
	};

	if ( time > _lastDiagFps + 10 ) then
	{
		_fpscount = _fpscount + [diag_fps];
		_lastDiagFps = time;
	};

	_fpssum = 0;
	{
		_fpssum = _fpssum + _x;
	}forEach _fpscount;
	_avgfps = _fpssum / count(_fpscount);

	if ( time > _lastFPSSent + 60 ) then
	{
		_lastFPSSent = time;
		_myHC setVariable ["FPS", _avgfps, true];
	};

	sleep 1;
};