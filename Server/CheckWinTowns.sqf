// args: si

_si = _this;
_towns = count towns;
_minutes = 30 - _towns;

if (_minutes < 5) then
{
	_minutes = 5;
};

_seconds = _minutes*60;
_interval = 15;

_all = true;
while {_all}do
{

	{
		if (_si != (_x select tdSide)) then
		{
			_all = false;
		};
	}foreach towns;

	if ((_seconds % 60) == 0 && _all) then
	{
		[_seconds/60] execVM "Server\Info\TimeUntilTownWin.sqf";
	};

	if (_seconds <= 0 && _all) then
	{
		pvGameOver = [2, _si];
		publicVariable "pvGameOver";
		_all = false;
	};

	sleep _interval;
	_seconds = _seconds - _interval;

};

