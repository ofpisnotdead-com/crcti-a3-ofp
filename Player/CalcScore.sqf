// arguments: [si,gi]
// returns: score

private ["_score", "_si", "_gi", "_group", "_unit", "_id", "_scoreline"];

_si = _this select 0;
_gi = _this select 1;
_group = (groupMatrix select _si) select _gi;
_unit = leader _group;

_score = 0;

_id = str(_si);
if ( isPlayer _unit ) then
{
	_id = getPlayerUID _unit;
};

{
	if ( (_si == _x select 0) && _id == (_x select 1)) exitWith
	{
		_score = _x select 4;
	};
}forEach groupScoreMatrix;

_score
