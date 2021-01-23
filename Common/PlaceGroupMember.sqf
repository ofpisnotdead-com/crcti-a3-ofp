// args: [unit, side]	

_unit = _this select 0;
_si = _this select 1;

waitUntil {!isNil "crcti_kb_initServerDone"};
waitUntil {crcti_kb_initServerDone};
waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
waitUntil {!(isNull mhqWest) && !(isNull mhqEast)};

if ( local leader _unit && !isPlayer _unit) then
{
	waitUntil {local _unit};
};

if ( local _unit ) then
{
	_placed = false;
	if ( (InsertionState select _si) < 2 && IntroMode > 1) then
	{
		[_unit,"TARGET"] call funcDisableAI;
		[_unit,"AUTOTARGET"] call funcDisableAI;
		[_unit,"FSM"] call funcDisableAI;
		_unit setCombatMode "BLUE";
		_unit setBehaviour "CARELESS";
		_unit setSpeedMode "FULL";

		waitUntil {(InsertionState select _si) == 1};

		_oldGroup = group _unit;
		_tempGroup = createGroup ([East, West] select (_si == siWest));
		[_unit] joinSilent _tempGroup;

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

		_nul = [_unit, _oldGroup, _tempGroup] spawn {
			_unit = _this select 0;
			_oldGroup = _this select 1;
			_tempGroup = _this select 2;

			waitUntil {sleep 1 ; vehicle _unit == _unit};

			[_unit] joinSilent _oldGroup;
			deleteGroup _tempGroup;

			[_unit, "TARGET"] call funcEnableAI;
			[_unit, "AUTOTARGET"] call funcEnableAI;
			[_unit, "FSM"] call funcEnableAI;
			_unit setCombatMode "YELLOW";
			_unit setBehaviour "AWARE";
			_unit setSpeedMode "FULL";			
		};
	};

	if ( ! _placed ) then
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
		_pos = [_pos, 5, 20, true, _unit] call funcGetRandomPos;

		_unit setPos _pos;
		_unit setDir _dir;
	};
};