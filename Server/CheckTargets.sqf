_group = _this select 0;
_si = _this select 1;

_leader = leader _group;
_siEnemy = siEnemy select _si;

_targets = [];

if ( _si == siWest ) then
{
	_targets = [mhqEast] + (units workerGroupEast);
};
if ( _si == siEast ) then
{
	_targets = [mhqWest] + (units workerGroupWest);
};

{
	if ( _forEachIndex in structsCritical ) then
	{
		{
			_targets = _targets + [_x];
		}forEach _x;
	};
}forEach (structMatrix select _siEnemy);

_groupTargets = [];

{
	if ( (_leader knowsAbout _x) >= attackKnowsAbout && alive _x ) then
	{
		_groupTargets = _groupTargets + [_x];
	};
}forEach _targets;

if ( count(_groupTargets) > 0 ) then
{	
	{
		_best = [_x, _groupTargets] call funcBestTarget;
		_veh = vehicle _x;
		if ( !isNull _x && alive _x && !isNull _best && alive _best ) then
		{
			[_veh, _best] spawn funcFireAt;
		};
		sleep 0.1 + random(0.1);
	}forEach (units _group);
};

