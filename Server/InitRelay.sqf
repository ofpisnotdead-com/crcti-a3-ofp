// args: [_type, _si, _objects]
if ( AcreAllowed && count _this > 3) then
{
	sleep 15;

	_type = _this select 0;
	_si = _this select 1;
	_objects = _this select 2;
	_object = _objects select 0;

	_relayIdx = -1;

	{
		_relobj = _x;
		if ( !alive _relobj || isNull _relobj ) exitWith
		{
			_relayIdx = _forEachIndex;
		};
	}forEach (pvAcreRelays select _si);

	if ( _relayIdx != -1 ) then
	{
		_chan0 = _relayIdx;
		_chan1 = _relayIdx + 1;

		_freq0 = (pvAcreFreq select _si) select _chan0;
		_freq1 = (pvAcreFreq select _si) select _chan1;

		(pvAcreRelays select _si) set [_relayIdx, _object];
		publicVariable "pvAcreRelays";

		_res = ["ACRE_PRC117F", _object, _freq0, _freq1, 20000] call acre_api_fnc_attachRxmtToObj;
	};
};