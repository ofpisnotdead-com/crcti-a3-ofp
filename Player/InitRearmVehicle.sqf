// args: [object, type, si, gi]

_v = _this select 0;
_si = _this select 2;

_v setAmmoCargo 0;
clearWeaponCargo _v;
clearMagazineCargo _v;

if ( playerSideIndex == siwest || playerSideIndex == sieast ) then
{	
	_v addAction ["Rearm others", "Player\ActionRearm.sqf", [], 2, false, false, "", "vehicle _this == _target"];
	_v addAction ["Rearm yourself", "Player\ActionRearm.sqf", [], 2, false, false, "", "vehicle _this == _this"];
	_v addAction ["Rearm your vehicle", "Player\ActionRearm.sqf", [], 2, false, false, "", "vehicle _this != _target && vehicle _this != _this"];
};

