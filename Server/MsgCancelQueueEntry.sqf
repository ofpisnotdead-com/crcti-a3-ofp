if ( isServer ) then
{
	_pvCancelQueueEntry = _this select 0;
	_entryIdx = _pvCancelQueueEntry select 0;
	_si = _pvCancelQueueEntry select 1;
	_gi = _pvCancelQueueEntry select 2;

	_queues = factoryQueues select _si;

	{
		_queue = _x select 2;

		if ( count _queue > 0 ) then
		{
			{
				_entry = _x;
				if ( (_entry select 7) == _entryIdx && !(_entry select 6)) exitWith
				{
					_type = _entry select 0;
					_driver = _entry select 1;
					_gunner = _entry select 2;
					_commander = _entry select 3;
					_giJoin = _entry select 4;
					_giBuyer = _entry select 5;

					if ( _giJoin == _gi || _giBuyer == _gi || (groupCommander select _si) == ((groupMatrix select _si) select _gi) ) then
					{

						_model = (unitDefs select _type) select udModel;

						_bVehicle = false;
						if (!(_model isKindOf "Man")) then
						{
							_bVehicle = true;
						};

						_unitsToBuild = 1;
						if ( _bVehicle ) then
						{
							_weptmp = (_model call funcGetVehicleWeapons);
							_gunners = _weptmp select 3;
							_commanders = _weptmp select 4;

							_unitsToBuild = _driver;
							_unitsToBuild = _unitsToBuild + _gunner*count(_gunners);
							_unitsToBuild = _unitsToBuild + _commander*count(_commanders);
						};

						(groupUnitsBuildingMatrix select _si) set [_giJoin, ((groupUnitsBuildingMatrix select _si) select _giJoin) - _unitsToBuild];

						_x set [6, true];
						publicVariable "factoryQueues";

						[_type, _si, _gi, _giBuyer] execVM "Server\Info\UnitQueueCancel.sqf";
					}
					else
					{
						[_type, _si, _gi] execVM "Server\Info\UnitQueueCancelFail.sqf";
					};
				};
			}forEach _queue;
		};
	}forEach _queues;
};