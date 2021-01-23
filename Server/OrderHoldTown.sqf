// args: [unit, si, gi, [ti, dist]]

_unit = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_params = _this select 3;
_ti = _params select 0;
_distDefend = 50*((_params select 1)+1);

_idOrder = ((orderMatrix select _si) select _gi) select 0;
_timeCheckSupport = time + 30 + random 60;
_sleep = time;
_posMove = [];
_flagPos = getPos ((towns select _ti) select tdFlag);
_distToDest = 0;
_patrolStart = time;
_nextPatrolMove = time;
_timedefend = 600;

_state = "update";

while {_state != "finished"}do
{
	sleep 10;

	_formation = (((aiSetting select _si) select _gi) select aisFormation);

	if ( _state == "sleep" && time > _sleep ) then
	{
		_state = "update";
	};

	if ( !alive _unit || isPlayer leader _unit || isPlayer _unit || (_idOrder != ((orderMatrix select _si) select _gi) select 0)) then
	{
		_state = "finished";
	};

	if ( _state == "update") then
	{
		if ( time > _timeCheckSupport ) then
		{
			_timeCheckSupport = time + timeCheckSupport + random(timeCheckSupport);
			_handle = [_unit, _si, _gi] spawn funcAiCheckSupport;
			waitUntil {sleep 5 ; scriptDone _handle};
		};

		_posMove = _flagPos;
		_distToDest = [getPos _unit, _posMove] call funcDistH;

		if ( _distToDest > 150 ) then
		{
			_state = "move";
		}
		else
		{
			if ( vehicle _unit != _unit ) then
			{
				[vehicle _unit, _si, 0] spawn funcEjectCargo;
			};

			_patrolStart = time;
			_nextPatrolMove = 0;
			_state = "patrol";
		};

		if ( (leader group _unit != _unit) && (_formation != 0) ) then
		{
			_sleep = time + 120;
			_state = "sleep";
		};

	};

	if ( _state == "patrol" ) then
	{

		if ( time > _nextPatrolMove) then
		{
			_distPatrol = 0;
			if ( ((towns select _ti) select tdSide) == _si || ((vehicle _unit) isKindOf "Air")) then
			{
				_distPatrol = _distDefend;
			};

			_nextPatrolMove = time + 30 + random(120);

			if ( _formation == 0 ) then
			{
				[_unit, _flagPos,0, _distPatrol] call funcMoveAI;
			}
			else
			{
				if ( leader group _unit == _unit ) then
				{
					[_unit, _flagPos,_gi,_si,0,_distPatrol] call funcMoveAIGroup;
				};
			};

		};

		if (time - _patrolStart > _timeDefend) then
		{
			_state = "update";
		};
	};

	if ( _state == "move") then
	{
		if ( _unit == (driver vehicle _unit)) then
		{
			if ( _formation == 0 ) then
			{
				[_unit, _posMove] call funcMoveAI;
			}
			else
			{
				if ( leader group _unit == _unit ) then
				{
					[_unit, _posMove,_gi,_si] call funcMoveAIGroup;
				};
			};

		};

		_st = ([120, 0.1*_distToDest] select (_distToDest < 120));

		if (_st < 5) then
		{
			_st = 5;
		};

		_sleep = time + _st;

		_state = "sleep";
	};

};

