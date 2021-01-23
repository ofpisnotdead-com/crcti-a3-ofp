// args: [sideIndex]

_si = _this select 0;
_cost = costWorker;
_gi = -1;
_ut = -1;
_mhq = objNull;
_group = grpNull;

if ( _si == siWest ) then
{
	_group = workerGroupWest;

	if (pvWorkersWest < maxWorkers) then
	{
		_mhq = mhqWest;		
		pvWorkersWest = pvWorkersWest + 1;		
		publicVariable "pvWorkersWest";
		_gi = [groupCommander select siWest, groupMatrix select siWest] call funcGetIndex;
		_ut = utWorkerW;
	};
		
};

if ( _si == siEast ) then
{
	_group = workerGroupEast;
	
	if (pvWorkersEast < maxWorkers) then
	{
		_mhq = mhqEast;		
		pvWorkersEast = pvWorkersEast + 1;
		publicVariable "pvWorkersEast";
		_gi = [groupCommander select siEast, groupMatrix select siEast] call funcGetIndex;
		_ut = utWorkerE;
	};
};

if ( _ut != -1 && !isNull _mhq && alive _mhq ) then
{
	[_si, _gi, _cost] call funcMoneySpend;

	_trys = 0;
	_pos = getPos _mhq;
	_npos = [];

	while { count _npos == 0 && _trys < 200 } do
	{
		_npos = _pos findEmptyPosition [1,500];
		_trys = _trys + 1;
	};

	[_ut, 0, 0, 0, _npos, 0, _si, -1, _group, "NONE", true, false] spawn funcAddUnit;

};