_first = true;

while {true}do
{
	{
		_type = _x;
		_list = allMissionObjects _type;
		{
			if (local _x) then
			{
				_dist = _x distance player;
				if ( !alive player || _dist > GarbageDeleteDist || _first ) then
				{
					deleteVehicle _x;
				};
			};
		}forEach _list;
	}forEach specialTrash;

	_first = false;
	sleep 30;
};