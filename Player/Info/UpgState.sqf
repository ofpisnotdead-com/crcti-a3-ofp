// args: [params]

_upg = _this select 1;
_state = _this select 2;
_si = _this select 3;

_u = (upgMatrix select _si) select _upg;
_u set [3, _state];
(upgMatrix select _si) set [_upg, _u];

if (_si == playerSideIndex) then
{
	if (_state == 1) then
	{
		[format ["Upgrade Started: %1", ((upgMatrix select _si) select _upg) select 0], false, true, htGeneral, false] call funcHint;
	};
	if (_state == 2) then
	{
		[format ["Upgrade Complete: %1", ((upgMatrix select _si) select _upg) select 0], false, true, htGeneral, false] call funcHint;
	};
};

