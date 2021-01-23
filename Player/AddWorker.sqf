// args: [unit]

_unit = _this select 0;
_side = side _unit;

if (_side != west && _side != east) then
{
	["You are a Renegade", true, false, htGeneral, false] call funcHint;
}
else
{
	_money = (groupMoneyMatrix select playerSideIndex) select playerGroupIndex;

	if (_money < costWorker) then
	{
		["Not enough money", true, false, htGeneral, false] call funcHint;
	}
	else
	{
		if !(alive mhq) then
		{
			["MHQ Destroyed", true, false, htGeneral, false] call funcHint;
		}
		else
		{
			pvAddWorker = playerSideIndex;
			if ( isServer ) then
			{
				_nul = [pvAddWorker] spawn MsgAddWorker;
			}
			else
			{
				publicVariable "pvAddWorker";
			};
		};
	};
};