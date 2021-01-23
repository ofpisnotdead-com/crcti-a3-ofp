_groups = (groupMatrix select siWest) + (groupMatrix select siEast);

while {count(pvGameOver) == 0}do
{
	{
		_leader = leader _x;
		if ( local _leader ) then
		{
			_lastDest = _leader getVariable "expectedDestination";

			if ( isNil "_lastDest" ) then
			{
				_lastDest = [0,0,0];
				_leader setVariable["expectedDestination",_lastDest, true];
			};

			_destRecord = expectedDestination _leader;
			_dest = [0,0,0];
			if (count _destRecord > 0 && !isPlayer _leader) then
			{
				_dest = _destRecord select 0;
			};

			if ( str(_lastDest) != str(_dest)) then
			{
				_leader setVariable["expectedDestination",_dest, true];
			};
		};
		sleep 1 + random(1);
	}forEach _groups;

};