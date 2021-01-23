// args: [pos]
_pos = _this select 0;

_newidx = -1;
_newpos = [-1,-1];

// Find nearest, then delete.

for [ {_i=0}, {_i<countWP}, {_i=_i+1}] do
{
	_oldwp = wpPlayer select _i;
	if ( (_oldwp distance _pos) < 15 ) then
	{
		_newidx = _i;
		_newpos = [-1,-1];
	};
};

// Set New
if ( _newidx == -1 ) then
{
	for [ {_i=0}, {_i<countWP}, {_i=_i+1}] do
	{
		_wp = wpPlayer select _i;

		if ( (_wp select 0) == -1 && (_wp select 1) == -1) exitWith
		{
			_newidx = _i;
			_newpos = _pos;
		};
	};
};

if ( _newidx != -1 ) then
{
	wpPlayer set [_newidx, _newpos];
	_marker = format["wp_%1", _newidx];

	_marker setMarkerPosLocal hiddenMarkerPos;

	if ( (_newpos select 0) != -1 && (_newpos select 1) != -1 && playerGroup != (groupCommander select playerSideIndex) ) then
	{
		_marker setMarkerPosLocal _pos;
	};

	if ( playerGroup == (groupCommander select playerSideIndex) ) then
	{
		_nul = [_newidx, _newpos, PlayerSideIndex, PlayerGroupIndex] call funcSetWaypointCO;
	};
};