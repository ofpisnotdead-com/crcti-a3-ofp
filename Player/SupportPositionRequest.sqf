if ( count ([playerSideIndex, stComm] call funcGetWorkingStructures) == 0 ) then
{
	["No Comm Center", true, false, htGeneral, false] call funcHint;
}
else
{
	_res = [getPos player, [playerSideIndex], typesRearm select playerSideIndex, []] call funcGetClosestVehicle;
	_rearm = _res select 0;

	_res = [getPos player, [playerSideIndex], typesRepair select playerSideIndex, []] call funcGetClosestVehicle;
	_repair = _res select 0;

	_res = [getPos player, [playerSideIndex], typesRefuel select playerSideIndex, []] call funcGetClosestVehicle;
	_refuel = _res select 0;

	_ctext = "Nearest ";
	_rearmMarker = "";
	_repairMarker = "";
	_refuelMarker = "";

	if ( !isNull _rearm ) then
	{
		_pos = getPos _rearm;
		_postext = _pos call funcCalcMapPos;

		_text = format["%1", _this];
		_ctext = _ctext + format["Rearm Truck at %1. ", _postext];

		if ( MapMode > 0 ) then
		{
			_rearmMarker = str(_rearm);
			createMarkerLocal [_rearmMarker, _pos];
			_rearmMarker setMarkerPosLocal _pos;
			_rearmMarker setMarkerTypeLocal sqAmmo;
			_rearmMarker setMarkerColorLocal "colorBlack";
			_rearmMarker setMarkerTextLocal "";
			_rearmMarker setMarkerSizeLocal [1.0,1.0];
		};
	};

	if ( !isNull _repair ) then
	{
		_pos = getPos _repair;
		_postext = _pos call funcCalcMapPos;

		_text = format["%1", _this];
		_ctext = _ctext + format["Repair Truck at %1. ", _postext];

		if ( MapMode > 0 ) then
		{
			_repairMarker = str(_repair);
			createMarkerLocal [_repairMarker, _pos];
			_repairMarker setMarkerPosLocal _pos;
			_repairMarker setMarkerTypeLocal sqSupport;
			_repairMarker setMarkerColorLocal "colorBlack";
			_repairMarker setMarkerTextLocal "";
			_repairMarker setMarkerSizeLocal [1.0,1.0];
		};
	};

	if ( !isNull _refuel ) then
	{
		_pos = getPos _refuel;
		_postext = _pos call funcCalcMapPos;

		_text = format["%1", _this];
		_ctext = _ctext + format["Refuel Truck at %1. ", _postext];

		if ( MapMode > 0 ) then
		{
			_refuelMarker = str(_refuel);
			createMarkerLocal [_refuelMarker, _pos];
			_refuelMarker setMarkerPosLocal _pos;
			_refuelMarker setMarkerTypeLocal sqFuel;
			_refuelMarker setMarkerColorLocal "colorBlack";
			_refuelMarker setMarkerTextLocal "";
			_refuelMarker setMarkerSizeLocal [1.0,1.0];
		};
	};

	if ( isNull _rearm && isNull _repair && isNull _refuel ) then
	{
		_ctext = format["No Support available.", _this];
		player groupChat _ctext;
	}
	else
	{
		player groupChat _ctext;
		sleep 120;
		deleteMarkerLocal _rearmMarker;
		deleteMarkerLocal _repairMarker;
		deleteMarkerLocal _refuelMarker;

	};

};