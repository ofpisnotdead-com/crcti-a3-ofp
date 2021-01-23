// args: [unit, si, gi, [wp, wp]]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_params = _this select 3;
_wp0 = ((wpCO select _si) select (_params select 0));
_wp1 = ((wpCO select _si) select (_params select 1));
_wps = [_wp0, _wp1];

_idOrder = ((orderMatrix select _si) select _gi) select 0;

_second = false;
_timeCheckSupport = time + 30 + random 60;
_sleep = 30;
_sleept = time;
_state = "update";
_posMove = [];
_distToDest = 0;

while {_state != "finished"}do
{
	sleep 10;

	if ( !(alive _unit) || isPlayer leader _unit || isPlayer _unit || _idOrder != ((orderMatrix select _si) select _gi) select 0 ) then
	{
		_state = "finished";
	};

	if ( _state == "update") then
	{
		_vehicle = vehicle _unit;

		_posMove = _wps select _second;
		_distToDest = [getPos _unit, _posMove] call funcDistH;

		_minDest = 50;
		if ( _vehicle isKindof "Air") then
		{
			_minDest = 250;
		};

		if ( _distToDest > _minDest ) then
		{
			_state = "move";
		}
		else
		{
			_sleep = 30;
			_second = !_second;
			_state = "sleep";
		};

		if (_vehicle != _unit && _unit != (effectiveCommander _vehicle)) then
		{
			_sleep = 30;
			_state = "sleep";
		};

		if ( time > _timeCheckSupport ) then
		{
			_timeCheckSupport = time + timeCheckSupport + random(timeCheckSupport);
			_handle = [_unit, _si, _gi] spawn funcAiCheckSupport;
			waitUntil { sleep 5 ; scriptDone _handle };
		};

	};

	if ( _state == "move") then
	{
		[_unit, _posMove] call funcMoveAI;
		_sleep = [30, 0.1*_distToDest] select (_distToDest < 300);
		_state = "sleep";
	};

	if (_state == "sleep") then
	{
		_sleept = time + _sleep;
		_state = "sleeping";
	};

	if ( _state == "sleeping") then
	{
		if ( time > _sleept ) then
		{
			_state = "update";
		};
	};

};