// args: pvRepairMHQ

_pvRepairMHQ = _this select 0;

_gi = _pvRepairMHQ select 0;
_si = _pvRepairMHQ select 1;

_money = (groupMoneyMatrix select _si) select _gi;
if (_money >= costRepairMHQ) then
{
	[_si, _gi, costRepairMHQ] call funcMoneySpend;
	_nul = [_si] execVM "Server\Info\MHQRepaired.sqf";

	if ( _si == siWest ) then
	{
		_mhq = mhqWest;
		_pos = getPos _mhq;
		_dir = getDir _mhq;
		_mhq setPos [-1000,-1000,100];
		sleep 1;
		[utMHQWest, 0, 0, 0, _pos, _dir, siWest, -1, tempGroupWest, "NONE",false, false] call funcAddUnit;
		sleep 1;
		deleteVehicle _mhq;
	};

	if ( _si == siEast ) then
	{
		_mhq = mhqEast;
		_pos = getPos _mhq;
		_dir = getDir _mhq;
		_mhq setPos [-1000,-1000,100];
		sleep 1;
		[utMHQEast, 0, 0, 0, _pos, _dir, siEast, -1, tempGroupEast, "NONE",false, false] call funcAddUnit;
		sleep 1;
		deleteVehicle _mhq;
	};
};