// returns: distance

private [ "_distMax", "_dist"];

_distMax = 10;

{
   _dist = posCenter distance _x;
   if (_dist > _distMax) then
   {
     _distMax = _dist;
   };
} forEach startLocsRandom;

_distMax
