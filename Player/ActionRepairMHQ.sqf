// args: [vehicle, unit, actionID]

_mhq = _this select 0;

_si = playerSideIndex;
_gi = playerGroupIndex;

_money = (groupMoneyMatrix select _si) select _gi;
if (_money < costRepairMHQ) then
{
	[format["Not enough money.\nCost: $%1.\nYou need $%2 more.", costRepairMHQ, costRepairMHQ - _money], true, false, htGeneral, false] call funcHint;
}
else
{	
	pvRepairMHQ = [_gi,_si];
	publicVariable "pvRepairMHQ";
};

