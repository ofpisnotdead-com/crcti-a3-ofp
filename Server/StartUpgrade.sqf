// args: [upg, si]

_upg = _this select 0;
_si = _this select 1;

_controlCenters = [_si, stComm] call funcGetWorkingStructures;

if ( (count _controlCenters) > 0 && (((upgMatrix select _si) select _upg) select 3) == 0 ) then
{

	_gi = [groupCommander select _si, groupMatrix select _si] call funcGetIndex;

	if (_gi != -1) then
	{

		_minutes = ((upgMatrix select _si) select _upg) select 2;
		_cost = ((upgMatrix select _si) select _upg) select 1;
		_money = (groupMoneyMatrix select _si) select _gi;

		if ( CRCTIDEBUG ) then { _minutes = 0.1; };
		
		if (_money >= _cost) then
		{

			[_si, _gi, _cost] call funcMoneySpend;

			_u = (upgMatrix select _si) select _upg;
			_u set [3, 1];
			(upgMatrix select _si) set [_upg, _u];

			_nul = [_si, _upg, 1] execVM "Server\Info\UpgState.sqf";

			_timeStart = time;
			while {time < (_timeStart + 60*_minutes)}do
			{

				sleep 5;
				_controlCenters = [_si, stComm] call funcGetWorkingStructures;

				if ((count _controlCenters) == 0) exitWith
				{
					_u = (upgMatrix select _si) select _upg;
					_u set [3, 0];
					(upgMatrix select _si) set [_upg, _u];

					_nul = [_si, _upg, 0] execVM "Server\Info\UpgState.sqf";
				};

			};

			_controlCenters = [_si, stComm] call funcGetWorkingStructures;
			if ((count _controlCenters) > 0) then
			{
				_u = (upgMatrix select _si) select _upg;
				_u set [3, 2];
				(upgMatrix select _si) set [_upg, _u];

				_nul = [_si, _upg, 2] execVM "Server\Info\UpgState.sqf";
			};
		};
	};
};