// args: [_type, _si, _gi, _pos, _dir]

_type = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_pos = _this select 3;
_dir = _this select 4;
_FloatObj = _this select 5;

_structDesc = structDefs select _type;

_nul = [_type, _si, _gi, _pos, _dir, _FloatObj] execVM "Server\PlaceStructure.sqf";

_cost = _structDesc select sdCost;
[_si, _gi, _cost] call funcMoneySpend;
