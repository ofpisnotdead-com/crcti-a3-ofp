// arguments: [pos, pos]
// return: distance

private ["_dist", "_pos0", "_pos1"];

_pos0 = _this select 0;
_pos1 = _this select 1;

_dist = [_pos0 select 0, _pos0 select 1, 0] distance [_pos1 select 0, _pos1 select 1, 0]; 

_dist