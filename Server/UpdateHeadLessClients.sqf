waitUntil {!isNil "crcti_kb_initServerDone"};
waitUntil {crcti_kb_initServerDone};
waitUntil {(InsertionState select siWest > 1) && (InsertionState select siEast > 1)};

_localGroup = grpNull;
_localUnit = objNull;

_groups = [];

while {true}do
{
	sleep 5;
	if ( isNull _localGroup ) then
	{
		_localGroup = createGroup Civilian;
	};
	if ( isNull _localUnit ) then
	{
		_localUnit = _localGroup createUnit ["Rabbit_F", [0,0,0], [], 0, "NONE"];
		_localUnit enableSimulation false;
		_localUnit hideObject true;
		_localUnit allowDamage false;
	};

	{
		_group = _x;
		if ( !isNull _group ) then
		{
			_found = false;
			{
				if ( str(_group) == (_x select 0) ) then
				{
					_found = true;
					_x set [1, _group];
					_x set [2, time];
				};
			}forEach _groups;

			if ( ! _found ) then
			{
				_groups = _groups + [[str(_group), _x, time]];
			};
		};
	}forEach (allGroups - [_localGroup, workerGroupWest, workerGroupEast]);

	{
		if ( (_x select 2) - time > 1800 ) then
		{
			_groups set [_forEachIndex, 0];
		};
		//diag_log str(_x);
	}forEach _groups;
	//diag_log format["%1 %2 groups", count(_groups), count(allGroups - [_localGroup, workerGroupWest, workerGroupEast])];

	_groups = _groups - [0];

	_playerGroups = (groupMatrix select siWest) + (groupMatrix select siEast) - (groupAiMatrix select siWest) - (groupAiMatrix select siEast);
	
	_activeHC = [];
	if ( !isNil "HeadLessClients") then
	{
		{
			if ( !isNull (_x select 0) && !local(_x select 0) && !((_x select 0) in _activeHC)) then
			{
				_activeHC = _activeHC + [_x select 0];
			};
		}forEach HeadLessClients;
	};	

	if ( count(_activeHC) > 0 ) then
	{
		_hcs = _activeHC + _activeHC + _activeHC + [leader _localGroup];

		{
			_group = _x select 1;
			_m = _forEachIndex % (count _hcs);
			_hc = _hcs select _m;
			_hcinit = _hc getVariable ["hcinit", false];

			if ( !(_group in _playerGroups) && ( {isPlayer _x}count (units _group)) == 0 && ( {alive _x}count (units _group)) > 0 && _hcinit ) then
			{
				if ( (groupOwner _group) != (owner _hc)) then
				{
					diag_log format["Transfer %1 to %2.", str(_group), str(_hc)];
					(_group) setGroupOwner (owner _hc);
				};
			};
			sleep 1;
		}forEach _groups;
	};
};