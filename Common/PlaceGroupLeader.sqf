// args: [unit, si, gi]

_unit = _this Select 0;
_si = _this Select 1;
_gi = _this Select 2;

waitUntil {!isNil "crcti_kb_initServerDone"};
waitUntil {crcti_kb_initServerDone};
waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
waitUntil {!(isNull mhqWest) && !(isNull mhqEast)};

if ( local _unit ) then
{
	_placed = false;
	if ( (InsertionState select _si) < 2 && IntroMode > 1 ) then
	{
		[_unit,"TARGET"] call funcDisableAI;
		[_unit,"AUTOTARGET"] call funcDisableAI;
		[_unit,"FSM"] call funcDisableAI;
		_unit setCombatMode "BLUE";
		_unit setBehaviour "CARELESS";
		_unit setSpeedMode "FULL";

		waitUntil {(InsertionState select _si) == 1};

		{
			_punit = _x select 0;
			_ch = _x select 1;

			if ( _punit == _unit ) exitWith
			{
				while {vehicle _unit != _ch && !isNull _ch && alive _ch}do
				{
					_unit moveInCargo _ch;
					sleep random(0.25);
				};
				_placed = true;
			};

		}forEach (InsertionChoppers select _si);

		_nul = _unit spawn {
			waitUntil {sleep 1 ; vehicle _this == _this};

			[_this, "TARGET"] call funcEnableAI;
			[_this, "AUTOTARGET"] call funcEnableAI;
			[_this, "FSM"] call funcEnableAI;
			_this setCombatMode "YELLOW";
			_this setBehaviour "AWARE";
			_this setSpeedMode "FULL";
		};
	};

	if ( !_placed ) then
	{
		_obj = objNull;
		if (_si == siWest) then
		{
			if (isNil "pvRespawnObjectAiWest") then
			{
				_obj = mhqWest;
			}
			else
			{
				if (isNull pvRespawnObjectAiWest) then
				{
					_obj = mhqWest;
				}
				else
				{
					_obj = pvRespawnObjectAiWest;
				};
			};
		};

		if (_si == siEast) then
		{
			if (isNil "pvRespawnObjectAiEast") then
			{
				_obj = mhqEast;
			}
			else
			{
				if (isNull pvRespawnObjectAiEast) then
				{
					_obj = mhqEast;
				}
				else
				{
					_obj = pvRespawnObjectAiEast;
				};
			};
		};

		_pos = getPos _obj;
		_dir = getDir _obj;

		_pos = [(_pos Select 0) - 20*sin(_dir), (_pos Select 1) - 20*cos(_dir), 0];
		_dist = (10 + _gi*5);
		_unit setPos [(_pos Select 0) + _dist*sin(_dir+90), (_pos Select 1) + _dist*cos(_dir+90), 0];
		_unit setDir _dir;

	};
};
