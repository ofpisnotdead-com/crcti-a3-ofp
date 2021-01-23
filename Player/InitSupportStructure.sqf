// args: [object, type, si, gi]

_v = _this select 0;
_t = _this select 1;
_si = _this select 2;

_v setRepairCargo 0;
_v setAmmoCargo 0;

if ( playerSideIndex == siwest || playerSideIndex == sieast ) then
{
	_v addAction ["Heal/Repair", "Player\ActionHealRepair.sqf", [], 1, false, false];
	_v addAction ["Rearm", "Player\ActionRearm.sqf", [], 1, false, false];
};

