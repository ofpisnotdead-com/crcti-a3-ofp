// args: [typeInf, sideIndex, groupIndexBuyer, groupIndexJoin]

_type = _this select 0;
_si = _this select 1;
_giBuyer = _this select 2;
_giJoin = _this select 3;

[mtUnitBuilding, _this select 0, _this select 2, _this select 3, _this select 1] execVM "Server\Info\SendInfoMsg.sqf";