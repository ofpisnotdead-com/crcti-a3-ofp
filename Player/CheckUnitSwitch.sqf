// Check if switching into unit is allowed (SwitchBlocker Upgrade)

_unit = _this select 0;
_si = playerSideIndex;
_siEnemy = siEnemy select _si;

_canSwitch = true;

if ((((upgMatrix select _siEnemy) select upgSwitchBlock) select 3) == 2 ) then
{
	{
		if ( _x distance _unit < 1000 ) then {_canSwitch = false;};
	}forEach (BaseMatrix select _siEnemy);
};

_canSwitch