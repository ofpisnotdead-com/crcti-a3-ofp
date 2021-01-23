// args: [money, si, gi]

private ["_money", "_si", "_gi"];

_money = _this select 0;
if ( _money != 0 ) then
{
	_si = _this select 1;
	_gi = _this select 2;

	[mtScoreMoney, _money, _gi, _si] execVM "Server\Info\SendInfoMsg.sqf";
};
