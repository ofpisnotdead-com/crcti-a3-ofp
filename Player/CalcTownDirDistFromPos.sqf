// arguments: pos ([x,y])
// returns: [nameTown, dirText, distance] ("Levie", "NE", 800)

private ["_res", "_pos", "_name", "_dist", "_dir", "_dirsText", "_dirIndex", "_dirText", "_ret"];

_res = [_this, [siWest, siEast, siRes],[]] call funcGetClosestTown;

_pos = getPos ((_res select 0) select 0);
_name = (_res select 0) select 1;
_dist = _res select 1;

// 100 m resolution
_dist = _dist - (_dist % 100);

_dir = ((_this select 0) - (_pos select 0)) atan2 ((_this select 1) - (_pos select 1));
if (_dir < 0) then {_dir = _dir + 360};

_dirsText = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"];

_dirIndex = (_dir + 22.5)/45;
_dirIndex = _dirIndex - (_dirIndex % 1);
_dirText = _dirsText select _dirIndex;

_ret = [_name, _dirText, _dist];

_ret