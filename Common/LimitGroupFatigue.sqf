private ["_group"];
_group = _this select 0;

if ( FatigueEnabled > 0 ) then
{
	{		
		if ( getFatigue _x > FatigueLimit && !(isPlayer _x) ) then
		{
			_x setFatigue FatigueLimit;
		};	
	}forEach (units _group);
};