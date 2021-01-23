// args: [group, si, gi]

_group = _this select 0;
_si = _this select 1;
_gi = _this select 2;

if ( isServer ) then
{
	_leader = (units _group) select 0;

	if ( count(pvGameOver) == 0 ) then
	{

		diag_log format["Player Disconnected: _group=%1, _si=%2, _gi=%3", _group, _si, _gi];
		diag_log format["Timeout in %1s", disconnectTimeout];

		_t = time + disconnectTimeout;
		
		while {time < _t}do
		{
			_leader = (units _group) select 0;
			if ( isPlayer _leader ) then
			{
				_t = -1;
				diag_log format["Timeout aborted: _group=%1, _si=%2, _gi=%3", _group, _si, _gi];
			};

			if (_group == (groupCommander select _si)) then
			{
				[_si, ceil(_t-time)] execVM "Server\Info\CommanderTimeout.sqf";
			};

			sleep 1;
		};

		_leader = (units _group) select 0;
		if ( !isPlayer _leader) then
		{
			_groups = groupMatrix select _si;
			_groupsAI = groupAiMatrix select _si;

			if (!(_group in _groupsAI)) then
			{
				_groupsAI set [count _groupsAI, _groups select _gi];
				publicVariable "groupAiMatrix";
			};

			_nul = [_si, _gi] execVM "Server\Info\GroupIsAI.sqf";

			if (_group == (groupCommander select _si)) then
			{
				diag_log format["New Commander: _group=%1, _si=%2, _gi=%3", _group, _si, _gi];

				_unit = _leader;
				_vehicle = vehicle _unit;

				if (alive _unit && _unit != _vehicle) then
				{
					unassignVehicle _unit;
					_unit action ["EJECT", _vehicle];
				};

				if (_si == siWest ) then
				{
					{
						unassignVehicle _x;
						_x action ["EJECT", mhqWest];
					}foreach (crew mhqWest);
				};

				if (_si == siEast) then
				{
					{
						unassignVehicle _x;
						_x action ["EJECT", mhqEast];
					}foreach (crew mhqEast);
				};

				if ( (lockMHQ select _si) == 0 ) then
				{
					lockMHQ set [_si, 1];
					publicVariable "lockMHQ";
				};
			};

			_nul = [_leader, _si, _gi] spawn scriptInitLeaderAi;

		};
	};
};