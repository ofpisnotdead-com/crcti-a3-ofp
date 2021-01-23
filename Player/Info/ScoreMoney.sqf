// args: [params]

private ["_money", "_si", "_gi"];

_money = _this select 1;
_gi = _this select 2;
_si = _this select 3;

if ((_si == playerSideIndex) && (_gi == playerGroupIndex) && (_money > 0)) then
{
	[format ["Score Bonus: $%1", _money ], false, true, htScore, false] call funcHint;
};
if ((_si == playerSideIndex) && (_gi == playerGroupIndex) && (_money < 0)) then
{
	[format ["Penalty: $%1", _money ], false, true, htScore, false] call funcHint;
};

