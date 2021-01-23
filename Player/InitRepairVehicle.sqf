// args: [object, type, si, gi]

_v = _this select 0;
_si = _this select 2;

_v setRepairCargo 0;
clearWeaponCargo _v;
clearMagazineCargo _v;

if ( playerSideIndex == siwest || playerSideIndex == sieast ) then
{
	_v addAction ["Heal yourself", "Player\ActionHealRepair.sqf", [], 2, false, false, "", "vehicle _this == _this"];
	_v addAction ["Heal/Repair others", "Player\ActionHealRepair.sqf", [], 2, false, false, "", "vehicle _this == _target"];
	_v addAction ["Repair your vehicle", "Player\ActionHealRepair.sqf", [], 2, false, false, "", "vehicle _this != _target && vehicle _this != _this"];
};

if ( playerSideIndex == _si ) then
{
	_nul = [_this, ["Support Vehicle Build Menu"], 50, false] execVM "Player\UpdateFarUnitActions.sqf";
};

_v addAction ["Rap Truck!", "Player\ActionRapTruck.sqf", [], 2, false, false];