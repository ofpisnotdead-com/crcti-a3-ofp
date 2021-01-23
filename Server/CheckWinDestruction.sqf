// args: siLose

_siLose = _this;

sleep 2;

if ( count(pvGameOver) == 0 ) then
{

	_mhq = [];
	_siWin = [];

	if (_siLose == siWest) then
	{
		_mhq = mhqWest;
		_siWin = siEast;
	};

	if (_siLose == siEast) then
	{
		_mhq = mhqEast;
		_siWin = siWest;
	};

	if (!alive _mhq) then
	{
		_structs = [];
		{
			_structs = _structs + ([_siLose, _x] call funcGetWorkingStructures);
		}forEach structsCritical;

		if (count _structs == 0) then
		{
			pvGameOver = [1, _siWin];
			publicVariable "pvGameOver";
		};
	};
};