// arguments: [si,gi]
// returns: score

private ["_si", "_gi", "_group", "_unit", "_scorePlayers", "_score", "_place", "_id"];

_si = _this select 0;
_gi = _this select 1;
_group = (groupMatrix select _si) select _gi;
_unit = leader _group;

_id = "-1";
if ( isPlayer _unit ) then
{
	_id = getPlayerUID _unit;
};

_scoresPlayers = [];
{
	if ( (_x select 1) != "0" && (_x select 1) != "1" && (_x select 1) != "2") then
	{
		_scoresPlayers = _scoresPlayers + [_x];
	};
}forEach groupScoreMatrix;

_scoresPlayers = [4, false, _scoresPlayers] call funcSort;

_place = [count(_scoresPlayers)+1, count(_scoresPlayers)+1];

{
	_score = _x;
	if ( (_si == _score select 0) && _id == (_score select 1)) exitWith
	{
		_place = [_forEachIndex + 1, count(_scoresPlayers)];
	};
}forEach _scoresPlayers;

_place